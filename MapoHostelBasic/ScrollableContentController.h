//
//  ScrollableContentController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef ScrollableContentController_h
#define ScrollableContentController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ScrollableContentController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *previewTitle;
@property (nonatomic, strong) IBOutlet UIImageView *previewImage;


@property (assign) NSInteger pageNumber;

- (id)initWithPageNumber:(NSUInteger)pageNumber;


@end

#endif /* ScrollableContentController_h */
