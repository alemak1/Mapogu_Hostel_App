//
//  MapLocationSelectionController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapLocationSelectionController.h"


@interface MapLocationSelectionController ()

@property (weak, nonatomic) IBOutlet MKMapView *locationSelectorMap;

@property (weak, nonatomic) IBOutlet UILabel *currentlyDisplayedLatitude;

@property (weak, nonatomic) IBOutlet UILabel *currentlyDisplayedLongitude;


@end

@implementation MapLocationSelectionController

-(void)viewWillAppear:(BOOL)animated{
  
    [[self locationSelectorMap] setDelegate:self];
    [[self locationSelectorMap] setZoomEnabled:YES];
    [[self locationSelectorMap] setScrollEnabled:YES];
    
    //TODO: Add annotation objects...
}

-(void)viewDidLoad{
    
}



-(void)dealloc{
}

#pragma mark MKMAPVIEW DELEGATE METHODS

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"Annotation view selected...");
    
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"Region did change...");
    
    NSLog(@"The center coordinate changed...");
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setMinimumFractionDigits:4];
    [numberFormatter setMinimumFractionDigits:6];
    
    CLLocationCoordinate2D mapCenterCoordinate = [mapView centerCoordinate];
    
    NSString* latitudeString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:mapCenterCoordinate.latitude]];
    
    NSString* longtiudeString = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:mapCenterCoordinate.longitude]];
    
    [[self currentlyDisplayedLatitude] setText:latitudeString];
    [[self currentlyDisplayedLongitude] setText:longtiudeString];

}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    NSLog(@"Finished loading map...");

}

@end
