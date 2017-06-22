//
//  UIMapViewTabbedViewController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef UIMapViewTabbedViewController_h
#define UIMapViewTabbedViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TouristLocationMapViewController.h"

@interface UIMapViewTabbedViewController : UITabBarController

-(id)initWithFirstRootViewController:(TouristLocationMapViewController*)firstViewController;

@property TouristLocationMapViewController* firstViewController;

@end

#endif /* UIMapViewTabbedViewController_h */
