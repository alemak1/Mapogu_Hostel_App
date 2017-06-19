//
//  UserLocationViewController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef UserLocationViewController_h
#define UserLocationViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "AppLocationManager.h"

@interface UserLocationViewController : UIViewController

@property (strong) AppLocationManager* locationManager;

@property UILabel* locationLabel;


@end

#endif /* UserLocationViewController_h */


/** 
 Hostel Location:
 
 FROM ROOM NO1:
 
 2017-06-17 14:40:19.106469 MapoHostelBasic[846:54488] The last updated location is 
    latitude: 37.541593, longitude: 126.952866
 2017-06-17 14:40:19.134401 MapoHostelBasic[846:54488] The last updated location is 
    latitude: 37.541593, longitude: 126.952866
 2017-06-17 14:40:19.135345 MapoHostelBasic[846:54488] The last updated location is 
    latitude: 37.541593, longitude: 126.952866
 2017-06-17 14:40:19.146379 MapoHostelBasic[846:54488] The last updated location is 
    latitude: 37.541610, longitude: 126.952580
 2017-06-17 14:40:19.147395 MapoHostelBasic[846:54488] The last updated location is 
    latitude: 37.541593, longitude: 126.952866
 2017-06-17 14:40:19.148128 MapoHostelBasic[846:54488] The last updated location is 
    latitude: 37.541629, longitude: 126.952345
 2017-06-17 14:40:19.296749 MapoHostelBasic[846:54488] The last updated location is 
    latitude: 37.541653, longitude: 126.952931

 **/
