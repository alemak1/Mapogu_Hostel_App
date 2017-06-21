//
//  IntroViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/20/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroViewController.h"


@interface IntroViewController ()

@property UIVisualEffectView* trayView;
@property NSLayoutConstraint* trayLeftEdgeConstraint;

@property UIImageView* imageView;
@property UIDynamicAnimator* animator;
@property UIStackView* menuStackView;

/** Behaviors to be added to the dynamic animator **/

@property UICollisionBehavior* edgeCollisionBehavior;
@property UIGravityBehavior* gravityBehavior;
@property UIAttachmentBehavior* attachmentBehavior;

@end



@implementation IntroViewController


static CGFloat const GUTTER_WIDTH = 100.0;
static BOOL gravityIsLeft = NO;

@synthesize imageView = _imageView;
@synthesize trayView = _trayView;
@synthesize trayLeftEdgeConstraint = _trayLeftEdgeConstraint;
@synthesize attachmentBehavior = _attachmentBehavior;
@synthesize animator = _animator;

-(void)viewWillLayoutSubviews{
    NSLog(@"Preparing to layout subviews for IntroViewController....");
    
    self.view.backgroundColor = [UIColor colorWithRed:232.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.00];
    
 
   
    
   
}

-(void) setupBackgroundImageView{
    
    [self.view addSubview:self.imageView];
    
    NSArray<NSLayoutConstraint*>* imageViewConstraints = [NSArray arrayWithObjects:
        [[self.imageView topAnchor] constraintEqualToAnchor:[self.view topAnchor]],
        [[self.imageView leftAnchor] constraintEqualToAnchor:[self.view leftAnchor]],
        [[self.imageView rightAnchor] constraintEqualToAnchor:[self.view rightAnchor]],
        [[self.imageView bottomAnchor]constraintEqualToAnchor:[self.view bottomAnchor]],
                                                          nil];
    
    
    
    [NSLayoutConstraint activateConstraints: imageViewConstraints];
    
    UILabel* swipeLabel = [[UILabel alloc] init];
    [swipeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageView addSubview:swipeLabel];
    
    [swipeLabel setText:@"Come inside! Swipe from the right edge to open..."];
    [swipeLabel setFont:[UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:40.00]];
    [swipeLabel setTextColor:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:200/255.0 alpha:1.00]];
    [swipeLabel setNumberOfLines:0];
    [swipeLabel adjustsFontSizeToFitWidth];
    
    NSArray<NSLayoutConstraint*>* swipeLabelConstraints = [NSArray arrayWithObjects:
        [[swipeLabel centerXAnchor] constraintEqualToAnchor:[self.imageView centerXAnchor]],
        [[swipeLabel topAnchor] constraintEqualToAnchor:[self.imageView topAnchor] constant:30.0],
        [[swipeLabel widthAnchor] constraintEqualToAnchor:[self.imageView widthAnchor] multiplier:0.90],
        nil];
    
    [NSLayoutConstraint activateConstraints:swipeLabelConstraints];
    
    NSLog(@"The image view should have been added: %@",[self.imageView description]);
    
    
}


-(void)viewWillAppear:(BOOL)animated{
   
    
}

-(void)viewDidLoad{
    
    [self setupBackgroundImageView];
    
    [self setupTrayView];
    
    
    [self setupGestureRecognizers];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.imageView];
    
    [self setupBehaviors];
    
    NSLog(@"Debug description for trayView: %@",[self.trayView description]);

   
}


/** Before dynamic behaviors can be configured, the dynamic animator must have already been allocated and initialized, and any dynamic items being added to the behaviors should have been added and initialized already as well **/

- (void) setupDynamicBehaviorsForItems:(NSArray<id<UIDynamicItem>>*)items{
    
    self.edgeCollisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
    
    [self.edgeCollisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0.00, GUTTER_WIDTH, 0.00, -self.view.bounds.size.width)];
    
    [self.animator addBehavior:self.edgeCollisionBehavior];
    
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:items];
    [self.animator addBehavior:self.gravityBehavior];
    [self updateGravityIsLeft:NO];
    
}


-(void) setupGestureRecognizers{
    
    UIScreenEdgePanGestureRecognizer* edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [edgePan setEdges:UIRectEdgeRight];
    
    [self.view addGestureRecognizer:edgePan];
    
    
    UIScreenEdgePanGestureRecognizer* imageViewEdgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [imageViewEdgePan setEdges:UIRectEdgeRight];
    
    [self.imageView addGestureRecognizer:imageViewEdgePan];
    
    
    
    UIPanGestureRecognizer* trayPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self.trayView addGestureRecognizer:trayPanGestureRecognizer];
}


-(void)setupTrayView{
    
    
    [self.imageView addSubview:self.trayView];
    
    NSArray<NSLayoutConstraint*>* trayViewConstraints = [NSArray arrayWithObjects:
        [[self.trayView widthAnchor] constraintEqualToAnchor:[self.view widthAnchor]],
        [[self.trayView heightAnchor] constraintEqualToAnchor:[self.view heightAnchor]],
        [[self.trayView topAnchor] constraintEqualToAnchor:[self.view topAnchor]],
                                                         nil];
    
    [NSLayoutConstraint activateConstraints:trayViewConstraints];
    
    
    [self.trayLeftEdgeConstraint setActive:YES];
    
    
    
     [self.menuStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
     [self.trayView.contentView addSubview:self.menuStackView];
    
    UIView*menuSuperview = self.menuStackView.superview;
    
    NSArray<NSLayoutConstraint*>* menuStackViewConstraints = [NSArray arrayWithObjects:
        [[self.menuStackView topAnchor] constraintEqualToAnchor:[menuSuperview topAnchor] constant: 20.0],
        [[self.menuStackView bottomAnchor] constraintEqualToAnchor:[menuSuperview bottomAnchor]],
        [[self.menuStackView leftAnchor] constraintEqualToAnchor:[menuSuperview leftAnchor] constant: 10],
        [[self.menuStackView rightAnchor] constraintEqualToAnchor:[menuSuperview rightAnchor] constant: -GUTTER_WIDTH-10], nil];
    
    [NSLayoutConstraint activateConstraints:menuStackViewConstraints];
    

    [self.view layoutIfNeeded];

}

-(void) setupBehaviors{
    
   
    [self.edgeCollisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0.00, GUTTER_WIDTH, 0.00, -self.view.bounds.size.width)];
    
    [_animator addBehavior:self.edgeCollisionBehavior];
    
    [_animator addBehavior:self.gravityBehavior];
    [self updateGravityIsLeft:gravityIsLeft];
    
    
}



-(void)pan:(UIScreenEdgePanGestureRecognizer*)recognizer{
    
    
    
    CGPoint currentPoint = [recognizer locationInView:self.imageView];

    CGPoint xOnlyLocation = CGPointMake(currentPoint.x, self.view.center.y);
    
    if(recognizer.state == UIGestureRecognizerStateBegan){
        
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.trayView attachedToAnchor:xOnlyLocation];
    
        [_animator addBehavior:_attachmentBehavior];
        
    }else if(recognizer.state == UIGestureRecognizerStateChanged){
        _attachmentBehavior.anchorPoint = xOnlyLocation;
        
    }else if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        

        [_animator removeBehavior:_attachmentBehavior];
      
        CGPoint velocity = [recognizer velocityInView:self.imageView];
        CGFloat velocityThrowingThreshold = 500.0;
        
        
        if(abs(velocity.x) > velocityThrowingThreshold){
            BOOL isLeft = velocity.x < 0;
            [self updateGravityIsLeft:isLeft];
        } else {
            BOOL isLeft = self.trayView.frame.origin.x < self.view.center.x;
            [self updateGravityIsLeft:isLeft];
        }
        
       // [self.menuStackView becomeFirstResponder];
    }
}


-(void) updateGravityIsLeft:(BOOL)isLeft{
    CGFloat angle = isLeft ? M_PI: 0.00;
    [self.gravityBehavior setAngle:angle];
}


#pragma mark ************ ALLOCATION/INITIALIZATION OF IVARS AND COMPUTED PROPERTIES




-(UICollisionBehavior *)edgeCollisionBehavior{
    
    if(_edgeCollisionBehavior == nil){
        _edgeCollisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.trayView]];
        
    }
    
    return _edgeCollisionBehavior;
}


-(UIGravityBehavior *)gravityBehavior{
    if(_gravityBehavior == nil){
        _gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.trayView]];
        
    }
    
    return _gravityBehavior;
}


-(UIStackView *)menuStackView{
    
    if(_menuStackView == nil){
        
        UIButton* tourButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [tourButton setTitle:@"Quick Tour" forState:UIControlStateNormal];
        [tourButton.titleLabel setFont:[UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:30.00]];
        [tourButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        
        
        UIButton* roomInfoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [roomInfoButton setTitle:@"Room/Price Information" forState:UIControlStateNormal];
        [roomInfoButton.titleLabel setFont:[UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:30.00]];
        [roomInfoButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        
        
        UIButton* directionsButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [directionsButton setTitle:@"Directions Information" forState:UIControlStateNormal];
        [directionsButton.titleLabel setFont:[UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:30.00]];
        [directionsButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        
        
        
        UIButton* nearbySitesButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [nearbySitesButton setTitle:@"Tourist Site Information" forState:UIControlStateNormal];
        [nearbySitesButton.titleLabel setFont:[UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:30.00]];
        [nearbySitesButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        
        
        UIButton* contactInfoButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [contactInfoButton setTitle:@"Contact Information" forState:UIControlStateNormal];
        [contactInfoButton.titleLabel setFont:[UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:30.00]];
        [contactInfoButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
        
        
        _menuStackView = [[UIStackView alloc] initWithArrangedSubviews:@[roomInfoButton,directionsButton,nearbySitesButton,contactInfoButton]];
        
        [_menuStackView setAxis:UILayoutConstraintAxisVertical];
        [_menuStackView setDistribution:UIStackViewDistributionFillEqually];
        
        return _menuStackView;
        
    }
    
    return _menuStackView;
}

-(UIVisualEffectView *)trayView{
    if(_trayView == nil){
        UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        
        _trayView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
        _trayView.translatesAutoresizingMaskIntoConstraints = false;
        
        
        
    }
    return _trayView;
}

-(UIDynamicAnimator *)animator{
    if(_animator == nil){
        
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
        
    }
    
    return _animator;
}

-(UIImageView *)imageView{
    
    if(_imageView == nil){
        UIImage* image = [UIImage imageNamed:@"Lobby_1"];
        
        _imageView = [[UIImageView alloc]initWithImage:image];
        
        _imageView.translatesAutoresizingMaskIntoConstraints = false;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _imageView;
}

-(NSLayoutConstraint *)trayLeftEdgeConstraint{
    
    if(_trayLeftEdgeConstraint == nil){
        _trayLeftEdgeConstraint = [NSLayoutConstraint constraintWithItem:self.trayView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.view.frame.size.width];
    }
    
    return _trayLeftEdgeConstraint;
}

-(void)showRoomPriceInfo{
    
}

-(void)showDirectionsInfo{
    
}

-(void)showTouristSiteInfo{
    
}

-(void)showContactInfo{
    
    
}

/**
-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    [self.trayView removeFromSuperview];
    
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
   
    [self setupTrayView];
    
    [self setupGestureRecognizers];
    
    _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.imageView];
    
    [self setupBehaviors];
}

-(void)resetMenuStackViewConstraints{
    UIView*menuSuperview = self.menuStackView.superview;
    
    NSArray<NSLayoutConstraint*>* menuStackViewConstraints = [NSArray arrayWithObjects:
        [[self.menuStackView topAnchor] constraintEqualToAnchor:[menuSuperview topAnchor] constant: 20.0],
        [[self.menuStackView bottomAnchor] constraintEqualToAnchor:[menuSuperview bottomAnchor]],
        [[self.menuStackView leftAnchor] constraintEqualToAnchor:[menuSuperview leftAnchor] constant: 10],
        [[self.menuStackView rightAnchor] constraintEqualToAnchor:[menuSuperview rightAnchor] constant: -GUTTER_WIDTH-10], nil];
    
    [NSLayoutConstraint activateConstraints:menuStackViewConstraints];
}
 
 **/

@end



/**

-(UIImageView *)flexibleImageView{
    
    
    
    UITraitCollection* traitCollection = [self traitCollection];
    UIUserInterfaceSizeClass horizontalSizeClass = [traitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass verticalSizeClass = [traitCollection verticalSizeClass];
    
    BOOL CompactWidth_CompactHeight = (horizontalSizeClass == UIUserInterfaceSizeClassCompact && verticalSizeClass == UIUserInterfaceSizeClassCompact);
    
    BOOL CompactWidth_RegularHeight = (horizontalSizeClass == UIUserInterfaceSizeClassCompact && verticalSizeClass == UIUserInterfaceSizeClassRegular);
    
    BOOL RegularWidth_CompactHeight = (horizontalSizeClass == UIUserInterfaceSizeClassRegular && verticalSizeClass == UIUserInterfaceSizeClassCompact);
    
    BOOL RegularWidth_RegularHeight = (horizontalSizeClass == UIUserInterfaceSizeClassRegular && verticalSizeClass == UIUserInterfaceSizeClassRegular);
    
    /** iPhones in landscape mode **/

/**
    if(CompactWidth_CompactHeight){
        
    }
    
    /** iPhones in portrait mode **/

/**
    if(CompactWidth_RegularHeight){
        
        
    }
    
    /** iPhone 7 Plus in landscape mode **/

/**
    if(RegularWidth_CompactHeight){
        
        
    }
    
    /** Select the correct image for iPads **/
/**
    if(RegularWidth_RegularHeight){
        
        
        
    }
    
    return nil;
    
}

**/

