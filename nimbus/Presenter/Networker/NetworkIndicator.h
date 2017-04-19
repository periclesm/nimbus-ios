//
//  NetworkIndicator.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

@interface NetworkIndicator : NSObject

+ (void)StartActivity;
+ (void)IncreaseActivity;
+ (void)DecreaseActivity;
+ (void)StopActivity;

@end
