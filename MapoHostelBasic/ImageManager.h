//
//  ImageManager.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef ImageManager_h
#define ImageManager_h

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject

typedef enum{
    ROOM_NO1 = 1,
    ROOM_NO2,
    ROOM_NO3,
    ROOM_NO4,
    BATHROOMS,
    LOBBY,
    KITCHEN,
    GUESTS,
    OTHER
}SectionKey;



+ (id)sharedManager;

+ (NSString*) getImageNameForIndexPath:(NSIndexPath*)indexPath;
+ (NSInteger) numberOfSections;
+ (NSInteger) numberOfItemsInSection:(NSInteger)section;

/** Image getter methods **/

- (UIImage*) getImageForRoomNo1:(NSString*)keyRoomNo1;
- (UIImage*) getImageForRoomNo2:(NSString*)keyRoomNo2;
- (UIImage*) getImageForRoomNo3:(NSString*)keyRoomNo3;
- (UIImage*) getImageForRoomNo4:(NSString*)keyRoomNo4;
- (UIImage*) getImageForLobby:(NSString*)keyLobby;
- (UIImage*) getImageForGuests:(NSString*)keyGuests;
- (UIImage*) getImageForKitchen:(NSString*)keyKitchen;
- (UIImage*) getImageForOther:(NSString*)keyOther;

/** Dictionary cache-loading methods **/

- (void) loadDictForRoomNo1;
- (void) loadDictForRoomNo2;
- (void) loadDictForRoomNo3;
- (void) loadDictForRoomNo4;
- (void) loadDictForLobby;
- (void) loadDictForKitchen;
- (void) loadDictForGuests;
- (void) loadDictForOther;
- (void) loadDictForBathrooms;


@end

#endif /* ImageManager_h */
