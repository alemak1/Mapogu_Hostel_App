//
//  DirectionRequestController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef DirectionRequestController_h
#define DirectionRequestController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DirectionRequestController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *startingLocationMapView;

@property (weak, nonatomic) IBOutlet MKMapView *destinationLocationMapView;

@end

#endif /* DirectionRequestController_h */
