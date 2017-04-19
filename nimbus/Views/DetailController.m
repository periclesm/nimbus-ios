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
	IBOutlet UIImageView *cloudImage;
	IBOutlet UILabel *cloudInitials;
	IBOutlet UILabel *cloudName;
	IBOutlet UITextView *cloudDetails;
}

@end

@implementation DetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	
}

@end
