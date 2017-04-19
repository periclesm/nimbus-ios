//
//  MainController.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "MainController.h"

#pragma mark - Table Cells

@implementation cloudCell
@synthesize cloudImage, cloudName, cloudDetail;

- (void)awakeFromNib
{
	self.backgroundColor = [UIColor clearColor];
	
	self.cloudImage.layer.cornerRadius = self.cloudImage.frame.size.width/2;
	
	[super awakeFromNib];
}

@end

#pragma mark - Table View Controller

@interface MainController ()
{
	NSMutableArray *cloudArray;
}

@end

@implementation MainController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	cloudArray = [NSMutableArray array];
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cloudArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cloudCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cloudCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
