//
//  TouristLocationSelectionContainingController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristLocationSelectionContainingController.h"
#import "TouristLocationTableViewController.h"

@interface TouristLocationSelectionContainingController ()


@property UITabBar* optionsTabBar;
@property UIView* containingView;

@end

@implementation TouristLocationSelectionContainingController

-(void)viewWillLayoutSubviews{
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    self.optionsTabBar = [[UITabBar alloc] init];
    self.optionsTabBar.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.optionsTabBar];
    
    NSArray<NSLayoutConstraint*>* optionsTabBarConstraints = [NSArray arrayWithObjects:
        [[self.optionsTabBar topAnchor] constraintEqualToAnchor:[self.view topAnchor]],
        [[self.optionsTabBar widthAnchor] constraintEqualToAnchor:[self.view widthAnchor]],
        [[self.optionsTabBar centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]], nil];
    
    [NSLayoutConstraint activateConstraints:optionsTabBarConstraints];
    
    self.containingView = [[UIView alloc] init];
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.containingView];
    
    NSArray<NSLayoutConstraint*>* containingViewConstraints = [NSArray arrayWithObjects:
        [[self.containingView topAnchor] constraintEqualToAnchor:[self.optionsTabBar bottomAnchor]],
        [[self.containingView widthAnchor] constraintEqualToAnchor:[self.view widthAnchor]],
        [[self.containingView centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]],
        nil];
    
    [NSLayoutConstraint activateConstraints:containingViewConstraints];
 
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    
    TouristLocationTableViewController* touristLocationTableViewController = [[TouristLocationTableViewController alloc] init];
    
    [self addChildViewController:touristLocationTableViewController];
    
    [self.containingView addSubview:touristLocationTableViewController.view];
    
    touristLocationTableViewController.view.frame = self.containingView.bounds;
    
    
    [touristLocationTableViewController didMoveToParentViewController:self];
}



@end
