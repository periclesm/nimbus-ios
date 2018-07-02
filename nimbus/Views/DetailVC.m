//
//  DetailVC.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "DetailVC.h"
@import SafariServices;

@interface DetailVC ()
{
	IBOutlet UIImageView *clImage;
	IBOutlet UILabel *clInitials;
	IBOutlet UILabel *clName;
	IBOutlet UILabel *clAltitude;
	IBOutlet UILabel *clDetails;
}

@end

@implementation DetailVC

- (void)viewDidLoad
{
	[self GetCloudData];
    [super viewDidLoad];
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
		self->clImage.image = image;
		[UIView animateWithDuration:0.25 animations:^{ self->clImage.alpha = 1; }];
	}];
}

#pragma mark - IBActions

- (IBAction)WikiButton:(id)sender
{
	CloudList *cl = [Presenter GetCloudInfo:self.objectId];
	SFSafariViewController *safariView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[Presenter GetCloudWikiURL:cl.detail]]];
	[self presentViewController:safariView animated:YES completion:nil];
}

@end
