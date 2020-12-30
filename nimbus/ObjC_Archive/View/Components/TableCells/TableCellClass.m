//
//  TableCellClass.m
//  nimbus
//
//  Created by Pericles Maravelakis on 02/07/2018.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "TableCellClass.h"

@implementation cloudCell
@synthesize cloudInitials, cloudName, cloudDetail;

- (void)awakeFromNib {
	[super awakeFromNib];
	self.backgroundColor = [UIColor clearColor];
}

@end
