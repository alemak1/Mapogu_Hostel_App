//
//  HeaderConfiguration.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderViewConfiguration.h"


@implementation HeaderViewConfiguration

#pragma mark ******** INITIALIZERS

- (id) initWithFont:(UIFont*)fontType andWithTextColor:(UIColor*)textColor andWithImageName:(NSString*)imageName andWithText:(NSString*)text{
    
    
    self = [super init];
    
    if(self){
        
        _titleFont = fontType;
        _imageName = imageName;
        _textColor = textColor;
        _text = text;
    }
    
    return self;
}

#pragma mark ******** FACTORY METHOD

+ (HeaderViewConfiguration*) getHeaderViewConfigurationForSection:(PlaceMarkSection)placemarkSection{
    switch (placemarkSection) {
        case COFFEE_SHOPS:
            return [[HeaderViewConfiguration alloc] initWithFont:[UIFont fontWithName:@"Copperplate" size:25.0] andWithTextColor:[UIColor brownColor] andWithImageName:@"coffeeA" andWithText:@"Coffee Shops"];
        case CONVENIENCE_STORES:
            return  [[HeaderViewConfiguration alloc] initWithFont:[UIFont fontWithName:@"Copperplate" size:25.0] andWithTextColor:[UIColor grayColor] andWithImageName:@"convenienceStoreA" andWithText:@"Convenience Stores"];
        case KOREAN_BARBECUE:
            return  [[HeaderViewConfiguration alloc] initWithFont:[UIFont fontWithName:@"Copperplate" size:25.0] andWithTextColor:[UIColor redColor] andWithImageName:@"barbecueA" andWithText:@"Korean Barbecue"];
        case OTHER_RESTAURANTS:
            return  [[HeaderViewConfiguration alloc] initWithFont:[UIFont fontWithName:@"Copperplate" size:25.0] andWithTextColor:[UIColor purpleColor] andWithImageName:@"otherRestaurantsA" andWithText:@"Other Restaurants"];
        case SPORTS_RECREATION:
            return  [[HeaderViewConfiguration alloc] initWithFont:[UIFont fontWithName:@"Copperplate" size:30.0] andWithTextColor:[UIColor greenColor] andWithImageName:@"microphoneA" andWithText:@"Recreation"];
        case PHARMACY_DRUGSTORE:
            return  [[HeaderViewConfiguration alloc] initWithFont:[UIFont fontWithName:@"Copperplate" size:25.0] andWithTextColor:[UIColor cyanColor] andWithImageName:@"pharmacyA" andWithText:@"Pharmacy/Drugstores"];
        case PHONE_MOBILE_SERVICES:
            return  [[HeaderViewConfiguration alloc] initWithFont:[UIFont fontWithName:@"Copperplate" size:25.0] andWithTextColor:[UIColor magentaColor] andWithImageName:@"phoneA" andWithText:@"Phone/Mobile Services"];
        default:
            break;
    }
    
    return nil;
}


@end
