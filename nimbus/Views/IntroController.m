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
	
	[Networker GetDataFromService:cloudList completion:^(id response) {
		NSLog(@"response: %@", response);
	}];
	
	[Networker GetDataFromService:cloudType completion:^(id response) {
		NSLog(@"response: %@", response);
	}];
	
	[Networker GetDataFromService:cloudDetails completion:^(id response) {
		NSLog(@"response: %@", response);
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
