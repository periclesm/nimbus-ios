//
//  Presenter.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//  Copyright © 2017 Cloudfields. All rights reserved.
//

#import "Presenter.h"

@implementation Presenter

+ (void)GetInitialData
{
	[Networker GetDataFromService:cloudList completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataModeller DataMapForEntity:DataEntityList object:(NSDictionary *)response];
		[EntityController SetItemsToEntity:@"CloudList" items:datamap];
	}];
	
	[Networker GetDataFromService:cloudType completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataModeller DataMapForEntity:DataEntityType object:(NSDictionary *)response];
		[EntityController SetItemsToEntity:@"CloudType" items:datamap];
	}];
	
	[Networker GetDataFromService:cloudDetails completion:^(id response) {
//		NSLog(@"response: %@", response);
		NSArray *datamap = [DataModeller DataMapForEntity:DataEntityDetail object:(NSDictionary *)response];
		[EntityController SetItemsToEntity:@"CloudDetail" items:datamap];
	}];
}

@end
