//
//  TouristLocationTableViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/21/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouristLocationTableViewController.h"
#import "PlacemarkSection.h"
#import "HeaderViewConfiguration.h"
#import "TouristLocationMapViewController.h"

@interface TouristLocationTableViewController ()

@property (readonly) NSDictionary* placemarkDictionary;

@end

@implementation TouristLocationTableViewController

@synthesize placemarkDictionary = _placemarkDictionary;

BOOL _seeNameOnly = true;

-(void)viewWillAppear:(BOOL)animated{
    
    /** Set table view delegate and register table view cells **/
    
    [self.tableView setDelegate:self];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableViewCell"];
    
    /** Initialize placemark dictionary from plist file **/
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"PlacemarksNearHostelDictionary" ofType:@"plist"];
    
    _placemarkDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSLog(@"Data Source Dictinoary Debug Info: %@",[_placemarkDictionary description]);
    

    
}


-(void)dismissNavigationController{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)popToRootViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewDidLoad{
    
    
    UIBarButtonItem* backToMenu = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemRewind target:self action:@selector(dismissNavigationController)];
    
    UIBarButtonItem*viewAddressButton = [[UIBarButtonItem alloc]initWithTitle:@"See Name Only" style:UIBarButtonItemStylePlain target:self action:@selector(reloadTableViewToShowAddresses)];
    

    self.navigationItem.leftBarButtonItem = backToMenu;
    self.navigationItem.rightBarButtonItem = viewAddressButton;
    
}

-(void) reloadTableViewToShowAddresses{
    
    _seeNameOnly = !_seeNameOnly;
    
    if(_seeNameOnly){
        [self.navigationItem.rightBarButtonItem setTitle:@"See Full Description"];
    } else {
        [self.navigationItem.rightBarButtonItem setTitle:@"See Name Only"];
    }
    
    [self.tableView reloadData];
}


#pragma mark ******* TABLEVIEW DATA SOURCE METHODS


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [[[self placemarkDictionary] allKeys] count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString* sectionKey = [PlacemarkConfiguration getSectionKeyForPlacemarkSectionInt:(int)section];
    
    NSArray* placemarkArray = [[self placemarkDictionary] valueForKey:sectionKey];
    
    
    return [placemarkArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* tableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    
    tableViewCell.textLabel.attributedText = [self getAttributedStringForTitleAt:indexPath];
    
    return tableViewCell;
    
}

#pragma mark *********** TABLEVIEW DELEGATE METHODS


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary* placemarkDict = [self getPlacemarkDictForIndexPath:indexPath];
    
    NSString* name = [placemarkDict valueForKey:@"Name"];
    NSString* street = [placemarkDict valueForKey:@"Street"];
    NSString* city = [placemarkDict valueForKey:@"City"];
    NSString* postalCode = [placemarkDict valueForKey:@"PostalCode"];
    NSString* imageFileName = [placemarkDict valueForKey:@"ImageFilePath"];
    CGFloat longitude = [[placemarkDict valueForKey:@"Longitude"] doubleValue];
    CGFloat latitude = [[placemarkDict valueForKey:@"Latitude"] doubleValue];
    NSString* country = [placemarkDict valueForKey:@"Country"];
    NSString* isoCountry = [placemarkDict valueForKey:@"ISOCountry"];
    PlaceMarkSection placemarkSection = [[placemarkDict valueForKey:@"PlacemarkSection"] integerValue];
    
    
    NSLog(@"You selected %@ on %@ at %@, in %@, at latitude: %f, longitude: %f. The corresponding image filename is: %@",name,street, postalCode,country, latitude,longitude,imageFileName);
    
    PlacemarkConfiguration* placemarkConfigObject = [[PlacemarkConfiguration alloc] initWithName:name andWithLongitude:longitude andWithLatitude:latitude andWithStreet:street andWithCity:city andWithCountry:country andWithPostalCode:postalCode andWithISOCountry:isoCountry andWithPlaceMarkSection:placemarkSection];
    
    TouristLocationMapViewController* touristLocationMapViewController = [[TouristLocationMapViewController alloc] initWithPlacemarkConfiguration:placemarkConfigObject];
    
    [self presentViewController:touristLocationMapViewController animated:YES completion:nil];
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString* headerTitle = [PlacemarkConfiguration getSectionKeyForPlacemarkSectionInt:(int)section];
    
    return headerTitle;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* headerView = [[UIView alloc]init];
    
    HeaderViewConfiguration* headerViewConfiguration = [HeaderViewConfiguration getHeaderViewConfigurationForSection:section];
    
    NSString* imageName = [headerViewConfiguration imageName];
    UIFont* titleFont = [headerViewConfiguration titleFont];
    UIColor* textColor = [headerViewConfiguration textColor];
    NSString* text = [headerViewConfiguration text];
    
    UIImageView* headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    [headerImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [headerView addSubview:headerImageView];
    
    UILabel* labelView = [[UILabel alloc]init];
    [labelView setFont:titleFont];
    [labelView setText:text];
    [labelView setTextColor:textColor];
    
    [labelView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [headerView addSubview:labelView];
    
    
    
    NSArray<NSLayoutConstraint*>* headerViewConstraint = [NSArray arrayWithObjects:[[headerImageView centerYAnchor] constraintEqualToAnchor:[headerView centerYAnchor]],
        [[headerImageView leftAnchor] constraintEqualToAnchor:[headerView leftAnchor] constant:15.00],
        [[labelView centerYAnchor] constraintEqualToAnchor:[headerImageView centerYAnchor]],
        [[labelView leftAnchor] constraintEqualToAnchor:[headerImageView leftAnchor] constant:30.0], nil];
    
    [NSLayoutConstraint activateConstraints:headerViewConstraint];

    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}



-(NSDictionary *)placemarkDictionary{
    
    if(!_placemarkDictionary){
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"PlacemarksNearHostelDictionary" ofType:@"plist"];
        
        _placemarkDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
        
        
    }
    
    return _placemarkDictionary;
}


-(NSDictionary*) getPlacemarkDictForIndexPath:(NSIndexPath*)indexPath{
    
    int section = (int)[indexPath section];
    int row = (int)[indexPath row];
    
    NSString* sectionKey = [PlacemarkConfiguration getSectionKeyForPlacemarkSectionInt:section];
    NSArray* sectionPlacemarkArray = [[self placemarkDictionary] valueForKey:sectionKey];
    
    NSDictionary* placemarkDict = [sectionPlacemarkArray objectAtIndex:row];
    
    return placemarkDict;
}

- (NSMutableAttributedString*) getAttributedStringForTitleAt:(NSIndexPath*)indexPath{
    NSDictionary* placemarkDict = [self getPlacemarkDictForIndexPath:indexPath];
    
    NSString* name = (NSString*)[placemarkDict valueForKey:@"Name"];
    
    NSString* street = [placemarkDict valueForKey:@"Street"];
    NSString* postalCode = [placemarkDict valueForKey:@"PostalCode"];
    
    NSString* fullString;
    
    if(_seeNameOnly){
        fullString = [NSString stringWithFormat:@"%@",name];

    } else {
        fullString = [NSString stringWithFormat:@"%@ on %@",name,street];

    }
    
    NSMutableAttributedString* cellString = [[NSMutableAttributedString alloc]initWithString:fullString];
    
    
    [cellString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"IowanOldStyle-BoldItalic" size:15.0] range:NSMakeRange(0, [name length])];
    
    NSShadow* shadowConfiguration = [[NSShadow alloc]init];
    
    [shadowConfiguration setShadowOffset:CGSizeMake(1.0, 1.0)];
    [shadowConfiguration setShadowBlurRadius:1.00];
    
    [cellString addAttribute:NSShadowAttributeName value:shadowConfiguration range:NSMakeRange(0, [name length])];
    
    [cellString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Cochin" size:13.0] range:NSMakeRange([name length], [cellString length] - [name length])];
    
    return cellString;
}


@end
