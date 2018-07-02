//
//  NetworkerController.m
//  nimbus
//
//  Created by Pericles Maravelakis on 19/04/2017.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

#import "Networker.h"

@implementation Networker

#pragma mark - Service Data

+ (void)GetDataFromService:(NSString*)service parameters:(NSDictionary*)params completion:(void (^)(id response))completion
{
	[NetworkIndicator IncreaseActivity];
	
	[[Networker new] GetDataFromService:service parameters:params completion:^(id response) {
		[NetworkIndicator DecreaseActivity];
		completion(response);
	}];
}

- (void)GetDataFromService:(NSString*)service parameters:(NSDictionary*)params completion:(void (^)(id response))completion
{
	NSURL *requestURL = [NSURL URLWithString:[NetworkerParameters GetAddressForService:service parameters:params]];
	NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:requestURL];
	
	[postRequest setHTTPMethod:@"GET"];
	[postRequest setTimeoutInterval:30];
	[postRequest setValue:@"Y6372R67Q2UCqCsWuCnD4YZ3ACEiiFxngF6WNqwE" forHTTPHeaderField:@"X-Parse-Application-Id"];
	[postRequest setValue:@"LdJJnrhcCEiY8kRA3vAwg4sxT73LhQu84Efmv796" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
	
	NSURLSessionConfiguration *config = [self SessionConfigurationWithCache:NO];

	NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
	NSURLSessionDataTask *task =  [session dataTaskWithRequest:postRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
		NSArray *responseData = nil;
		
		if (error != nil) //Session Error
		{
			NSLog(@"Error: %@", error.description);
		}
		else if (httpResponse.statusCode != 200) //Status code !200OK
		{
			NSLog(@"Service reported status code: %lu", (long)httpResponse.statusCode);
		}
		else if (data == nil) //If no data received
		{
			NSLog(@"No data received...");
		}
		else //All is well, proceed...
		{
			@try
			{
				NSError *parseError;
				responseData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
				
				if (parseError)
				{
					NSLog(@"Error parsing data: %@", error.description);
					responseData = nil;
				}
			}
			@catch (NSException *exception) //Retry perhaps?
			{
				NSLog(@"Exception raised when parsing data: %@", exception.description);
				responseData = nil;
			}
			@finally { }
		}
		
		completion(responseData);
	}];
	
	[task resume];
	[session finishTasksAndInvalidate];
}

#pragma mark - Image Data

+ (void)GetRemoteImage:(NSString*)imageURL completion:(void (^)(UIImage *image))completion
{
	[NetworkIndicator IncreaseActivity];
	
	[[Networker new] GetRemoteImage:imageURL completion:^(UIImage *image) {
		[NetworkIndicator DecreaseActivity];
		completion(image);
	}];
}

- (void)GetRemoteImage:(NSString*)imageURL completion:(void (^)(UIImage *image))completion
{
	__block UIImage *dnlImage = nil;
	
	NSURLSessionConfiguration *config = [self SessionConfigurationWithCache:YES];
	
	NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
	NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		
		if (data != nil)
		{
			dnlImage = [UIImage imageWithData:data];
			completion(dnlImage);
		}
		else
			completion(nil);
	}];
 
	[task resume];
	[session finishTasksAndInvalidate];
}

#pragma mark - Utilities

- (NSURLSessionConfiguration*)SessionConfigurationWithCache:(Boolean)cached
{
	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
	
	config.requestCachePolicy = cached? NSURLRequestReturnCacheDataElseLoad:NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
	config.HTTPShouldUsePipelining = YES;
	
	config.timeoutIntervalForRequest = 30;
	config.timeoutIntervalForResource = 30;
	
	config.allowsCellularAccess = YES;
	
//	config.sessionSendsLaunchEvents = YES;
//	config.discretionary = YES;
	
	return config;
}

@end
