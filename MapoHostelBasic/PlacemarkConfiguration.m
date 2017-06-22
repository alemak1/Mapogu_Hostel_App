//
//  PlacemarkConfiguration.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/22/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlacemarkConfiguration.h"

@interface PlacemarkConfiguration ()


@end


@implementation PlacemarkConfiguration


-(id) initWithName:(NSString*)name andWithLongitude:(CGFloat)longitude andWithLatitude:(CGFloat)latitude andWithStreet:(NSString*)street andWithCity:(NSString*)city andWithCountry:(NSString*)country andWithPostalCode:(NSString*)postalCode andWithISOCountry:(NSString*)isoCountry andWithPlaceMarkSection:(PlaceMarkSection)placeMarkSection{
    
    self = [self initWithName:name andWithLongitude:longitude andWithLatitude:latitude andWithStreet:street andWithCity:city andWithCountry:country andWithPostalCode:postalCode andWithISOCountry:isoCountry];
    
    if(self){
        
        _placemarkSection = placeMarkSection;
    }
    
    return self;
}

-(id) initWithName:(NSString*)name andWithLongitude:(CGFloat)longitude andWithLatitude:(CGFloat)latitude andWithStreet:(NSString*)street andWithCity:(NSString*)city andWithCountry:(NSString*)country andWithPostalCode:(NSString*)postalCode andWithISOCountry:(NSString*)isoCountry{
    
    self = [super init];
    
    if(self){
        
        _name = name;
        _street = street;
        _city = city;
        _country = country;
        _isoCountry = isoCountry;
        _postalCode = postalCode;
        _longitude = longitude;
        _latitude = latitude;
    }
    
    return self;
}

-(id) initWithLongitude:(CGFloat)longitude andWithLatitude:(CGFloat)latitude{
    
    self = [super init];
    
    if(self){
        
        _name = [[NSString alloc] init];
        _street = [[NSString alloc] init];
        _city = [[NSString alloc] init];
        _country = [[NSString alloc] init];
        _isoCountry = [[NSString alloc] init];
        _postalCode = [[NSString alloc] init];
        
        _longitude = longitude;
        _latitude = latitude;
    }
    
    return self;
}

+(NSString*) getSectionKeyForPlacemarkSectionInt:(PlaceMarkSection)placeMarkSection{
    switch (placeMarkSection) {
        case CONVENIENCE_STORES:
            return @"Convenience Stores";
        case KOREAN_BARBECUE:
            return @"Korean Barbecue";
        case OTHER_RESTAURANTS:
            return @"Other Restaurants/Snack Shops";
        case PHONE_MOBILE_SERVICES:
            return @"Phone/Mobile Service";
        case PHARMACY_DRUGSTORE:
            return @"Pharmacy/DrugStore";
        case COFFEE_SHOPS:
            return @"Coffee Shops";
        case SPORTS_RECREATION:
            return @"Sports/Recreation";
    }
    
    return nil;
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"Placemark Configuration Object with Name: %@, Street: %@, Postal Code: %@, Country: %@, ISO Country: %@, Latitude: %f, Longitude: %f",_name,_street,_postalCode,_country,_isoCountry,_latitude,_longitude];;
}


#pragma mark ******** MKAnnotation Protocol 

-(CLLocationCoordinate2D)coordinate{

    return CLLocationCoordinate2DMake([self latitude], [self longitude]);
}

-(NSString *)title{
    return [self name];
}


-(NSString *)subtitle{
    return [NSString stringWithFormat:@"%@, %@",[self street],[self postalCode]];
}

@end
