//
//  ServiceConnector.h
//  NCAAMB
//
//  Created by Dustin Alin on 11/19/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceConnectorDelegate <NSObject>

-(void)requestReturnedData:(NSData*)data;

@end

@interface ServiceConnector : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (strong, nonatomic) id <ServiceConnectorDelegate> delegate;

-(void)getTest:(NSString *)url;

@end
