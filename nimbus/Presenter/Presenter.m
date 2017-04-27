//
//  Presenter.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "Presenter.h"

@implementation Presenter

+ (void)GetInitialData
{
	[Networker GetDataFromService:cloudList parameters:nil completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataModeller DataMapForEntity:DataEntityList object:(NSDictionary *)response];
		[EntityController SetItemsToEntity:@"CloudList" items:datamap];
	}];
	
	[Networker GetDataFromService:cloudType parameters:nil completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataModeller DataMapForEntity:DataEntityType object:(NSDictionary *)response];
		[EntityController SetItemsToEntity:@"CloudType" items:datamap];
	}];
	
	[Networker GetDataFromService:cloudDetail parameters:nil completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataModeller DataMapForEntity:DataEntityDetail object:(NSDictionary *)response];
		[EntityController SetItemsToEntity:@"CloudDetail" items:datamap];
	}];
	
///	alternate method to get all data in a single call -- not used for the time being
//	NSDictionary *params = @{@"include":@"detail,type"};
//	[Networker GetDataFromService:cloudListParam parameters:params completion:^(id response) {
//		NSLog(@"response: %@", response);
//	}];
}

+ (CloudList*)GetCloudInfo:(NSString*)objectId
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *cloudListData = [EntityController SearchItemsFromEntity:@"CloudList" predicate:predicate];
	
	return cloudListData[0];
}

+ (NSString*)GetCloudDetails:(NSString*)objectId shortText:(Boolean)shortText
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *clouddetail = [EntityController SearchItemsFromEntity:@"CloudDetail" predicate:predicate];
	
	CloudDetail *cd = clouddetail[0];
	
	if (shortText)
	{
		if ([cd.detail rangeOfString:@"."].location != NSNotFound)
			return [cd.detail substringToIndex:[cd.detail rangeOfString:@"."].location +1];
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
	NSArray *clouddetail = [EntityController SearchItemsFromEntity:@"CloudDetail" predicate:predicate];
	
	CloudDetail *cd = clouddetail[0];
	
	return cd.image;
}

+ (NSString*)GetCloudWikiURL:(NSString*)objectId
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *clouddetail = [EntityController SearchItemsFromEntity:@"CloudDetail" predicate:predicate];
	
	CloudDetail *cd = clouddetail[0];
	
	return cd.wiki;
}

+ (NSString*)GetCloudType:(NSString*)objectId
{
	NSString *predicateString = [NSString stringWithFormat:@"objectId == '%@'", objectId];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
	NSArray *cloudtype = [EntityController SearchItemsFromEntity:@"CloudType" predicate:predicate];
	
	CloudType *ct = cloudtype[0];
	
	return ct.name;
}

@end
