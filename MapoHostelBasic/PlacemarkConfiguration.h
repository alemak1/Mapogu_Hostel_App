//
//  PlacemarkConfiguration.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef PlacemarkConfiguration_h
#define PlacemarkConfiguration_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PlacemarkSection.h"

@interface PlacemarkConfiguration : NSObject<MKAnnotation>

/** Static convenience methods **/

+(NSString*) getSectionKeyForPlacemarkSectionInt:(PlaceMarkSection)placeMarkSection;



/** Initializers **/

-(id) initWithName:(NSString*)name andWithLongitude:(CGFloat)longitude andWithLatitude:(CGFloat)latitude andWithStreet:(NSString*)street andWithCity:(NSString*)city andWithCountry:(NSString*)country andWithPostalCode:(NSString*)postalCode andWithISOCountry:(NSString*)isoCountry andWithPlaceMarkSection:(PlaceMarkSection)placeMarkSection;

-(id) initWithName:(NSString*)name andWithLongitude:(CGFloat)longitude andWithLatitude:(CGFloat)latitude andWithStreet:(NSString*)street andWithCity:(NSString*)city andWithCountry:(NSString*)country andWithPostalCode:(NSString*)postalCode andWithISOCountry:(NSString*)isoCountry;

-(id) initWithLongitude:(CGFloat)longitude andWithLatitude:(CGFloat)latitude;

/** Properties **/

@property NSString* name;
@property NSString* city;
@property NSString* country;
@property NSString* isoCountry;
@property NSString* street;
@property NSString* postalCode;
@property NSString* imageName;

@property CGFloat latitude;
@property CGFloat longitude;
@property PlaceMarkSection placemarkSection;

@end

#endif /* PlacemarkConfiguration_h */
