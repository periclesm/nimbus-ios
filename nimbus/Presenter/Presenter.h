//
//  Presenter.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "EntityController.h"

@interface Presenter : NSObject

+ (void)GetInitialData;

+ (CloudList*)GetCloudInfo:(NSString*)objectId;
+ (NSString*)GetCloudDetails:(NSString*)objectId shortText:(Boolean)shortText;
+ (NSString*)GetCloudImageURL:(NSString*)objectId;
+ (NSString*)GetCloudWikiURL:(NSString*)objectId;
+ (NSString*)GetCloudType:(NSString*)objectId;

@end
