//
//  Presenter.h
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "DataQuery.h"

@interface Presenter : NSObject

+ (void)GetInitialData;

+ (CloudList*)GetCloudInfo:(NSString*)objectId;
+ (NSString*)GetCloudDetails:(NSString*)objectId shortText:(Boolean)shortText;
+ (NSString*)GetCloudImageURL:(NSString*)objectId;
+ (NSString*)GetCloudWikiURL:(NSString*)objectId;
+ (NSString*)GetCloudType:(NSString*)objectId;

@end
