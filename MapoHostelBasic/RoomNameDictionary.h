//
//  RoomNameDictionary.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/18/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef RoomNameDictionary_h
#define RoomNameDictionary_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface RoomCVCHelperFunctions : NSObject


typedef enum RoomNumber{
    ROOM_NO1 = 1,
    ROOM_NO2,
    ROOM_NO3,
    ROOM_NO4
} RoomNumber;


+ (NSArray<NSString*>*) getRoomNameArrayForRoomNumber:(RoomNumber)roomNumber;

@end


@implementation RoomCVCHelperFunctions



+ (NSArray<NSString*>*) getRoomNameArrayForRoomNumber:(RoomNumber)roomNumber{
    switch (roomNumber) {
        case ROOM_NO1:
            return @[@"RoomNo1_1",@"RoomNo1_2",@"RoomNo1_3",@"RoomNo1_4",@"RoomNo1_5"];
        case ROOM_NO2:
            return @[@"RoomNo2_1",@"RoomNo2_2",@"RoomNo2_3",@"RoomNo2_4",@"RoomNo2_5",@"RoomNo2_6"];
        case ROOM_NO3:
            return @[@"RoomNo3_1",@"RoomNo3_2",@"RoomNo3_3",@"RoomNo3_4",@"RoomNo3_5",@"RoomNo3_6",@"RoomNo3_7",@"RoomNo3_8",@"RoomNo3_9",@"RoomNo3_10",@"RoomNo3_11",@"RoomNo3_12"];
        case ROOM_NO4:
            return @[@"RoomNo4_1",@"RoomNo4_2",@"RoomNo4_3",@"RoomNo4_4",@"RoomNo4_5",@"RoomNo4_6",@"RoomNo4_7",@"RoomNo4_8",@"RoomNo4_9",@"RoomNo4_10",@"RoomNo4_11",@"RoomNo4_12"];

    }
    
    return nil;
}


@end


#endif /* RoomNameDictionary_h */
