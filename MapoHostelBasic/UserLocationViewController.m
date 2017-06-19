//
//  UserLocationViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "UserLocationViewController.h"

@interface UserLocationViewController ()


@end

@implementation UserLocationViewController


- (void) viewWillLayoutSubviews{
    
    [[AppLocationManager sharedManager] requestAuthorizationForAllRunningStates:NO];
    
    [[AppLocationManager sharedManager] registerLocationObserver:self];
    
    [[AppLocationManager sharedManager] startStandardLocationServiceUpdates];
    
    /** Register properties for KVO **/
    
    [self addObserver:self forKeyPath:@"" options:NSKeyValueObservingOptionNew context:nil];
    
    /**
    [_locationLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [_locationLabel setText:@"Updated location data..."];
    [_locationLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold " size:30.00]];
    
    [self.view addSubview:_locationLabel];
    **/
    
    /**
    CGRect labelRect = CGRectInset([self.view bounds], 20.0, 20.0);
    [_locationLabel setFrame:labelRect];
     **/
    
    /**
    [NSLayoutConstraint activateConstraints:@[
            [[_locationLabel centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]],
            [[_locationLabel centerYAnchor] constraintEqualToAnchor:[self.view centerYAnchor]],
                                            ]];
     **/
    
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    
    
}


-(void) viewDidLoad{
    
    
}

-(void) didReceiveMemoryWarning{
    
    
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"mostRecentLocation"] && [object isKindOfClass:[AppLocationManager class]]){
        
        if((NSUInteger)[change valueForKey:NSKeyValueChangeKindKey] == NSKeyValueChangeSetting){
            
            CLLocation* mostRecentLocation = [change valueForKey:NSKeyValueChangeNewKey];
            
            CLLocationCoordinate2D locationCoordinate = [mostRecentLocation coordinate];
            
            CLLocationDegrees latitude = locationCoordinate.latitude;
            CLLocationDegrees longitude = locationCoordinate.longitude;
            
            [_locationLabel setText:[NSString stringWithFormat:@"Latitude: %f, Longitude: %f",latitude,longitude]];

        }
        
    }
}




-(void) dealloc{
    
}

@end

