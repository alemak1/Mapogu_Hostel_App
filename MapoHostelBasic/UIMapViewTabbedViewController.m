//
//  UIMapViewTabbedViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIMapViewTabbedViewController.h"

@implementation UIMapViewTabbedViewController

-(id)initWithFirstRootViewController:(TouristLocationMapViewController*)firstViewController{
    
    self = [self init];
    
    if(self){
        
        _firstViewController = firstViewController;
        
    }
    
    return self;
}

-(instancetype)init{
    self = [super init];
    
    return self;
}

-(void)viewWillLayoutSubviews{
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

-(void)viewDidLoad{
    
    
}

@end
