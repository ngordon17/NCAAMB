//
//  NSRequest.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/20/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBResult.h"

@interface DBRequest : NSObject

@property(nonatomic, strong) NSData* requestData;
@property(nonatomic, strong) NSString* requestURL;

-(DBRequest *) init: (NSString *) url;
-(DBResult *) exec;


@end

