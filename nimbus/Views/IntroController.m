//
//  IntroController.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
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
