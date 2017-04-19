//
//  DataModeller.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

typedef NS_ENUM(NSInteger, DataEntity)
{
	DataEntityList = 0,
	DataEntityType,
	DataEntityDetail
};

@interface DataModeller : NSObject

+ (NSArray*)DataMapForEntity:(DataEntity)class object:(NSDictionary*)objects;

@end

