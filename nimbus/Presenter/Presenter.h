//
//  Presenter.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

@interface Presenter : NSObject

+ (void)GetInitialData;
+ (NSString*)GetCloudDetails:(NSString*)objectId;
+ (NSString*)GetCloudImageURL:(NSString*)objectId;
+ (NSString*)GetCloudType:(NSString*)objectId;

@end
