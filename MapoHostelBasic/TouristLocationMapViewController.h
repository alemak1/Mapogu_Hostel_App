//
//  TouristLocationMapViewController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef TouristLocationMapViewController_h
#define TouristLocationMapViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PlacemarkConfiguration.h"

@interface TouristLocationMapViewController : UIViewController<MKMapViewDelegate>

-(id) initWithPlacemarkConfiguration:(PlacemarkConfiguration*)placemarkConfiguration;

@property PlacemarkConfiguration* placemarkConfiguration;

@end
#endif /* TouristLocationMapViewController_h */
