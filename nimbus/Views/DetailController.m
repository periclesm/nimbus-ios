//
//  DetailController.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "DetailController.h"
@import SafariServices;

@interface DetailController ()
{
	IBOutlet UIImageView *clImage;
	IBOutlet UILabel *clInitials;
	IBOutlet UILabel *clName;
	IBOutlet UILabel *clAltitude;
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
	CloudList *cl = [Presenter GetCloudInfo:self.objectId];
	
	self.title = cl.name;
	clInitials.text = cl.initials;
	clName.text = cl.name;
	clAltitude.text = [[Presenter GetCloudType:cl.type] stringByAppendingString:@" altitude"];
	clDetails.text = [Presenter GetCloudDetails:cl.detail shortText:NO];
	
	clImage.alpha = 0;
	[Networker GetRemoteImage:[Presenter GetCloudImageURL:cl.detail] completion:^(UIImage *image) {
		clImage.image = image;
		[UIView animateWithDuration:0.25 animations:^{ clImage.alpha = 1; }];
	}];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		return 240;
	else if (indexPath.section == 1)
		return self.tableView.frame.size.height - 240 - 64;
	else
		return 44;
}

#pragma mark - IBActions

- (IBAction)WikiButton:(id)sender
{
	CloudList *cl = [Presenter GetCloudInfo:self.objectId];
	SFSafariViewController *safariView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[Presenter GetCloudWikiURL:cl.detail]]];
	[self presentViewController:safariView animated:YES completion:nil];
}

@end
