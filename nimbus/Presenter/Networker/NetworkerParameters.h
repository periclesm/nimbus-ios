//
//  NetworkerParameters.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

UIKIT_EXTERN NSString* const cloudList;
UIKIT_EXTERN NSString* const cloudListParam;
UIKIT_EXTERN NSString* const cloudDetail;
UIKIT_EXTERN NSString* const cloudType;

@interface NetworkerParameters : NSObject

+ (NSString*)GetAddressForService:(NSString*)service parameters:(NSDictionary*)params;

@end
