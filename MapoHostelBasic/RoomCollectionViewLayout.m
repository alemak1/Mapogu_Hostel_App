//
//  RoomCollectionViewLayout.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoomCollectionViewLayout.h"

@implementation RoomCollectionViewHorizontalLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.minimumInteritemSpacing = 30;
    self.minimumLineSpacing = 100;
    self.itemSize = CGSizeMake(400,233.);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

@end

@implementation RoomCollectionViewVerticalLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.minimumInteritemSpacing = 30;
    self.minimumLineSpacing = 100;
    self.itemSize = CGSizeMake(300,200);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


@end
