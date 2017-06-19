//
//  PhotoListController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import "PhotoListController.h"
#import "ImageManager.h"

@implementation PhotoListController



-(void) viewWillAppear:(BOOL)animated{
    
    /** Debug: load all of the images in the dictionary cache **/
    
    
    [[ImageManager sharedManager] loadDictForRoomNo1];
    [[ImageManager sharedManager] loadDictForRoomNo2];
    [[ImageManager sharedManager] loadDictForRoomNo3];
    [[ImageManager sharedManager] loadDictForRoomNo4];
    [[ImageManager sharedManager] loadDictForGuests];
    [[ImageManager sharedManager] loadDictForOther];
    [[ImageManager sharedManager] loadDictForBathrooms];
    [[ImageManager sharedManager] loadDictForLobby];
    
    /** Set the delegate and data source to the current view controller **/
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCell"];
    
}

-(void) viewDidLoad{
    
    
}


#pragma COLLECTION VIEW CONTROLLER - DELEGATE METHODS

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma COLLECTION VIEW CONTROLLER - DATASOURCE METHODS


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [ImageManager numberOfSections];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [ImageManager numberOfItemsInSection:section];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    NSString* imagePathName = [ImageManager getImageNameForIndexPath:indexPath];
    
    UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagePathName]];
    
    CGRect cellRect = cell.contentView.bounds;
    imageView.frame = cellRect;
    
    [[cell contentView] addSubview:imageView];
    
    return cell;
    
}

@end
