//
//  ModelViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelViewController.h"


@interface ModelViewController ()

@property (readonly, strong, nonatomic) NSArray<NSString*>* validImageNames;

@end

@implementation ModelViewController


@synthesize validImageNames = _validImageNames;

- (NSArray<DataViewController *>*) getAllViewControllers{
    
    NSMutableArray<DataViewController*>* viewControllers;
    
    for(int idx = 0; idx < self.validImageNames.count; idx++){
        DataViewController* viewController = [self viewControllerAtIndex:idx storyboard:[UIStoryboard storyboardWithName:@"Main" bundle:nil]];
        
        [viewControllers addObject:viewController];
    }
    
    return [NSArray arrayWithArray:viewControllers];
}




//Helper functions useful for implementing the required data source methods

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard{
    
    if (([self.validImageNames count] == 0) || (index >= [self.validImageNames count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.displayImageName = self.validImageNames[index];
    return dataViewController;
    
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController{
    return [_validImageNames indexOfObject:[viewController displayImageName]];

    
}


- (NSArray<NSString *> *)validImageNames{
    
    return [NSArray arrayWithObjects:@"hostel_1",@"hostel_2",@"hostel_3",@"hostel_4",@"hostel_5",@"hostel_6",@"hostel_7",@"hostel_8",@"hostel_9", nil];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.validImageNames count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];

    
}


@end
