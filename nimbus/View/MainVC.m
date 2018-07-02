//
//  MainVC.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "MainVC.h"
#import "DetailVC.h"

#pragma mark - Table View Controller

@implementation MainVC

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	cloudArray = [self GetCloudData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"detailSegue"])
	{
		DetailVC *dtc = [segue destinationViewController];
		dtc.objectId = (NSString*)sender;
	}
}

#pragma mark - Data

- (NSMutableArray*)GetCloudData
{
	if (cloudArray.count > 0) [cloudArray removeAllObjects];
	
	return [[DataQuery GetSortedItemsFromEntity:@"CloudList" sortBy:@"order" ascending:YES] mutableCopy];
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
	return [TableCellSynthesis CloudCell:tableView datasource:cloudArray index:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	CloudList *cl = cloudArray[indexPath.row];
	[self performSegueWithIdentifier:@"detailSegue" sender:cl.objectId];
}

@end
