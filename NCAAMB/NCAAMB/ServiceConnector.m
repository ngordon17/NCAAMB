//
//  ServiceConnector.m
//  NCAAMB
//
//  Created by Dustin Alin on 11/19/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "ServiceConnector.h"

@implementation ServiceConnector
NSData *receivedData;

-(void)getTest:(NSString *)url {
    //build up the request that is to be sent to the server
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    //initialize an NSURLConnection with the request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!connection) {
        NSLog(@"Connection Failed");
    }
}

#pragma mark - Data connection delegate -

//executed when the connection receives data
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    receivedData = data;
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    /*This message is sent when there is an authentication challenge ,our server does not have this requirement so we do not need to handle that here*/
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Request Complete,recieved %lu bytes of data",(unsigned long)receivedData.length);
        [self.delegate requestReturnedData:receivedData];
    });
}

@end
