//
//  RoomCollectionViewController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef RoomCollectionViewController_h
#define RoomCollectionViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RoomCollectionViewController : UICollectionViewController<UICollectionViewDelegateFlowLayout>

@property NSArray<NSString*>* roomImageNameArray;


@end

#endif /* RoomCollectionViewController_h */
