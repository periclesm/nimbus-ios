//
//  NetworkerParameters.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "NetworkerParameters.h"

#define CASE(str)	if ([__s__ isEqualToString:(str)])
#define SWITCH(s)	for (NSString *__s__ = (s); ; )

@implementation NetworkerParameters

NSString* const cloudList		= @"https://stage.rdfn.eu/nimbus/classes/cloudList";
NSString* const cloudListParam	= @"https://stage.rdfn.eu/nimbus/classes/cloudList?";
NSString* const cloudDetail		= @"https://stage.rdfn.eu/nimbus/classes/cloudDetail";
NSString* const cloudType		= @"https://stage.rdfn.eu/nimbus/classes/cloudType";

+ (NSString*)GetAddressForService:(NSString*)service parameters:(NSDictionary*)params
{
	SWITCH(service)
	{
		CASE(cloudList)		{ return cloudList; }
		CASE(cloudListParam){ return [self CloudListWithParameters:params]; }
		CASE(cloudDetail)	{ return cloudDetail; }
		CASE(cloudType)		{ return cloudType; }
	}
	
	return nil;
}

+ (NSString*)CloudListWithParameters:(NSDictionary*)params
{
	NSMutableString *returnString = [NSMutableString stringWithString:cloudListParam];
	NSArray *keys = [params allKeys];
	
	for (NSString* keyValue in keys)
	{
		[returnString appendString:[NSString stringWithFormat:@"&%@=%@", keyValue, params[keyValue]]];
	}
	
	return returnString;
}

@end
