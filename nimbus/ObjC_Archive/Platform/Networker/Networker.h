//
//  Networker.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "NetworkIndicator.h"
#import "NetworkerParameters.h"

@interface Networker : NSObject <NSURLSessionDelegate>

+ (void)GetDataFromService:(NSString*)service parameters:(NSDictionary*)params completion:(void (^)(id response))completion;
+ (void)GetRemoteImage:(NSString*)imageURL completion:(void (^)(UIImage *image))completion;

@end
