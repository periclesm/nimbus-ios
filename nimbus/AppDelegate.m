//
//  AppDelegate.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[MagicalRecord setupAutoMigratingCoreDataStack];
	[MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelError];
	return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[MagicalRecord cleanUp];
}

@end
