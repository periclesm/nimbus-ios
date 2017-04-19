//
//  DetailController.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "DetailController.h"

@interface DetailController ()
{
	IBOutlet UIImageView *clImage;
	IBOutlet UILabel *clInitials;
	IBOutlet UILabel *clName;
	IBOutlet UITextView *clDetails;
}

@end

@implementation DetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self GetCloudData];
	
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Data

- (void)GetCloudData
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", self.objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *cloudListData = [EntityController SearchItemsFromEntity:@"CloudList" predicate:predicate];
	
	CloudList *cl = cloudListData[0];
	clInitials.text = cl.initials;
	clName.text = cl.name;
	self.title = cl.name;
	
	clDetails.text = [Presenter GetCloudDetails:cl.detail];
	
	[Networker GetRemoteImage:[Presenter GetCloudImageURL:cl.detail] completion:^(UIImage *image) {
		clImage.image = image;
	}];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
