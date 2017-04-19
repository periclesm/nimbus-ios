//
//  NetworkIndicator.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "NetworkIndicator.h"

static NSInteger counter;

@implementation NetworkIndicator

+ (void)StartActivity
{
	[self IncreaseActivity];
}

+ (void)IncreaseActivity
{
	counter++;
	[self DisplayIndicator];
}

+ (void)DecreaseActivity
{
	counter--;
	[self DisplayIndicator];
}

+ (void)StopActivity
{
	counter = 0;
	[self DisplayIndicator];
}

+ (void)DisplayIndicator
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = (counter > 0);
}

@end
