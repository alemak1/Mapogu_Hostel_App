//
//  TouristLocationMapViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

#import "TouristLocationMapViewController.h"

@interface TouristLocationMapViewController ()

@property MKMapView* mapView;
@property UIButton* directionsFromHostelButton;
@property UIButton* dismissButton;


@end

@implementation TouristLocationMapViewController

/** Initializers **/

-(id) initWithPlacemarkConfiguration:(PlacemarkConfiguration*)placemarkConfiguration{
    
    self = [self init];
    
    if(self){
        
        _placemarkConfiguration = placemarkConfiguration;
    }
    
    return self;
}

-(instancetype)init{
    self = [super init];
    
    return self;
}


/** ViewController LifeCycle **/

-(void)viewWillLayoutSubviews{
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.00];
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake([self.placemarkConfiguration latitude], [self.placemarkConfiguration longitude]);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.001, 0.001);
    
    self.mapView.region= MKCoordinateRegionMake(centerCoordinate, span);
    
    [self.mapView addAnnotation:self.placemarkConfiguration];
    
    self.mapView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.view addSubview:self.mapView];
    
    NSArray<NSLayoutConstraint*>* mapViewConstraints = [NSArray arrayWithObjects:
        [[self.mapView centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor] constant:0.00],
        [[self.mapView centerYAnchor] constraintEqualToAnchor:[self.view centerYAnchor] constant:0.00],
        [[self.mapView widthAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier:1.0],
        [[self.mapView heightAnchor] constraintEqualToAnchor:[self.view heightAnchor] multiplier:0.80],
        nil];
    
    [NSLayoutConstraint activateConstraints:mapViewConstraints];
    
    
    [self.mapView addAnnotation:[self placemarkConfiguration]];
    
    
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"Preparing to add directions button...");
    
    self.directionsFromHostelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.directionsFromHostelButton setTitle:@"Get Directions From Hostel" forState:UIControlStateNormal];
    [self.directionsFromHostelButton.titleLabel setFont:[UIFont fontWithName:@"Copperplate-Bold" size:20.00]];

    [self.directionsFromHostelButton addTarget:self action:@selector(getDirectionsFromHostel) forControlEvents:UIControlEventTouchUpInside];
    
    self.directionsFromHostelButton.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.view addSubview:self.directionsFromHostelButton];
    
    
    NSArray<NSLayoutConstraint*>* directionButtonConstraints = [NSArray arrayWithObjects:
            [[self.directionsFromHostelButton centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]],
            [[self.directionsFromHostelButton topAnchor] constraintEqualToAnchor:[self.view topAnchor] constant:20.0],
        nil];
    
    [NSLayoutConstraint activateConstraints:directionButtonConstraints];
    
    NSLog(@"Preparing to add dismiss button...");
    
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.dismissButton setTitle:@"Back to Local Sites Directory" forState:UIControlStateNormal];
    [self.dismissButton.titleLabel setFont:[UIFont fontWithName:@"Copperplate-Bold" size:20.00]];
    
    [self.dismissButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    
    self.dismissButton.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.view addSubview:self.dismissButton];
    
    
    NSArray<NSLayoutConstraint*>* dismissButtonConstraints = [NSArray arrayWithObjects:
        [[self.dismissButton centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]],
        [[self.dismissButton bottomAnchor] constraintEqualToAnchor:[self.view bottomAnchor] constant:-20.0],
    nil];
    
    [NSLayoutConstraint activateConstraints:dismissButtonConstraints];
}


-(void)viewDidLoad{
    NSString* placemarkConfigDescription = [[self placemarkConfiguration] description];
    
    NSLog(@"TouristLocationMapViewController Info: %@", placemarkConfigDescription);
    
}


-(void) getDirectionsFromHostel{
    NSLog(@"Getting directions from hostel....");
    
    MKDirectionsRequest *walkingRouteRequest = [[MKDirectionsRequest alloc] init];
    walkingRouteRequest.transportType = MKDirectionsTransportTypeWalking;
    
    CLLocationCoordinate2D hostelLocationCoordinate = CLLocationCoordinate2DMake(37.541593, 126.952866);
    
    MKPlacemark* hostelPlacemark = [[MKPlacemark alloc] initWithCoordinate:hostelLocationCoordinate];
    
    MKMapItem* startPoint = [[MKMapItem alloc] initWithPlacemark:hostelPlacemark];
    
    CGFloat endPointLatitude = [[self placemarkConfiguration] latitude];
    CGFloat endPointLongitude = [[self placemarkConfiguration] longitude];
    
    MKPlacemark* endPointPlacemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(endPointLatitude, endPointLongitude)];
    
    MKMapItem* endPoint = [[MKMapItem alloc] initWithPlacemark:endPointPlacemark];
    
    [walkingRouteRequest setSource:startPoint];
    [walkingRouteRequest setDestination:endPoint];
    
    MKDirections *walkingRouteDirections = [[MKDirections alloc] initWithRequest:walkingRouteRequest];
    [walkingRouteDirections calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * walkingRouteResponse, NSError *walkingRouteError) {
        if (walkingRouteError) {
            [self handleDirectionsError:walkingRouteError];
        } else {
            NSLog(@"Adding calculated route overlay to the map view");
            
            MKRoute* walkingRoute = walkingRouteResponse.routes[0];
            
            NSLog(@"Walking route debug info: %@",[walkingRoute description]);
            
            [self.mapView addOverlay:walkingRoute.polyline level:MKOverlayLevelAboveRoads];
        }
    }];
}


-(void) handleDirectionsError:(NSError*)routeError{
    
}

-(void) dismissViewController{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    PlaceMarkSection placemarkSection = [self.placemarkConfiguration placemarkSection];
    
    NSString* imageName = [self getAnnotationImageNameForPlacemarkSection:placemarkSection];
    
    MKAnnotationView* annotationView = [[MKAnnotationView alloc] init];
    
    annotationView.image = [UIImage imageNamed:imageName];
    
    UILabel* calloutLabel = [[UILabel alloc] init];
    [calloutLabel setText:[[self placemarkConfiguration] name]];
    [calloutLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:15.0]];
    
    
    return annotationView;
}



-(NSString*) getAnnotationImageNameForPlacemarkSection:(PlaceMarkSection)placemarkSection{
    switch (placemarkSection) {
        case KOREAN_BARBECUE:
            return @"barbecueA";
        case COFFEE_SHOPS:
            return @"coffeeA";
        case OTHER_RESTAURANTS:
            return @"otherRestaurantsA";
        case PHARMACY_DRUGSTORE:
            return @"pharmacyA";
        case PHONE_MOBILE_SERVICES:
            return @"phoneA";
        case CONVENIENCE_STORES:
            return @"convenienceStoreA";
        case SPORTS_RECREATION:
            return @"microphoneA";
        default:
            return @"barbecueA";
    }
    
    return nil;
}

/**
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    
}



-(void)mapView:(MKMapView *)mapView didAddOverlayRenderers:(NSArray<MKOverlayRenderer *> *)renderers{
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
}
**/
@end
