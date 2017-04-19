//
//  EntityController.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "CloudList+CoreDataClass.h"
#import "CloudType+CoreDataClass.h"
#import "CloudDetail+CoreDataClass.h"

#import "DataModeller.h"

@interface EntityController : NSObject

#pragma mark - Add
+ (void)SetItemsToEntity:(NSString*)entity items:(NSArray*)items;

#pragma maek - Update
+ (void)UpdateItemsToEntity:(NSString*)entity items:(NSArray*)items;

#pragma mark - Get
+ (NSInteger)GetItemCountFromEntity:(NSString*)entity;
+ (NSArray*)GetItemsFromEntity:(NSString*)entity;
+ (NSArray*)GetSortedItemsFromEntity:(NSString*)entity sortBy:(NSString*)sort ascending:(Boolean)asc;

#pragma mark - Delete
+ (void)DeleteAllItemsFromEntity:(NSString*)entity;
+ (void)DeleteItemFromEntity:(NSString*)entity predicate:(NSPredicate*)pred;

#pragma mark - Search
+ (NSArray*)SearchItemsFromEntity:(NSString*)entity predicate:(NSPredicate*)pred;

@end
