//
//  DataModeller.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "DataModeller.h"

@implementation DataModeller

+ (NSArray*)DataMapForEntity:(DataEntity)class object:(NSDictionary*)objects
{
	NSMutableArray *dataMap = [NSMutableArray array];
	NSArray *data = objects[@"results"];
	
	if (data.count > 0)
	{
		switch (class)
		{
			case DataEntityList:
			{
				for (NSDictionary *result in data)
				{
					NSDictionary *dataDict = @{
											   @"objectId": [self ProcessValue:result[@"objectId"]],
											   @"order": [self ProcessValue:result[@"order"]],
											   @"name": [self ProcessValue:result[@"name"]],
											   @"initials": [self ProcessValue:result[@"initials"]],
											   @"detail": [self ProcessValue:result[@"detail"][@"objectId"]],
											   @"type": [self ProcessValue:result[@"type"][@"objectId"]],
											   };
					
					[dataMap addObject:dataDict];
				}
				
				break;
			}
				
			case DataEntityType:
			{
				for (NSDictionary *result in data)
				{
					NSDictionary *dataDict = @{
											   @"objectId": [self ProcessValue:result[@"objectId"]],
											   @"name": [self ProcessValue:result[@"name"]],
											   @"detail": [self ProcessValue:result[@"detail"]]
											   };
					
					[dataMap addObject:dataDict];
				}
				
				break;
			}
				
			case DataEntityDetail:
			{
				for (NSDictionary *result in data)
				{
					NSDictionary *dataDict = @{
											   @"objectId": [self ProcessValue:result[@"objectId"]],
											   @"detail": [self ProcessValue:result[@"detail"]],
											   @"image": [self ProcessValue:result[@"image"]],
											   @"wiki": [self ProcessValue:result[@"wiki"]]
											   };
					
					[dataMap addObject:dataDict];
				}
				
				break;
			}
		}
	}
	
	return [NSArray arrayWithArray:dataMap];
}

+ (id)ProcessValue:(id)object
{
	id returnObject;
	
	if (object == nil || object == [NSNull null])
	{
		returnObject = [NSNull null];
	}
	else if ([object isKindOfClass:[NSString class]])
	{
		NSString *objString = object;
		
		if ([objString isEqualToString:@"nil"] || objString.length == 0)
			returnObject = [NSNull null];
		else
			returnObject = [objString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
	else
	{
		returnObject = object;
	}
	
	return returnObject;
}

@end
