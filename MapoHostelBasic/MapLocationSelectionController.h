//
//  MapLocationSelectionController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef MapLocationSelectionController_h
#define MapLocationSelectionController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

/** The MapLocationSelector controller enables users to select a location from a map, either by selecting an annotation displayed in the map view, or by navigating to a portion of the map that contains a point of interest;  if an annotation is not selected, the center coordinate of the currently-displayed region is used to provide latitude,longitude data; This view controller is display modally as popover for other view controllers ; the selected location data is used by the presenting view controller to initialize a MKDirectionsRequest **/

@interface MapLocationSelectionController : UIViewController<MKMapViewDelegate>

@end

#endif /* MapLocationSelectionController_h */
