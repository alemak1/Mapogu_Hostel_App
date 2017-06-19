//
//  AppLocationManager.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppLocationManager.h"


@interface AppLocationManager ()

@property CLLocation* mostRecentLocation;

@property CLAuthorizationStatus authorizationStatus;

@property (readonly) BOOL locationServicesAreAuthorized;
@property (readonly) BOOL locationServicesEnabled;
@property (readonly) BOOL significantLocationChangeMonitoringAvailable;
@property (readonly) BOOL monitoringForGeographicRegionsAvailable;

@property (readonly) NSString* debugAuthorizationStatus;

@end

@implementation AppLocationManager

/** Private ivar for storing most recently updated location data **/
CLLocation* _lastUpdatedLocation;
UIViewController* _locationObserver;

/** Singleton instance and other initializers **/

+ (id) sharedManager{
    static AppLocationManager* userAppLocationManager = nil;
    static dispatch_once_t once_token;
    
    dispatch_once(&once_token, ^{
    
        userAppLocationManager = [[AppLocationManager alloc]init];
    });
    
    return userAppLocationManager;
}


- (id) init{
    
    self = [super init];
    
    if(self != nil){
        
        [self setAuthorizationStatus:kCLAuthorizationStatusNotDetermined];
        [self setDelegate: self];
        
        CLLocationDistance minDistanceForLocationUpdate = 3.00;
        CLLocationAccuracy locationAccuracy = 3.00;
        
        [self setDistanceFilter:minDistanceForLocationUpdate];
        [self setDesiredAccuracy:locationAccuracy];
        
        /** Register properties for KVO **/
        
        [self addObserver:self forKeyPath:@"authorizationStatus" options:NSKeyValueObservingOptionNew context:nil];
    
    }
    
    return self;
}

/** Public interface methods **/

-(void) requestAuthorizationForAllRunningStates:(BOOL)canAccessLocationServicesInBackground{
    
    if(canAccessLocationServicesInBackground){
        [self requestAlwaysAuthorization];
    }else{
        [self requestWhenInUseAuthorization];
    }
}


/** Wrapper function for startUpdatingLocation: function that performs hardware compatibility and authorization checks **/

- (void) startStandardLocationServiceUpdates{
    
    if([self locationServicesAreAuthorized] && [self locationServicesEnabled]){
        
        [self startUpdatingLocation];
    }
    
}

- (void) registerLocationObserver:(UIViewController*)locationObserver{
    
    [self addObserver:locationObserver forKeyPath:@"mostRecentLocation" options:NSKeyValueObservingOptionNew context:nil];
}


/** CLLocationManager Delegate Methods **/

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation * lastLocationFromLocationsArray = [locations lastObject];
    
    if(lastLocationFromLocationsArray){
        
        _lastUpdatedLocation = lastLocationFromLocationsArray;
        _mostRecentLocation = lastLocationFromLocationsArray;
        
        CLLocationCoordinate2D lastUpdatedCoordinate = [_lastUpdatedLocation coordinate];
        
        CLLocationDegrees latitude = lastUpdatedCoordinate.latitude;
        CLLocationDegrees longitute = lastUpdatedCoordinate.longitude;
        
        NSLog(@"The last updated location is latitude: %f, longitude: %f", latitude, longitute);


    }
    
    
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
}



-(void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    [self setAuthorizationStatus:status];
    
}



-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"authorizationStatus"]){
        NSLog(@"The authorization status has changed to %@",[self debugAuthorizationStatus]);
        
        if([self authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
            NSLog(@"Starting updates for location...");
            [self startUpdatingLocation];
        }
    }
}


/** Utility function for getting authorization-string from the authorization enum value **/

-(NSString*)debugAuthorizationStatus{
    
    switch ([self authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            return @"notDetermined";
        case kCLAuthorizationStatusDenied:
            return @"denied";
        case kCLAuthorizationStatusRestricted:
            return @"restricted";
        case kCLAuthorizationStatusAuthorizedAlways:
            return @"authorizedAlways";
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return @"authorizedWhenInUse";
        default:
            return @"Failed to determined authorization status";
    }
}


/** Utility function for retrieving authorization status and availability of different location services from the CLLocationManager singleton instance **/

- (BOOL)locationServicesAreAuthorized{
    return [AppLocationManager authorizationStatus];
}


- (BOOL) locationServicesEnabled{
    return [AppLocationManager locationServicesEnabled];
}

- (BOOL) significantLocationChangeMonitoringAvailable{
    return [AppLocationManager significantLocationChangeMonitoringAvailable];
    
}

- (BOOL) monitoringForGeographicRegionsAvailable{
    return [AppLocationManager isMonitoringAvailableForClass:[CLRegion class]];
}



/** Perform necessary deinitialization and cleanup; remove registered KV-Observers **/

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"authorizationStatus"];
    [self removeObserver:_locationObserver forKeyPath:@"mostRecentLocation"];
}

@end


/**   AUTHORIZATION STATES:
 
 case notDetermined: The user has not yet made a choice regarding whether this app can use location services.
 
 case restricted: This app is not authorized to use location services.
 
 case denied: The user explicitly denied the use of location services for this app or location services are currently disabled in Settings.
 
 static var authorized: CLAuthorizationStatus: This app is authorized to use location services.
 
 case authorizedAlways: This app is authorized to start location services at any time.
 
 case authorizedWhenInUse: This app is authorized to start most location services while running in the foreground.

**/
