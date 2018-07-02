//
//  DataMapper.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

typedef NS_ENUM(NSInteger, DataEntity)
{
	DataEntityList = 0,
	DataEntityType,
	DataEntityDetail
};

@interface DataMapper : NSObject

+ (NSArray*)DataMapForEntity:(DataEntity)class object:(NSDictionary*)objects;

@end

