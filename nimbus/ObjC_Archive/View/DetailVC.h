//
//  DetailVC.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

@interface DetailVC : UITableViewController {
	IBOutlet UIImageView *clImage;
	IBOutlet UILabel *clInitials;
	IBOutlet UILabel *clName;
	IBOutlet UILabel *clAltitude;
	IBOutlet UILabel *clDetails;
	IBOutlet DGActivityIndicatorView *activity;
}

@property (nonatomic, nonnull, strong) NSString *objectId;

@end
