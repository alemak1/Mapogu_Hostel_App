//
//  RoomInformationController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomCollectionViewController.h"
#import "RoomCollectionViewLayout.h"

@implementation RoomCollectionViewController

NSArray<NSString*>* _roomImageNameArray;


- (void) viewWillAppear:(BOOL)animated{
    
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"RoomCollectionViewCell"];
}




-(void) viewDidLoad{
    NSLog(@"Collection view did load!");
    
    
    
}


//MARK: DATA SOURCE METHODS

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_roomImageNameArray count];
}

//MARK: UICollectionViewDelegate Methods

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"RoomCollectionViewCell" forIndexPath:indexPath];
    
    UIImageView* cellImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[_roomImageNameArray objectAtIndex:[indexPath row]]]];
    
    [cell.contentView addSubview:cellImageView];
    
    cellImageView.frame = cell.contentView.frame;
    
    return cell;
    
}





//MARK: UICollectionViewDelegateFlowLayout

/**
 
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
}

//MARK: TraitCollection Change Callbacks

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    //[self.collectionView.collectionViewLayout invalidateLayout];
}

 **/

-(void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    
    UITraitCollection* currentTraitCollection = newCollection;
    UIUserInterfaceSizeClass currentHorizontalSizeClass = [currentTraitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass currentVerticalSizeClass = [currentTraitCollection verticalSizeClass];
    
    UICollectionViewFlowLayout* layoutObject;// = [[UICollectionViewFlowLayout alloc] init];
    
    
    
    
    if(currentVerticalSizeClass == UIUserInterfaceSizeClassCompact){
        
        /**
        [layoutObject setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [layoutObject setItemSize:CGSizeMake(400, 233.3)];
        [layoutObject setMinimumLineSpacing:30];
        [layoutObject setMinimumInteritemSpacing:30];
        **/
        
        layoutObject = [[RoomCollectionViewHorizontalLayout alloc] init];
        
    }
    
    if(currentVerticalSizeClass == UIUserInterfaceSizeClassRegular){
        
        /**
        [layoutObject setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layoutObject setItemSize:CGSizeMake(300, 200)];
        [layoutObject setMinimumLineSpacing:30];
        [layoutObject setMinimumInteritemSpacing:30];
        **/
        
        layoutObject = [[RoomCollectionViewVerticalLayout alloc] init];

        
    }
    
    [self.collectionView setCollectionViewLayout:layoutObject animated:NO];
    
    
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    
    [self.collectionView layoutIfNeeded];
    
    /**
    
    UITraitCollection* currentTraitCollection = [self traitCollection];
    UIUserInterfaceSizeClass currentHorizontalSizeClass = [currentTraitCollection horizontalSizeClass];
    UIUserInterfaceSizeClass currentVerticalSizeClass = [currentTraitCollection verticalSizeClass];
    
    UICollectionViewFlowLayout* layoutObject = [[UICollectionViewFlowLayout alloc] init];
    
   
 
    
    if(currentVerticalSizeClass == UIUserInterfaceSizeClassCompact){
        
        
        [layoutObject setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [layoutObject setItemSize:CGSizeMake(400, 233.3)];
        [layoutObject setMinimumLineSpacing:30];
        [layoutObject setMinimumInteritemSpacing:30];


    }
    
    if(currentVerticalSizeClass == UIUserInterfaceSizeClassRegular){
        
        [layoutObject setScrollDirection:UICollectionViewScrollDirectionVertical];
        [layoutObject setItemSize:CGSizeMake(300, 200)];
        [layoutObject setMinimumLineSpacing:30];
        [layoutObject setMinimumInteritemSpacing:30];


    }
    
    [self.collectionView setCollectionViewLayout:layoutObject animated:NO];
    
  //  [layoutObject prepareLayout];
    
   // [self.collectionView setCollectionViewLayout:layoutObject animated:YES];
   // [self.collectionView layoutIfNeeded];
    
     **/
}



@end
