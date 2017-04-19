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
NSString* const cloudDetails	= @"https://stage.rdfn.eu/nimbus/classes/cloudDetails";
NSString* const cloudType		= @"https://stage.rdfn.eu/nimbus/classes/cloudType";

+ (NSString*)GetAddressForService:(NSString*)service parameters:(NSDictionary*)params
{
	SWITCH(service)
	{
		CASE(cloudList)		{ return cloudList; }
		CASE(cloudDetails)	{ return cloudDetails; }
		CASE(cloudType)		{ return cloudType; }
	}
	
	return nil;
}

@end
