//
//  DataQuery.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "CloudList+CoreDataClass.h"
#import "CloudType+CoreDataClass.h"
#import "CloudDetail+CoreDataClass.h"

#import "DataMapper.h"

@interface DataQuery : NSObject

#pragma mark - Get
+ (NSInteger)GetItemCountFromEntity:(NSString*)entity;
+ (NSArray*)GetItemsFromEntity:(NSString*)entity;
+ (NSArray*)GetSortedItemsFromEntity:(NSString*)entity sortBy:(NSString*)sort ascending:(Boolean)asc;

#pragma mark - Set
+ (void)SetItemsToEntity:(NSString*)entity items:(NSArray*)items;

#pragma mark - Delete
+ (void)DeleteAllItemsFromEntity:(NSString*)entity;
+ (void)DeleteItemFromEntity:(NSString*)entity predicate:(NSPredicate*)pred;

#pragma mark - Search
+ (NSArray*)SearchItemsFromEntity:(NSString*)entity predicate:(NSPredicate*)pred;

@end
