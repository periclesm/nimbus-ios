//
//  Networker.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "NetworkIndicator.h"
#import "NetworkerParameters.h"

@interface Networker : NSObject <NSURLSessionDelegate>

+ (void)GetDataFromService:(NSString*)service parameters:(NSDictionary*)params completion:(void (^)(id response))completion;
+ (void)GetRemoteImage:(NSString*)imageURL completion:(void (^)(UIImage *image))completion;

@end
