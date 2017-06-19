//
//  ListLocationSelectionController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef ListLocationSelectionController_h
#define ListLocationSelectionController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** ListLocationSelection Controller manages a list (implemented as a tableview) of locations of interest organized by category (e.g. Coffee Shops, Convenience Stores, Korean Barbecue, etc.); Users can select a row from the table when choosing starting/ending locations for route-finding; A .plist file acts as a data source for populating the table view; said .plist file is also used to initialize the MKAnnotation instances that are added to the MapView used in other parts of the app **/

@interface ListLocationSelectionController : UITableViewController

@end

#endif /* ListLocationSelectionController_h */
