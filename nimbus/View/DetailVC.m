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

@implementation DetailVC

- (void)viewDidLoad
{
	[self GetCloudData];
    [super viewDidLoad];

	activity.type = DGActivityIndicatorAnimationTypeBallRotate;
	activity.size = activity.frame.size.width-8.0f;
	activity.tintColor = [UIColor lightGrayColor];
}

#pragma mark - Data

- (void)GetCloudData
{	
	CloudList *cl = [DataLogic GetCloudInfo:self.objectId];
	
	self.title = cl.name;
	clInitials.text = cl.initials;
	clName.text = cl.name;
	clAltitude.text = [[DataLogic GetCloudType:cl.type] stringByAppendingString:@" altitude"];
	clDetails.text = [DataLogic GetCloudDetails:cl.detail shortText:NO];

	clImage.alpha = 0;
	[activity startAnimating];
	[Networker GetRemoteImage:[DataLogic GetCloudImageURL:cl.detail] completion:^(UIImage *image) {
		self->clImage.image = image;
		[UIView animateWithDuration:0.25 animations:^{ self->clImage.alpha = 1; }];
		[self->activity stopAnimating];
	}];
}

#pragma mark - IBActions

- (IBAction)WikiButton:(id)sender
{
	CloudList *cl = [DataLogic GetCloudInfo:self.objectId];
	SFSafariViewController *safariView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[DataLogic GetCloudWikiURL:cl.detail]]];
	[self presentViewController:safariView animated:YES completion:nil];
}

@end
