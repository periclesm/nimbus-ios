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
@synthesize cloudInitials, cloudName, cloudDetail;

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.backgroundColor = [UIColor clearColor];
	self.cloudInitials.layer.cornerRadius = self.cloudInitials.frame.size.width/2;
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
	[self GetCloudData];
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
	
}

#pragma mark - Data

- (void)GetCloudData
{
	if (cloudArray.count > 0)
		[cloudArray removeAllObjects];
	
	cloudArray = [[EntityController GetSortedItemsFromEntity:@"CloudList" sortBy:@"order" ascending:YES] mutableCopy];
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
	
	CloudList *cl = cloudArray[indexPath.row];
	
	cell.cloudInitials.text = cl.initials;
	cell.cloudName.text = cl.name;
	cell.cloudDetail.text = [Presenter GetCloudDetails:cl.detail];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[self performSegueWithIdentifier:@"detailSegue" sender:nil];
}

@end
