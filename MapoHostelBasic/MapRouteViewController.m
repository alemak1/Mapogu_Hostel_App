//
//  MapRouteViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapRouteViewController.h"

@implementation MapRouteViewController


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

-(void) viewWillLayoutSubviews{
    
    self.mainMapView = [[MKMapView alloc] init];
    
    [self.mainMapView setDelegate:self];
    [self.mainMapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    CLLocationCoordinate2D defaultCenterCoordinate = CLLocationCoordinate2DMake(37.5415, 126.9528);
    
    //1,000 x 1,000 m bounding region
    
    MKCoordinateRegion defaultRegion = MKCoordinateRegionMakeWithDistance(defaultCenterCoordinate, 500, 500);
    
    [self.mainMapView setRegion:defaultRegion];
   
    
    /** SETTING THE RECT PROPERTY NOT WORKING
     
    CGRect mapViewRect = CGRectInset(self.view.bounds, 0.00, 50.00);
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        mapViewRect = CGRectInset(self.view.bounds, 50.0, 50.0);
    }
    
    
    [self.mainMapView setFrame:mapViewRect];
    **/
    
    [self.view addSubview:self.mainMapView];
    
    
    UIInterfaceOrientation currentOrientation = [[UIDevice currentDevice] orientation];
    CGFloat widthMultiplier = 0.00;
    CGFloat heightMultiplier = 0.00;
    
    if(UIInterfaceOrientationIsPortrait(currentOrientation)){
         widthMultiplier = 0.95;
         heightMultiplier = 0.50;
    }
    
    if(UIInterfaceOrientationIsLandscape(currentOrientation)){
        widthMultiplier = 0.50;
        heightMultiplier = 0.95;

    }
    
    NSArray<NSLayoutConstraint*>* constraints = [NSArray arrayWithObjects:
        [[self.mainMapView centerYAnchor] constraintEqualToAnchor:[self.view centerYAnchor]],
        [[self.mainMapView centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]],
        [[self.mainMapView widthAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier:widthMultiplier],
        [[self.mainMapView heightAnchor]constraintEqualToAnchor:[self.view heightAnchor] multiplier:heightMultiplier], nil];
    
    [NSLayoutConstraint activateConstraints: constraints];
    
    
}


- (void) viewDidLoad{
    //Ina's Hostel
    
  
    
}

-(void) orientationChanged:(NSNotification*)notification{
    
    [self.mainMapView removeFromSuperview];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    //[self adjustViewsForOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
}

-(void) adjustViewsForOrientation:(UIInterfaceOrientation)orientation{
    
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            //load portrait view
            NSLog(@"Device changed to portrait view...");
           // [self.view layoutIfNeeded];
        }
            
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            //load the landscape view
            NSLog(@"Device changed to landscape view...");
            //[self.view layoutIfNeeded];

        }
            break;
        case UIInterfaceOrientationUnknown:break;
    }
}

#pragma MKMAPVIEW DELEGATE METHODS


-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
}


-(void) mapViewWillStartLocatingUser:(MKMapView *)mapView{
    
}

-(void) mapViewDidStopLocatingUser:(MKMapView *)mapView{
    
    
}

- (void) mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
    
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    
    
}


- (void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    
}



@end
