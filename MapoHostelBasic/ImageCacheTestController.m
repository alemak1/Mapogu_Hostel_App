//
//  ImageCacheTestController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageCacheTestController.h"
#import "ImageManager.h"
#import "ImageKeyConstants.h"

@interface ImageCacheTestController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

+ (ImageManager*) sharedManager;

@property NSOperationQueue* loadingOperationQueue;

@end

@implementation ImageCacheTestController

static ImageManager* _sharedManager = nil;
NSOperationQueue* _loadingOperationQueue;


-(NSOperationQueue *)loadingOperationQueue{
 
    if(!_loadingOperationQueue){
        _loadingOperationQueue = [[NSOperationQueue alloc] init];
    }
    
    return _loadingOperationQueue;
    
}

-(void)viewWillLayoutSubviews{
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    int numberOfSection = [ImageManager numberOfSections];
    NSLog(@"There are a total of %d sections in the image dictionary",numberOfSection);
    
    //Load the values for the ROOM_NO1 key of the ImagePathDictionary
    [[ImageManager sharedManager] loadDictForRoomNo1];
   // [[ImageManager sharedManager] loadDictForRoomNo2];
    //[[ImageManager sharedManager] loadDictForRoomNo3];
    //[[ImageManager sharedManager] loadDictForRoomNo4];
    //[[ImageManager sharedManager] loadDictForLobby];
    //[[ImageManager sharedManager] loadDictForGuests];
    
    
    UIImage* imageRoomNo1_1;
    UIImage* imageRoomNo1_2;
    UIImage* imageRoomNo1_3;
    UIImage* imageRoomNo1_4;
    UIImage* imageRoomNo1_5;
    
    @try{
        imageRoomNo1_1 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_1];
        imageRoomNo1_2 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_2];
        imageRoomNo1_3 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_3];
        imageRoomNo1_4 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_4];
        imageRoomNo1_5 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_5];
    }
    
    @catch(NSException* e){
        NSString* exceptionReason = [e reason];
        NSString* exceptionName = [e name];
        NSString* exceptionDescription = [e description];
        
        NSLog(@"An exception %@ occurred for reason %@.  Exception description: %@",exceptionName,exceptionReason,exceptionDescription);
    }
    
    UIImage* imageRoomNo2_1 = [[ImageManager sharedManager] getImageForRoomNo2:kRoomNo2_1];
    UIImage* imageRoomNo2_2 = [[ImageManager sharedManager] getImageForRoomNo2:kRoomNo2_2];
    UIImage* imageRoomNo2_3 = [[ImageManager sharedManager] getImageForRoomNo2:kRoomNo2_3];
    UIImage* imageRoomNo2_4 = [[ImageManager sharedManager] getImageForRoomNo2:kRoomNo2_4];
    UIImage* imageRoomNo2_5 = [[ImageManager sharedManager] getImageForRoomNo2:kRoomNo2_5];

    NSLog(@"Image description for %@: %@", kRoomNo1_1,[imageRoomNo1_1 description]);
    NSLog(@"Image description for %@: %@", kRoomNo1_2,[imageRoomNo1_2 description]);
    NSLog(@"Image description for %@: %@", kRoomNo1_3,[imageRoomNo1_3 description]);
    NSLog(@"Image description for %@: %@", kRoomNo1_4,[imageRoomNo1_4 description]);
    NSLog(@"Image description for %@: %@", kRoomNo1_5,[imageRoomNo1_5 description]);

    [[ImageManager sharedManager] unloadDictForRoomNo1];
    
    imageRoomNo1_1 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_1];
    imageRoomNo1_2 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_2];
    imageRoomNo1_3 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_3];
    imageRoomNo1_4 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_4];
    imageRoomNo1_5 = [[ImageManager sharedManager] getImageForRoomNo1:kRoomNo1_5];
    
    
    NSLog(@"Image description for %@: %@", kRoomNo1_1,[imageRoomNo1_1 description]);
    NSLog(@"Image description for %@: %@", kRoomNo1_2,[imageRoomNo1_2 description]);
    NSLog(@"Image description for %@: %@", kRoomNo1_3,[imageRoomNo1_3 description]);
    NSLog(@"Image description for %@: %@", kRoomNo1_4,[imageRoomNo1_4 description]);
    NSLog(@"Image description for %@: %@", kRoomNo1_5,[imageRoomNo1_5 description]);


    [[self imageView] setImage:imageRoomNo1_1];
}

-(void)viewDidLoad{
    
    
    
}



+(ImageManager *)sharedManager{
    
    if(_sharedManager == nil){
        _sharedManager = [ImageManager sharedManager];

    }
    
    return _sharedManager;
}

@end
