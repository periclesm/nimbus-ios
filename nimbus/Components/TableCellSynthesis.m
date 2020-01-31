//
//  TableCellSynthesis.m
//  nimbus
//
//  Created by Pericles Maravelakis on 02/07/2018.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "TableCellSynthesis.h"

@implementation TableCellSynthesis

+ (cloudCell*)CloudCell:(UITableView*)tableView datasource:(NSArray*)datasource index:(NSIndexPath*)indexPath
{
	cloudCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cloudCell" forIndexPath:indexPath];
	CloudList *cl = datasource[indexPath.row];

	cell.cloudInitials.text = cl.initials;
	cell.cloudName.text = cl.name;
	cell.cloudDetail.text = [DataLogic GetCloudDetails:cl.detail shortText:YES];

	return cell;
}

@end
