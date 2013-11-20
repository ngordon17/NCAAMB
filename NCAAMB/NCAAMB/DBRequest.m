//
//  NSRequest.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/20/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "DBRequest.h"

@implementation DBRequest
    
@synthesize requestData;
@synthesize requestURL;

-(DBRequest *) init:(NSString *)url {
    requestURL = url;
    return self;
}

-(DBResult *) exec {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:requestURL]];
    NSError* error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    requestData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if ([responseCode statusCode] != 200) {
        NSLog(@"Error getting %@, HTTP status coe %i", requestURL, [responseCode statusCode]);
        return nil;
    }
    
    NSLog(@"HTTP GET request successful for %@", requestURL);
    return [[DBResult  alloc] init:requestData];
}

@end
