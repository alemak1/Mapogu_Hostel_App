//
//  IntroViewControllerAB.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/20/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntroViewControllerAB.h"


@interface IntroViewControllerAB ()

/** The root view will act as the reference view for the dynamic animator **/
@property UIDynamicAnimator* dynamicAnimator;
@property UIPushBehavior* pushBehavior;

/** Swipe Gesture Recognizers **/

@property (readonly) UISwipeGestureRecognizer* swipeLeft;
@property (readonly) UISwipeGestureRecognizer* swipeRight;
@property (readonly) UISwipeGestureRecognizer* swipeDown;
@property (readonly) UISwipeGestureRecognizer* swipeUp;
@property (readonly) NSArray<UISwipeGestureRecognizer*>* allSwipes;
@property (readonly) NSArray<UISwipeGestureRecognizer*>* horizontalSwipes;
@property (readonly) NSArray<UISwipeGestureRecognizer*>* verticalSwipes;

@end


@implementation IntroViewControllerAB

@synthesize dynamicAnimator = _dynamicAnimator;

-(void)viewWillLayoutSubviews{
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    
    UIImageView* orangeFish = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fishTile_081"]];
    UIImageView* redFish = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fishTile_079"]];
    UIImageView* pinkFish = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fishTile_075"]];
    UIImageView* greenFish = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fishTile_073"]];
    UIImageView* blueFish = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fishTile_077"]];
    
    NSArray<UIImageView*>* allFish = @[orangeFish,redFish,pinkFish,greenFish,blueFish];
    
    for (UIImageView*fishView in allFish) {
        [fishView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:fishView];
        [self addAllSwipeRecognizersTo:fishView];
    }
    
    //TODO: set the inital positions of the fish
    [self activateXYPositionConstraintsFor:orangeFish withXOffset:[NSNumber numberWithInteger:0] andWithYOffset:[NSNumber numberWithInteger:0]];
    
    [self activateXYPositionConstraintsFor:pinkFish withXOffset:[NSNumber numberWithInteger:100] andWithYOffset:[NSNumber numberWithInteger:100]];
    
    [self activateXYPositionConstraintsFor:greenFish withXOffset:[NSNumber numberWithInteger:0-100] andWithYOffset:[NSNumber numberWithInteger:-100]];
    
    [self activateXYPositionConstraintsFor:redFish withXOffset:[NSNumber numberWithInteger:100] andWithYOffset:[NSNumber numberWithInteger:-100]];
    
    [self activateXYPositionConstraintsFor:blueFish withXOffset:[NSNumber numberWithInteger:-100] andWithYOffset:[NSNumber numberWithInteger:100]];
    
    
    
    
   
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:allFish mode:UIPushBehaviorModeInstantaneous];
    
    [self.dynamicAnimator addBehavior:self.pushBehavior];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)viewDidLoad{
    
}

-(void) didSwipe:(UISwipeGestureRecognizer*)swipe{
    
    if(swipe.state == UIGestureRecognizerStateBegan){
        [self.pushBehavior setActive:YES];
        [self processSwipe:swipe];
        
    } else if(swipe.state == UIGestureRecognizerStateChanged){
        [self processSwipe:swipe];
    
    }else if(swipe.state == UIGestureRecognizerStateEnded || swipe.state == UIGestureRecognizerStateCancelled){
        [self.pushBehavior setActive:NO];
    }
    
    
}

-(void)processSwipe:(UISwipeGestureRecognizer*)swipe{
    if(swipe.direction == UISwipeGestureRecognizerDirectionRight){
        [self.pushBehavior setAngle:0.00 magnitude:1.00];
        [self.pushBehavior setPushDirection:CGVectorMake(100.0, 0)];
        
    } else if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        [self.pushBehavior setAngle:M_PI magnitude:1.00];
        [self.pushBehavior setPushDirection:CGVectorMake(-100.0, 0)];


    } else if(swipe.direction == UISwipeGestureRecognizerDirectionDown){
        [self.pushBehavior setAngle:(3/2)*M_PI magnitude:1.00];
        [self.pushBehavior setPushDirection:CGVectorMake(0, 100)];


    } else if(swipe.direction == UISwipeGestureRecognizerDirectionUp){
        [self.pushBehavior setAngle:(1/2)*M_PI magnitude:1.00];
        [self.pushBehavior setPushDirection:CGVectorMake(0, -100.0)];


    }
}

#pragma mark *******GETTER/SETTER FOR dynamicAnimator (backed by an ivar)

-(void)setDynamicAnimator:(UIDynamicAnimator *)dynamicAnimator{
    
    _dynamicAnimator = dynamicAnimator;
}

-(UIDynamicAnimator *)dynamicAnimator{
    
    if(_dynamicAnimator == nil){
        _dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    
    
    return _dynamicAnimator;
}

#pragma mark *********** SWIPE GESTURE RECOGNIZERS 

-(UISwipeGestureRecognizer *)swipeUp{
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    
    return swipe;
}

-(UISwipeGestureRecognizer *)swipeDown{
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    
    return swipe;
}
    
-(UISwipeGestureRecognizer *)swipeLeft{
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    return swipe;
}

-(UISwipeGestureRecognizer *)swipeRight{
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    
    return swipe;
    
}

-(NSArray<UISwipeGestureRecognizer *> *)verticalSwipes{
    
    return @[[self swipeDown], [self swipeUp]];
}

-(NSArray<UISwipeGestureRecognizer *> *)horizontalSwipes{
    
    return @[[self swipeLeft], [self swipeRight]];
}


-(NSArray<UISwipeGestureRecognizer *> *)allSwipes{
    
    return @[[self swipeLeft], [self swipeRight], [self swipeUp], [self swipeDown]];
}




/** Convenience method **/

-(void) addAllSwipeRecognizersTo:(UIView*)view{

    for (UISwipeGestureRecognizer*swipe in [self allSwipes]) {
        [view addGestureRecognizer:swipe];
    }
}

-(void) addHorizontalSwipeRecognizersTo:(UIView*)view{
    for (UISwipeGestureRecognizer*swipe in [self horizontalSwipes]) {
        [view addGestureRecognizer:swipe];
    }
    
}

-(void) addVerticalSwipeRecognizersTo:(UIView*) view{
    for (UISwipeGestureRecognizer*swipe in [self verticalSwipes]) {
        [view addGestureRecognizer:swipe];
    }
}

-(void) activateXYPositionConstraintsFor:(UIView*)addedView withXOffset:(NSNumber*)xOffsetNumber andWithYOffset:(NSNumber*)yOffsetNumber{
    
    NSInteger xOffset = xOffsetNumber == nil ? 0 : [xOffsetNumber integerValue];
    NSInteger yOffset = yOffsetNumber == nil ? 0 : [yOffsetNumber integerValue];
    
    NSArray<NSLayoutConstraint*>* constraints = [NSArray arrayWithObjects:
        [[addedView centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor] constant:xOffset],
        [[addedView centerYAnchor] constraintEqualToAnchor:[self.view centerYAnchor] constant:yOffset],
        nil];
    
    [NSLayoutConstraint activateConstraints:constraints];
    
}

@end
