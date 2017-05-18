//
//  NetworkerParameters.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

UIKIT_EXTERN NSString* const cloudList;
UIKIT_EXTERN NSString* const cloudListParam;
UIKIT_EXTERN NSString* const cloudDetail;
UIKIT_EXTERN NSString* const cloudType;

@interface NetworkerParameters : NSObject

+ (NSString*)GetAddressForService:(NSString*)service parameters:(NSDictionary*)params;

@end
