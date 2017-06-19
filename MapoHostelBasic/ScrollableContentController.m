//
//  ScrollableContentController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrollableContentController.h"



@implementation ScrollableContentController

- (id)initWithPageNumber:(NSUInteger)pageNumber
    {
        if (self = [super init])
        {
            _pageNumber = pageNumber;
        }
        return self;
    }
    



@end
