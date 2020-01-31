//
//  NetworkIndicator.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
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
