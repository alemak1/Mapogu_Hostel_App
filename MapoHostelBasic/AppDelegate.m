//
//  AppDelegate.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "UserLocationViewController.h"
#import "MapRouteViewController.h"
#import "ScrollViewController.h"
#import "MainSplitViewController.h"
#import "RoomCollectionViewController.h"
#import "ToHostelDirectionsController.h"
#import "ListLocationSelectionController.h"

@interface AppDelegate ()

typedef enum TESTABLE_VIEWCONTROLLERS{
    LIST_LOCATION_SELECTION_CONTROLLER = 0,
    USER_LOCATION_VIEW_CONTROLLER,
    TO_HOSTEL_DIRECTIONS_CONTROLLER,
    ROOM_COLLECTION_VIEW_CONTROLLER,
    MAP_ROUTE_VIEW_CONTROLLER,
    SCROLL_VIEW_CONTROLLER_FROM_STORYBOARD,
    SCROLL_VIEW_CONTROLLER_NON_STORYBOARD,
    MAIN_SPLIT_VIEW_CONTROLLER
} TESTABLE_VIEWCONTROLLERS;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];

    UIViewController* rootViewController = [self getTestableViewController:TO_HOSTEL_DIRECTIONS_CONTROLLER];
    
    [self.window setRootViewController:rootViewController];
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


/** Implement this method in case user selects the current app from the Maps App to process a directions request **/

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([MKDirectionsRequest isDirectionsRequestURL:url]) {
        MKDirectionsRequest* directionsInfo = [[MKDirectionsRequest alloc] initWithContentsOfURL:url];
        // TO DO: Plot and display the route using the
        //   source and destination properties of directionsInfo.
        
        /**
        MKMapItem* sourceItem = [directionsInfo source];
        MKMapItem* destinationItem = [directionsInfo destination];
        **/
        
        return YES;
    }
    else {
        // Handle other URL types...
    }
    return NO;
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MapoHostelBasic"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

/** Utility function to allow for quick toggling among view controller for testing/debugging**/

-(UIViewController*) getTestableViewController:(TESTABLE_VIEWCONTROLLERS)testableViewControllerType{
    
    UIViewController* testableViewController = nil;
    
    UICollectionViewFlowLayout* layoutObject;
    
    UIStoryboard* mainStoryBoard;
    
    NSString* path;
    NSArray* contentList;
    
    if(testableViewControllerType == SCROLL_VIEW_CONTROLLER_NON_STORYBOARD || testableViewControllerType == SCROLL_VIEW_CONTROLLER_FROM_STORYBOARD){
        
        path = [[NSBundle mainBundle] pathForResource:@"contentList" ofType:@"plist"];
        
        contentList = [NSArray arrayWithContentsOfFile:path];
        
        NSLog(@"plist loaded %@",[contentList description]);
    }
    
    switch (testableViewControllerType) {
        case LIST_LOCATION_SELECTION_CONTROLLER:
            testableViewController = [[ListLocationSelectionController alloc] init];
            break;
        case USER_LOCATION_VIEW_CONTROLLER:
            testableViewController = [[UserLocationViewController alloc] init];
            break;
        case TO_HOSTEL_DIRECTIONS_CONTROLLER:
            testableViewController = [[ToHostelDirectionsController alloc] init];
            break;
        case ROOM_COLLECTION_VIEW_CONTROLLER:
            layoutObject = [[UICollectionViewFlowLayout alloc]init];
            
            [layoutObject setScrollDirection:UICollectionViewScrollDirectionVertical];
            [layoutObject setItemSize:CGSizeMake(300, 200)];
            [layoutObject setHeaderReferenceSize:CGSizeMake(300, 70)];
            [layoutObject setFooterReferenceSize:CGSizeMake(300, 70)];
            [layoutObject setMinimumLineSpacing:30];
            [layoutObject setMinimumInteritemSpacing:30];
            
            testableViewController = [[RoomCollectionViewController alloc]initWithCollectionViewLayout:layoutObject];
            
            [testableViewController.view setBackgroundColor:[UIColor cyanColor]];
            break;
        case MAP_ROUTE_VIEW_CONTROLLER:
            testableViewController = [[MapRouteViewController alloc] init];
            [testableViewController.view setBackgroundColor:[UIColor orangeColor]];
            break;
        case SCROLL_VIEW_CONTROLLER_FROM_STORYBOARD:
            mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            testableViewController = (ScrollViewController*)[mainStoryBoard instantiateViewControllerWithIdentifier:@"ScrollViewController"];
            break;
        case SCROLL_VIEW_CONTROLLER_NON_STORYBOARD:
            testableViewController = [[ScrollViewController alloc] init];
            break;
        case MAIN_SPLIT_VIEW_CONTROLLER:
            testableViewController = [[MainSplitViewController alloc]init];
            break;
        default:
            break;
    }
    
    return testableViewController;
}

@end
