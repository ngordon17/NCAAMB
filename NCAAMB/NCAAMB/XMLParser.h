//
//  XMLParser.h
//  NCAAMB
//
//  Created by Dustin Alin on 11/20/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, retain) NSMutableDictionary* attributes;
@property (nonatomic, retain) NSXMLParser* parser;

-(instancetype)initWithData:(NSData *)data;
-(NSMutableDictionary *)parse;

@end
