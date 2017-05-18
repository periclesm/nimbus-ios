//
//  IntroController.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "IntroController.h"

@interface IntroController ()

@end

@implementation IntroController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[Presenter GetInitialData];
}

@end
