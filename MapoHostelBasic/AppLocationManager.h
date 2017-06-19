//
//  AppLocationManager.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef AppLocationManager_h
#define AppLocationManager_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppLocationManager : CLLocationManager<CLLocationManagerDelegate>

+ (id) sharedManager;

-(void) requestAuthorizationForAllRunningStates:(BOOL)canAccessLocationServicesInBackground;

- (void) startStandardLocationServiceUpdates;

- (void) registerLocationObserver:(UIViewController*)locationObserver;




@end

#endif /* AppLocationManager_h */
