//
//  MainController.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

@interface MainController : UITableViewController

@end


@interface cloudCell : UITableViewCell

@property (nonatomic, weak, nullable) IBOutlet UILabel *cloudInitials;
@property (nonatomic, weak, nullable) IBOutlet UILabel *cloudName;
@property (nonatomic, weak, nullable) IBOutlet UILabel *cloudDetail;

@end
