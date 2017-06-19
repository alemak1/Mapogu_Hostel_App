//
//  ImageManager.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/16/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "ImageManager.h"
#import "ImageKeyConstants.h"

@interface ImageManager ()

+ (NSDictionary<NSNumber*,NSArray<NSString*>*>*) imagePathDictionary;

- (NSMutableDictionary<NSString*,UIImage*>*) imageCache;


@end


@implementation ImageManager



+ (NSDictionary<NSNumber *,NSArray<NSString *> *> *)imagePathDictionary{
    
    static NSDictionary<NSNumber*,NSArray<NSString*>*>* imagePathDictionary = nil;
    
    if(imagePathDictionary == nil){
    
    imagePathDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
            @[kRoomNo1_1,kRoomNo1_2,kRoomNo1_3,kRoomNo1_4,kRoomNo1_5],[NSNumber numberWithInt:ROOM_NO1],
            @[kRoomNo2_1,kRoomNo2_2,kRoomNo2_3,kRoomNo2_4,kRoomNo2_5,kRoomNo2_6,kRoomNo2_7],[NSNumber numberWithInt:ROOM_NO2],
            @[kRoomNo3_1,kRoomNo3_2,kRoomNo3_3,kRoomNo3_4,kRoomNo3_5,kRoomNo3_6,kRoomNo3_7,
              kRoomNo3_7,kRoomNo3_8,kRoomNo3_9,kRoomNo3_10,kRoomNo3_11,kRoomNo3_12],[NSNumber numberWithInt:ROOM_NO3],
            @[],[NSNumber numberWithInt:ROOM_NO4],
            @[],[NSNumber numberWithInt:BATHROOMS],
            @[],[NSNumber numberWithInt:LOBBY],
            @[],[NSNumber numberWithInt:GUESTS],
            @[],[NSNumber numberWithInt:OTHER], nil];
    }
    
    return imagePathDictionary;
}

+ (NSString*) getImageNameForIndexPath:(NSIndexPath*)indexPath{
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    NSArray* imagePathArray = [[ImageManager imagePathDictionary] valueForKey:[NSNumber numberWithInteger:section]];
    
    if(row >= imagePathArray.count){
        return nil;
    }
    
    return [imagePathArray objectAtIndex:[NSNumber numberWithInteger:row]];
    
}

+ (NSInteger) numberOfSections{
    
    return [[[ImageManager imagePathDictionary] allKeys] count];
    
}

+ (NSInteger) numberOfItemsInSection:(NSInteger)section{
    
    NSArray* sectionPathArray = [[ImageManager imagePathDictionary] valueForKey:[NSNumber numberWithInt:section]];
    
    return [sectionPathArray count];
}



+(id)sharedManager{
    static ImageManager* sharedMyManager = nil;
    static dispatch_once_t onceToken;
    
    
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        
    });
    
    return sharedMyManager;
}

-(id)init{
    if(self = [super init]){
        
        NSInteger numberOfKeys = [[[ImageManager imagePathDictionary] allKeys] count];
        
        for(int keyIndex = 0; keyIndex < numberOfKeys; keyIndex++){
            
            NSArray* pathNameArray = [[ImageManager imagePathDictionary] valueForKey:[NSNumber numberWithInt:keyIndex]];
            
            
            for(int pathNameIndex = 0; pathNameIndex < [pathNameArray count]; pathNameIndex++){
                NSString* pathName = [pathNameArray objectAtIndex:pathNameIndex];
                
                [self.imageCache setValue:[UIImage alloc] forKey:pathName];
            }
        }
        
        /**
        NSDictionary<NSNumber*,NSArray<NSString*>*>* bathroomsDict = [[NSMutableDictionary alloc]init];
        [bathroomsDict setValue:[UIImage alloc] forKey:kBathRoomNo1_1];
        [bathroomsDict setValue:[UIImage alloc] forKey:kBathRoomNo2_1];
        [bathroomsDict setValue:[UIImage alloc] forKey:kBathRoomNo2_2];
        [_imageDictionary setValue:bathroomsDict forKey:@"Bathrooms"];
        
        
        
        NSMutableDictionary* roomNo1Dict = [[NSMutableDictionary alloc]init];
        [bathroomsDict setValue:[UIImage alloc] forKey:kRoomNo1_1];
        [bathroomsDict setValue:[UIImage alloc] forKey:kRoomNo1_2];
        [bathroomsDict setValue:[UIImage alloc] forKey:kRoomNo1_3];
        [bathroomsDict setValue:[UIImage alloc] forKey:kRoomNo1_4];
        [bathroomsDict setValue:[UIImage alloc] forKey:kRoomNo1_5];
        [_imageDictionary setValue:roomNo1Dict forKey:@"RoomNo1"];
        
        
        
        NSMutableDictionary* roomNo2Dict = [[NSMutableDictionary alloc]init];
        [roomNo2Dict setValue:[UIImage alloc] forKey:kRoomNo2_1];
        [roomNo2Dict setValue:[UIImage alloc] forKey:kRoomNo2_2];
        [roomNo2Dict setValue:[UIImage alloc] forKey:kRoomNo2_3];
        [roomNo2Dict setValue:[UIImage alloc] forKey:kRoomNo2_4];
        [roomNo2Dict setValue:[UIImage alloc] forKey:kRoomNo2_5];
        [roomNo2Dict setValue:[UIImage alloc] forKey:kRoomNo2_6];
        [roomNo2Dict setValue:[UIImage alloc] forKey:kRoomNo2_7];
        [_imageDictionary setValue:roomNo2Dict forKey:@"RoomNo2"];
        
        NSMutableDictionary* roomNo3Dict = [[NSMutableDictionary alloc]init];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_1];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_2];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_3];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_4];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_5];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_6];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_7];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_8];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_9];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_10];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_11];
        [roomNo3Dict setValue:[UIImage alloc] forKey:kRoomNo3_12];
        [_imageDictionary setValue:roomNo3Dict forKey:@"RoomNo3"];
        
        
        NSMutableDictionary* roomNo4Dict = [[NSMutableDictionary alloc]init];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_1];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_2];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_3];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_4];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_5];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_6];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_7];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_8];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_9];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_10];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_11];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_12];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_13];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_14];
        [roomNo4Dict setValue:[UIImage alloc] forKey:kRoomNo4_15];
        [_imageDictionary setValue:roomNo4Dict forKey:@"RoomNo4"];
        
        
        NSMutableDictionary* kitchenDict = [[NSMutableDictionary alloc]init];
        [kitchenDict setValue:[UIImage alloc] forKey:kKitchen_1];
        [_imageDictionary setValue:kitchenDict forKey:@"Kitchen"];
        
        NSMutableDictionary* lobbyDict = [[NSMutableDictionary alloc]init];
        [lobbyDict setValue:[UIImage alloc] forKey:kLobby_1];
        [lobbyDict setValue:[UIImage alloc] forKey:kLobby_2];
        [_imageDictionary setValue:lobbyDict forKey:@"Lobby"];
        
        NSMutableDictionary* otherDict = [[NSMutableDictionary alloc]init];
        [otherDict setValue:[UIImage alloc] forKey:kTowel];
        [otherDict setValue:[UIImage alloc] forKey:kLogo_1];
        [otherDict setValue:[UIImage alloc] forKey:kLogo_2];
        [otherDict setValue:[UIImage alloc] forKey:kLogo_3];
        [otherDict setValue:[UIImage alloc] forKey:kCertificate];
        [otherDict setValue:[UIImage alloc] forKey:kCertificate2];
        [otherDict setValue:[UIImage alloc] forKey:kBuildingOutside_1];
        [otherDict setValue:[UIImage alloc] forKey:kBuildingOutside_door];
        [otherDict setValue:[UIImage alloc] forKey:kWallLogo];
        [_imageDictionary setValue:otherDict forKey:@"Other"];



        [_imageDictionary setValue:[[NSMutableDictionary alloc] init] forKey:@"Guests"];
        NSMutableDictionary* guestsDict = [[NSMutableDictionary alloc]init];
        [guestsDict setValue:[UIImage alloc] forKey:kGuests1];
        [guestsDict setValue:[UIImage alloc] forKey:kGuests2];
        [guestsDict setValue:[UIImage alloc] forKey:kGuests3];
        [guestsDict setValue:[UIImage alloc] forKey:kGuests4];
        [guestsDict setValue:[UIImage alloc] forKey:kGuests5];
        [guestsDict setValue:[UIImage alloc] forKey:kGuests6];
        [guestsDict setValue:[UIImage alloc] forKey:kGuests7];
        
        [_imageDictionary setValue:guestsDict forKey:@"Guests"];

         **/
        
    }
    
    return self;
}

- (void) loadDictForRoomNo1{
    [self loadImagesForSectionKey:ROOM_NO1];
    
    /**
    NSMutableDictionary* roomNo1Dict = [_imageDictionary valueForKey:@"RoomNo1"];
    [roomNo1Dict setValue:[UIImage imageNamed:kRoomNo1_1] forKey:kRoomNo1_1];
    [roomNo1Dict setValue:[UIImage imageNamed:kRoomNo1_2] forKey:kRoomNo1_2];
    [roomNo1Dict setValue:[UIImage imageNamed:kRoomNo1_3] forKey:kRoomNo1_3];
    [roomNo1Dict setValue:[UIImage imageNamed:kRoomNo1_4] forKey:kRoomNo1_4];
    [roomNo1Dict setValue:[UIImage imageNamed:kRoomNo1_5] forKey:kRoomNo1_5];
     **/
    
}

- (void) loadDictForRoomNo2{
    
    [self loadImagesForSectionKey:ROOM_NO2];
    
    /**
    NSMutableDictionary* roomNo2Dict = [_imageDictionary valueForKey:@"RoomNo2"];
    [roomNo2Dict setValue:[UIImage imageNamed:kRoomNo2_1] forKey:kRoomNo2_1];
    [roomNo2Dict setValue:[UIImage imageNamed:kRoomNo2_2] forKey:kRoomNo2_2];
    [roomNo2Dict setValue:[UIImage imageNamed:kRoomNo2_3] forKey:kRoomNo2_3];
    [roomNo2Dict setValue:[UIImage imageNamed:kRoomNo2_4] forKey:kRoomNo2_4];
    [roomNo2Dict setValue:[UIImage imageNamed:kRoomNo2_5] forKey:kRoomNo2_5];
    [roomNo2Dict setValue:[UIImage imageNamed:kRoomNo2_6] forKey:kRoomNo2_6];
    [roomNo2Dict setValue:[UIImage imageNamed:kRoomNo2_7] forKey:kRoomNo2_7];
     **/

}

- (void) loadDictForRoomNo3{
    [self loadImagesForSectionKey:ROOM_NO3];
    
    /**
    NSMutableDictionary* roomNo3Dict = [_imageDictionary valueForKey:@"RoomNo3"];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_1] forKey:kRoomNo3_1];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_2] forKey:kRoomNo3_2];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_3] forKey:kRoomNo3_3];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_4] forKey:kRoomNo3_4];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_5] forKey:kRoomNo3_5];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_6] forKey:kRoomNo3_6];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_7] forKey:kRoomNo3_7];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_8] forKey:kRoomNo3_8];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_9] forKey:kRoomNo3_9];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_10] forKey:kRoomNo3_10];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_11] forKey:kRoomNo3_11];
    [roomNo3Dict setValue:[UIImage imageNamed:kRoomNo3_12] forKey:kRoomNo3_12];

    **/
}

- (void) loadDictForRoomNo4{
    
    [self loadImagesForSectionKey:ROOM_NO4];
    
    /**
    NSMutableDictionary* roomNo4Dict = [_imageDictionary valueForKey:@"RoomNo4"];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_1] forKey:kRoomNo4_1];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_2] forKey:kRoomNo4_2];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_3] forKey:kRoomNo4_3];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_4] forKey:kRoomNo4_4];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_5] forKey:kRoomNo4_5];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_6] forKey:kRoomNo4_6];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_7] forKey:kRoomNo4_7];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_8] forKey:kRoomNo4_8];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_9] forKey:kRoomNo4_9];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_10] forKey:kRoomNo4_10];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_11] forKey:kRoomNo4_11];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_12] forKey:kRoomNo4_12];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_13] forKey:kRoomNo4_13];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_14] forKey:kRoomNo4_14];
    [roomNo4Dict setValue:[UIImage imageNamed:kRoomNo4_15] forKey:kRoomNo4_15];

    **/
}

- (void) loadDictForLobby{
    
    [self loadImagesForSectionKey:LOBBY];
    
    /**
    NSMutableDictionary* lobbyDict = [_imageDictionary valueForKey:@"Lobby"];
    [lobbyDict setValue:[UIImage alloc] forKey:kLobby_1];
    [lobbyDict setValue:[UIImage alloc] forKey:kLobby_2];
     **/
}

- (void) loadDictForKitchen{
    
    [self loadImagesForSectionKey:KITCHEN];
    
    /**
    NSMutableDictionary* kitchenDict = [_imageDictionary valueForKey:@"Kitchen"];
    [kitchenDict setValue:[UIImage imageNamed:kKitchen_1] forKey:kKitchen_1];
     **/

}

- (void) loadDictForGuests{
    
    [self loadImagesForSectionKey:GUESTS];
    
    /**
    NSMutableDictionary* guestsDict = [_imageDictionary valueForKey:@"Guests"];
    [guestsDict setValue:[UIImage imageNamed:kGuests1] forKey:kGuests1];
    [guestsDict setValue:[UIImage imageNamed:kGuests2] forKey:kGuests2];
    [guestsDict setValue:[UIImage imageNamed:kGuests3] forKey:kGuests3];
    [guestsDict setValue:[UIImage imageNamed:kGuests4] forKey:kGuests4];
    [guestsDict setValue:[UIImage imageNamed:kGuests5] forKey:kGuests5];
    [guestsDict setValue:[UIImage imageNamed:kGuests6] forKey:kGuests6];
    [guestsDict setValue:[UIImage imageNamed:kGuests7] forKey:kGuests7];
     **/
}

- (void) loadDictForOther{
    
    [self loadImagesForSectionKey:OTHER];

    /**
    NSMutableDictionary* otherDict = [_imageDictionary valueForKey:@"Other"];

    [otherDict setValue:[UIImage imageNamed:kTowel] forKey:kTowel];
    [otherDict setValue:[UIImage imageNamed:kLogo_1] forKey:kLogo_1];
    [otherDict setValue:[UIImage imageNamed:kLogo_2] forKey:kLogo_2];
    [otherDict setValue:[UIImage imageNamed:kLogo_3] forKey:kLogo_3];
    [otherDict setValue:[UIImage imageNamed:kCertificate] forKey:kCertificate];
    [otherDict setValue:[UIImage imageNamed:kCertificate2] forKey:kCertificate2];
    [otherDict setValue:[UIImage imageNamed:kBuildingOutside_1] forKey:kBuildingOutside_1];
    [otherDict setValue:[UIImage imageNamed:kBuildingOutside_door] forKey:kBuildingOutside_door];
    [otherDict setValue:[UIImage imageNamed:kWallLogo] forKey:kWallLogo];
    **/
}

- (void) loadDictForBathrooms{
    [self loadImagesForSectionKey:BATHROOMS];
    /**
    NSMutableDictionary* bathroomsDict = [_imageDictionary valueForKey:@"Bathrooms"];
    [bathroomsDict setValue:[UIImage alloc] forKey:kBathRoomNo1_1];
    [bathroomsDict setValue:[UIImage alloc] forKey:kBathRoomNo2_1];
    [bathroomsDict setValue:[UIImage alloc] forKey:kBathRoomNo2_2];
     **/
    
}

- (void) loadImagesForSectionKey:(SectionKey)sectionKey{
    NSArray<NSString*>* pathNames = [[ImageManager imagePathDictionary] valueForKey:[NSNumber numberWithInt:sectionKey]];
    
    
    for (NSString*pathName in pathNames) {
        [self.imageCache setValue:[UIImage imageNamed:pathName] forKey:pathName];
    }
    
}


- (UIImage*) getImageForRoomNo1:(NSString*)keyRoomNo1{
    return [self.imageCache valueForKey:keyRoomNo1];
    /**
    NSMutableDictionary* roomNo1Dict = [_imageDictionary valueForKey:@"RoomNo1"];
    return [roomNo1Dict valueForKey:keyRoomNo1];
     **/
}

- (UIImage*) getImageForRoomNo2:(NSString*)keyRoomNo2{
    return [self.imageCache valueForKey:keyRoomNo2];
    /**
    NSMutableDictionary* roomNo2Dict = [_imageDictionary valueForKey:@"RoomNo2"];
    return [roomNo2Dict valueForKey:keyRoomNo2];
     **/
}

- (UIImage*) getImageForRoomNo3:(NSString*)keyRoomNo3{
    return [self.imageCache valueForKey:keyRoomNo3];
    /**
    NSMutableDictionary* roomNo3Dict = [_imageDictionary valueForKey:@"RoomNo3"];
    return [roomNo3Dict valueForKey:keyRoomNo3];
     **/
}

- (UIImage*) getImageForRoomNo4:(NSString*)keyRoomNo4{
    return [self.imageCache valueForKey:keyRoomNo4];
    /**
    NSMutableDictionary* roomNo4Dict = [_imageDictionary valueForKey:@"RoomNo4"];
    return [roomNo4Dict valueForKey:keyRoomNo4];
     **/
}

- (UIImage*) getImageForLobby:(NSString*)keyLobby{
    return [self.imageCache valueForKey:keyLobby];
    
    /**
    NSMutableDictionary* lobbyDict = [_imageDictionary valueForKey:@"Lobby"];
    return [lobbyDict valueForKey:keyLobby];
     **/
}

- (UIImage*) getImageForGuests:(NSString*)keyGuests{
    return [self.imageCache valueForKey:keyGuests];
    
    /**
    NSMutableDictionary* guestsDict = [_imageDictionary valueForKey:@"Guests"];
    return [guestsDict valueForKey:keyGuests];
     **/
}

- (UIImage*) getImageForKitchen:(NSString*)keyKitchen{
    return [self.imageCache valueForKey:keyKitchen];
    /**
    NSMutableDictionary* kitchenDict = [_imageDictionary valueForKey:@"Kitchen"];
    return [kitchenDict valueForKey:keyKitchen];
     **/
}


- (UIImage*) getImageForOther:(NSString*)keyOther{
    return [self.imageCache valueForKey:keyOther];
    
    /**
    NSMutableDictionary* otherDict = [_imageDictionary valueForKey:@"Other"];
    return [otherDict valueForKey:keyOther];
     **/
}

- (UIImage*) getImageForBathrooms:(NSString*)keyBathrooms{
    return [self.imageCache valueForKey:keyBathrooms];
    
    /**
    NSMutableDictionary* bathroomsDict = [_imageDictionary valueForKey:@"Bathrooms"];
    return [bathroomsDict valueForKey:keyBathrooms];
     **/
}






@end
