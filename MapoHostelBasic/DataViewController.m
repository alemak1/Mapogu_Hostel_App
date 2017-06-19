//
//  DataViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataViewController.h"

@interface DataViewController ()

@property (readonly,strong,nonatomic) UIImage* displayImage;

@end


@implementation DataViewController


-(void) viewDidLoad{
   
}

-(void) viewWillAppear:(BOOL)animated{
    
    if([self displayImage]){
        [_displayImageView setImage:[self displayImage]];
    }
}

-(void) didReceiveMemoryWarning{
    
    
}

-(UIImage*)displayImage{
    
    
    /** Check that the current image name is set and then validate the current image name using a hard-coded array with acceptable, pre-defined image names **/
    
    if(![self displayImageName]){
        return nil;
    }
    
    UIImage* displayImage = [UIImage imageNamed:[self displayImageName]];
    
    return displayImage;
}





@end
