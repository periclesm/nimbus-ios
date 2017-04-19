//
//  MainController.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainController : UITableViewController

@end


@interface cloudCell : UITableViewCell

@property (nonatomic, weak, nullable) IBOutlet UIImageView *cloudImage;
@property (nonatomic, weak, nullable) IBOutlet UILabel *cloudName;
@property (nonatomic, weak, nullable) IBOutlet UILabel *cloudDetail;

@end
