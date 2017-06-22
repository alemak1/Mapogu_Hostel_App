//
//  DirectionsMenuController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DirectionsMenuController.h"

#import "TouristLocationSelectionNavigationController.h"
#import "TouristLocationTableViewController.h"
#import "LocationSearchController.h"
#import "ToHostelDirectionsController.h"

@interface DirectionsMenuController ()

typedef enum VALID_NEXT_VIEW_CONTROLLER{
    TOURIST_LOCATION_TABLEVIEW_CONTROLLER = 0,
    LOCATION_SEARCH_CONTROLLER,
    TO_HOSTEL_DIRECTIONS_CONTROLLER,
    LAST_VIEW_CONTROLLER
}VALID_NEXT_VIEW_CONTROLLER;

@property (weak, nonatomic) IBOutlet UIImageView *selectionBarImage;
@property (readonly) CGFloat titleFontSize;
@property VALID_NEXT_VIEW_CONTROLLER currentNextViewController;

- (IBAction)dismissViewController:(id)sender;

- (IBAction)showSelectedViewController:(UIButton *)sender;


@end

@implementation DirectionsMenuController

@synthesize titleFontSize = _titleFontSize;

-(void)viewWillLayoutSubviews{
    
    [self.pickerControl setDelegate:self];
    [self.pickerControl setDataSource:self];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    
}

#pragma mark UIPICKER VIEW DELEGATE AND DATASOURCE METHODS

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    CGFloat componentWidth = self.selectionBarImage.bounds.size.width;
    
    return componentWidth;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    CGFloat rowHeight = self.selectionBarImage.bounds.size.height;
    
    return rowHeight;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return LAST_VIEW_CONTROLLER;
}



-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.currentNextViewController = (int)row;
}

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString* mainText = [self getNextViewControllerTitleFor:(int)row];
    
    NSMutableAttributedString*attributedTitle = [[NSMutableAttributedString alloc] initWithString:mainText];
    
    [attributedTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Book" size:[self titleFontSize]] range:NSMakeRange(0, [mainText length])];
    
    return attributedTitle;
}

-(CGFloat)titleFontSize{
    
    if(!_titleFontSize){
    
        UITraitCollection *currentTraitCollection = [self traitCollection];
        UIUserInterfaceSizeClass horizontalSC = [currentTraitCollection horizontalSizeClass];
        UIUserInterfaceSizeClass verticalSC = [currentTraitCollection verticalSizeClass];
    
        BOOL CW_CH = (horizontalSC == UIUserInterfaceSizeClassCompact && verticalSC == UIUserInterfaceSizeClassCompact);
    
        BOOL CW_RH = (horizontalSC == UIUserInterfaceSizeClassCompact && verticalSC == UIUserInterfaceSizeClassRegular);
    
        BOOL RW_CH = (horizontalSC == UIUserInterfaceSizeClassRegular && verticalSC == UIUserInterfaceSizeClassCompact);
    
        BOOL RW_RH = (horizontalSC == UIUserInterfaceSizeClassRegular && verticalSC == UIUserInterfaceSizeClassRegular);
    
        _titleFontSize = 20.0;
        
        if(CW_CH){
            return 20.0;
        }
    
        if(CW_RH){
            return 20.0;
        }
    
        if(RW_CH){
            return 50.0;
        
        }
    
        if(RW_RH){
            return 50.0;
        }
    
    
    }
    
    return _titleFontSize;
}

- (IBAction)dismissViewController:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showSelectedViewController:(UIButton *)sender {
    
    UIViewController* nextViewController;
    
    UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            
    switch (self.currentNextViewController) {
        case TOURIST_LOCATION_TABLEVIEW_CONTROLLER:
            nextViewController = [self getNavigationControllerForTouristLocationTableViewController];
            break;
        case TO_HOSTEL_DIRECTIONS_CONTROLLER:
            nextViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ToHostelDirectionsController"];
            break;
        case LOCATION_SEARCH_CONTROLLER:
            nextViewController = [mainStoryBoard instantiateViewControllerWithIdentifier:@"LocationSearchController"];
            break;
        default:
            break;
    }
    
    [self showViewController:nextViewController sender:nil];
}

- (UINavigationController*) getNavigationControllerForTouristLocationTableViewController{
    
    UINavigationController* navigationController = [[TouristLocationSelectionNavigationController alloc] initWithRootViewController:[[TouristLocationTableViewController alloc] init]];
    

    
    return navigationController;
}

-(NSString*)getNextViewControllerTitleFor:(VALID_NEXT_VIEW_CONTROLLER)validNextViewController{
    
    switch (validNextViewController) {
        case TO_HOSTEL_DIRECTIONS_CONTROLLER:
            return @"Get Directions To Hostel";
        case TOURIST_LOCATION_TABLEVIEW_CONTROLLER:
            return @"Get Directions to Recommended Places Nearby";
        case LOCATION_SEARCH_CONTROLLER:
            return @"Search for Locations Nearby";
    }
    
    return nil;
}

@end
