//
//  ScrollViewController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef ScrollViewController_h
#define ScrollViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ScrollViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *contentList;


@end

#endif /* ScrollViewController_h */
