//
//  PDataLogic.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "DataLogic.h"

@implementation DataLogic

+ (void)GetInitialData
{
	[Networker GetDataFromService:cloudList parameters:nil completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataMapper DataMapForEntity:DataEntityList object:(NSDictionary *)response];
		[DataQuery SetItemsToEntity:@"CloudList" items:datamap];
	}];
	
	[Networker GetDataFromService:cloudType parameters:nil completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataMapper DataMapForEntity:DataEntityType object:(NSDictionary *)response];
		[DataQuery SetItemsToEntity:@"CloudType" items:datamap];
	}];
	
	[Networker GetDataFromService:cloudDetail parameters:nil completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataMapper DataMapForEntity:DataEntityDetail object:(NSDictionary *)response];
		[DataQuery SetItemsToEntity:@"CloudDetail" items:datamap];
	}];
}

+ (NSString*)GetCloudType:(NSString*)objectId
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *cloudtype = [DataQuery SearchItemsFromEntity:@"CloudType" predicate:predicate];

	CloudType *ct = cloudtype.firstObject;

	return ct.name;
}

+ (CloudList*)GetCloudInfo:(NSString*)objectId
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *cloudListData = [DataQuery SearchItemsFromEntity:@"CloudList" predicate:predicate];

	return cloudListData.firstObject;
}

+ (NSString*)GetCloudDetails:(NSString*)objectId shortText:(Boolean)shortText
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *clouddetail = [DataQuery SearchItemsFromEntity:@"CloudDetail" predicate:predicate];
	
	CloudDetail *cd = clouddetail.firstObject;
	
	if (shortText)
	{
		if ([cd.detail rangeOfString:@"."].location != NSNotFound)
			return [cd.detail substringToIndex:[cd.detail rangeOfString:@"."].location + 1];
		else
			return cd.detail;
	}
	else
		return cd.detail;
}

+ (NSString*)GetCloudImageURL:(NSString*)objectId
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *clouddetail = [DataQuery SearchItemsFromEntity:@"CloudDetail" predicate:predicate];
	
	CloudDetail *cd = clouddetail.firstObject;
	
	return cd.image;
}

+ (NSString*)GetCloudWikiURL:(NSString*)objectId
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *clouddetail = [DataQuery SearchItemsFromEntity:@"CloudDetail" predicate:predicate];
	
	CloudDetail *cd = clouddetail.firstObject;
	
	return cd.wiki;
}

@end
