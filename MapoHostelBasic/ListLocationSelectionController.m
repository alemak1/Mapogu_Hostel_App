//
//  ListLocationSelectionController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/19/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListLocationSelectionController.h"


@interface ListLocationSelectionController ()

@property (readonly) NSDictionary* dataSourceDictionary;

@end



@implementation ListLocationSelectionController


@synthesize dataSourceDictionary = _dataSourceDictionary;

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"LocationTableCell"];
    
    NSLog(@"The contentds of the dataSource dictionary are: %@",[_dataSourceDictionary description]);
    
}

-(void)viewDidLoad{
    
    
}


#pragma mark TABLEVIEW DATASOURCE METHODS

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* locationTableCell = [self.tableView dequeueReusableCellWithIdentifier:@"LocationTableCell"];
    
    
    return locationTableCell;
    
}


#pragma mark TABLEVIEW DELEGATE METHODS

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [[UIView alloc]init];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    return [[UIView alloc]init];
}


-(NSDictionary *)dataSourceDictionary{
    
    if(_dataSourceDictionary == nil){
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"PlacemarksNearHostelDictionary" ofType:@"plist"];
        
        _dataSourceDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return _dataSourceDictionary;
}

@end
