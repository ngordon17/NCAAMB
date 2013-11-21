//
//  NSResult.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/20/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBResult : NSObject <NSXMLParserDelegate>

@property(nonatomic, strong) NSMutableArray* result;
@property(nonatomic, strong) NSData* data;

-(DBResult *) init: (NSData *) xml_data;
-(void) parse;
-(NSArray *) getResult;

@end
