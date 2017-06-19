//
//  MainSplitViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainSplitViewController.h"
#import "RoomCollectionViewController.h"
#import "RoomCollectionViewLayout.h"
#import "RoomNameDictionary.h"

@interface MainSplitViewController()

@property (readonly) UISegmentedControl* roomOptionsControl;
@property (readonly) NSArray<NSLayoutConstraint*>* constraintsForRoomOptionsControl;

@property UIView* containerView;
@property (readonly) NSArray<NSLayoutConstraint*>* constraintsForContainerView;

@end

@implementation MainSplitViewController

@synthesize roomOptionsControl = _roomOptionsControl;
@synthesize constraintsForRoomOptionsControl = _constraintsForRoomOptionsControl;

-(void) viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    /** Add and configure segmented control to the main view **/
    
    [[self roomOptionsControl] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:[self roomOptionsControl]];
    [NSLayoutConstraint activateConstraints:[self constraintsForRoomOptionsControl]];

    /** Add and configure the container view to the main view **/
    
    self.containerView = [[UIView alloc] init];
    [self.containerView setBackgroundColor:[UIColor orangeColor]];
    [[self containerView] setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.containerView];
    [NSLayoutConstraint activateConstraints:[self constraintsForContainerView]];
    
    
    /** Add the first child view controller **/
    
    RoomCollectionViewController* roomCollectionViewController = [self getRoomCollectionViewControllerAdjustedForCurrentTraitCollection];
    
    
    [self addChildViewControllerForContainerView: roomCollectionViewController];
    

    

    
}

/** Helper functions for initializing a RoomCollectionViewController with a UICollectionFlowLayout subclass determined dynamically from the current trait collection configuration **/

- (RoomCollectionViewController*) getRoomCollectionViewControllerAdjustedForCurrentTraitCollection{
    
    
    /** Initialize a CollectionViewFlowLayout object based on the current trait collection configuration **/
    
    UICollectionViewLayout* collectionViewLayout;
    
    UITraitCollection* traitCollection = [self traitCollection];
    
    if(traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact){
        
        collectionViewLayout = [[RoomCollectionViewHorizontalLayout alloc] init];
    }
    
    if(traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular){
        collectionViewLayout = [[RoomCollectionViewVerticalLayout alloc] init];
    }
    
    /** Initialize a new Room CollectionViewController **/
    
    RoomCollectionViewController* roomCollectionViewController = [[RoomCollectionViewController alloc]initWithCollectionViewLayout:collectionViewLayout];
    
    [roomCollectionViewController.collectionView setBackgroundColor:[UIColor cyanColor]];
    
    /** Configure data source for the RoomCollectionViewController based on the currently selected index of the Room Options segmented control **/
    
    int currentSelectedIndex = (int)[[self roomOptionsControl] selectedSegmentIndex] + 1;
    
    NSArray* roomNamesArray = [RoomCVCHelperFunctions getRoomNameArrayForRoomNumber:currentSelectedIndex];
    
    [roomCollectionViewController setRoomImageNameArray:roomNamesArray];
    
    return roomCollectionViewController;
}

/** Helper functions for adding a collection view controller subclass to manage the view in the container view **/

- (void) addChildViewControllerForContainerView:(RoomCollectionViewController*)roomCollectionViewController{
    
    [self addChildViewController:roomCollectionViewController];
    
    CGRect collectionViewFrame = self.containerView.bounds;
    
    roomCollectionViewController.view.frame = collectionViewFrame;
    
    [self.containerView addSubview:[roomCollectionViewController view]];
    
    
    [roomCollectionViewController didMoveToParentViewController:self];
    
    
}

- (UISegmentedControl*) roomOptionsControl{
 
    if(_roomOptionsControl == nil){
        _roomOptionsControl = [[UISegmentedControl alloc] init];;
        
        [_roomOptionsControl insertSegmentWithTitle:@"Room 1" atIndex:0 animated:YES];
        [_roomOptionsControl insertSegmentWithTitle:@"Room 2" atIndex:1 animated:YES];
        [_roomOptionsControl insertSegmentWithTitle:@"Room 3" atIndex:2 animated:YES];
        [_roomOptionsControl insertSegmentWithTitle:@"Room 4" atIndex:3 animated:YES];
        [_roomOptionsControl setApportionsSegmentWidthsByContent:YES];
        
        [_roomOptionsControl setSelectedSegmentIndex:0];
    }
    
    return _roomOptionsControl;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
  
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    [self addObserver:self forKeyPath:@"roomOptionsControl.selectedSegmentIndex" options:NSKeyValueObservingOptionNew context:nil];
    
 
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"roomOptionsControl.selectedSegmentIndex"]){
        
        NSLog(@"The selected segment index changed...");
        
        /** Remove the collection view currently being displayed by the child view controller **/
        
        for (UIView* subView in self.containerView.subviews) {
            [subView removeFromSuperview];
        }
        
        RoomCollectionViewController* roomCollectionViewController = [self getRoomCollectionViewControllerAdjustedForCurrentTraitCollection];
        
        [self addChildViewControllerForContainerView:roomCollectionViewController];
        
    }
}

-(void)didReceiveMemoryWarning{
    
    
    
}


-(void) traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    /**
    UITraitCollection* currentTraitCollection = newCollection;
    
    UIUserInterfaceSizeClass currentHorizontalSizeClass = [currentTraitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass currentVerticalSizeClass = [currentTraitCollection verticalSizeClass];
    **/
    
    UITraitCollection* currentTraitCollection = [self traitCollection];
    UIUserInterfaceSizeClass currentHorizontalSizeClass = [currentTraitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass currentVerticalSizeClass = [currentTraitCollection verticalSizeClass];
    
    NSLog(@"Transitioned to horizontal size class: %d, vertical size class: %d",currentHorizontalSizeClass,currentVerticalSizeClass);
    
    
    if(self.roomOptionsControl.superview == nil){
        
        [self.view addSubview:[self roomOptionsControl]];
        
        [NSLayoutConstraint activateConstraints:[self constraintsForRoomOptionsControl]];
        
    }
  
    if(self.containerView.superview == nil){
        
        [self.view addSubview:[self containerView]];
        
        [NSLayoutConstraint activateConstraints:[self constraintsForContainerView]];
        
       
      
    }
    
    
}

-(void) willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    
    
    [NSLayoutConstraint deactivateConstraints:[self constraintsForRoomOptionsControl]];
    [self.view removeConstraints:[self constraintsForRoomOptionsControl]];
    [[self roomOptionsControl] removeFromSuperview];
    
    
    [NSLayoutConstraint deactivateConstraints:[self constraintsForContainerView]];
    [self.view removeConstraints:[self constraintsForContainerView]];
    [[self containerView] removeFromSuperview];
    
   
    
    UITraitCollection* currentTraitCollection = newCollection;
    
    UIUserInterfaceSizeClass currentHorizontalSizeClass = [currentTraitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass currentVerticalSizeClass = [currentTraitCollection verticalSizeClass];
    
    NSLog(@"Transitioned to horizontal size class: %d, vertical size class: %d",currentHorizontalSizeClass,currentVerticalSizeClass);
    
    
    
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
}


#pragma mark ******** CONSTRAINTS / COMPUTED PROPERTY / CONTAINER VIEW

- (NSArray<NSLayoutConstraint*>*)constraintsForContainerView{
    
    /** Constraints can only be accessed unless the segmented control has been allocated and initialized, as well as only after it has been added as a subview to a parent superview and only after the room options segmented control has been added **/
    
    if(self.containerView == nil || self.containerView.superview == nil || self.roomOptionsControl == nil || self.roomOptionsControl.superview == nil){
        NSLog(@"Error: could not configure constraints for container view");
        return nil;
    }
    
    NSLog(@"Preparing to configure constraints for container view.....");
    
    
    
    UITraitCollection* currentTraitCollection = [self traitCollection];
    
    UIUserInterfaceSizeClass currentHorizontalSizeClass = [currentTraitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass currentVerticalSizeClass = [currentTraitCollection verticalSizeClass];
    
    
    //Compact Width, Regular Height
    
    if(currentHorizontalSizeClass == UIUserInterfaceSizeClassCompact && currentVerticalSizeClass == UIUserInterfaceSizeClassRegular){
        
        NSArray<NSLayoutConstraint*>* constraints = [NSArray arrayWithObjects:
                                                     [[self.containerView topAnchor] constraintEqualToAnchor:[self.roomOptionsControl bottomAnchor] constant:30.0],
                                                     [[self.containerView centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]],
                                                     [[self.containerView widthAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier:0.95],
                                                     [[self.containerView heightAnchor] constraintEqualToAnchor:[self.view heightAnchor] multiplier:0.80],
                                                     nil];
        
        NSLog(@"Finished configuring constraints for container view...");
        
        return constraints;
        
    }
    
    //Compact Width, Compact Height
    
    if(currentHorizontalSizeClass == UIUserInterfaceSizeClassCompact && currentVerticalSizeClass == UIUserInterfaceSizeClassCompact){
        
        NSArray<NSLayoutConstraint*>* constraints = [NSArray arrayWithObjects:
                                                     [[self.containerView topAnchor] constraintEqualToAnchor:[self.roomOptionsControl bottomAnchor] constant:20.0],
                                                     [[self.containerView centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor]],
                                                     [[self.containerView widthAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier:0.95],
                                                     [[self.containerView heightAnchor] constraintEqualToAnchor:[self.view heightAnchor] multiplier:0.70],
                                                     nil];
        
        NSLog(@"Finished configuring constraints for container view...");
        
        return constraints;
        
    }
    
    
    return nil;
    
}

#pragma mark ******** CONSTRAINTS - COMPUTED PROPERTY - SEGMENTED CONTROL/ROOM OPTIONS CONTROL

- (NSArray<NSLayoutConstraint*>*)constraintsForRoomOptionsControl{
    
    /** Constraints can only be accessed unless the segmented control has been allocated and initialized, as well as only after it has been added as a subview to a parent superview **/
    if(self.roomOptionsControl == nil || self.roomOptionsControl.superview == nil){
        return nil;
    }
    
    
    
    
    UITraitCollection* currentTraitCollection = [self traitCollection];
    
    UIUserInterfaceSizeClass currentHorizontalSizeClass = [currentTraitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass currentVerticalSizeClass = [currentTraitCollection verticalSizeClass];
    
    
    //Compact Width, Regular Height
    
    if(currentHorizontalSizeClass == UIUserInterfaceSizeClassCompact && currentVerticalSizeClass == UIUserInterfaceSizeClassRegular){
        
        NSArray<NSLayoutConstraint*>* constraintsForCWRH = [NSArray arrayWithObjects:[[_roomOptionsControl topAnchor] constraintEqualToAnchor:[self.view topAnchor] constant: 20.0],
                                                            [[_roomOptionsControl centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor] constant: 0.0],
                                                            [[_roomOptionsControl widthAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier: 0.90],
                                                            [[_roomOptionsControl heightAnchor] constraintEqualToAnchor:[self.view heightAnchor] multiplier: 0.10],
                                                            nil];
        
        return constraintsForCWRH;
        
    }
    
    //Compact Width, Compact Height
    
    if(currentHorizontalSizeClass == UIUserInterfaceSizeClassCompact && currentVerticalSizeClass == UIUserInterfaceSizeClassCompact){
        
        NSArray<NSLayoutConstraint*>* constraintsForCWCH = [NSArray arrayWithObjects:[[_roomOptionsControl topAnchor] constraintEqualToAnchor:[self.view topAnchor] constant: 20.0],
                                                            [[_roomOptionsControl centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor] constant: 0.0],
                                                            [[_roomOptionsControl widthAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier: 0.50],
                                                            [[_roomOptionsControl heightAnchor] constraintEqualToAnchor:[self.view heightAnchor] multiplier: 0.10],
                                                            nil];
        
        
        return constraintsForCWCH;
        
    }
    
    return nil;
    
}


@end
