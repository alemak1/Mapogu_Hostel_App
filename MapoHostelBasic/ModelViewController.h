//
//  ModelViewController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef ModelViewController_h
#define ModelViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataViewController.h"

@interface ModelViewController : NSObject<UIPageViewControllerDataSource>

- (NSArray<DataViewController *>*) getAllViewControllers;

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end
#endif /* ModelViewController_h */
