//
//  NSResult.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/20/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "DBResult.h"

@implementation DBResult

@synthesize result;
@synthesize data;

-(DBResult *) init: (NSData *) xml_data {
    data = xml_data;
    
   // NSLog(@"DATA LENGTH: %u", [data length]);
    result = [[NSMutableArray alloc] init];
    [self parse];
    return self;
}

-(void) parse {
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
}

-(NSArray *) getResult {
    return [[NSArray alloc] initWithArray:result];
}

#pragma mark - NSXMLParser Delegate

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"Parse error: %@", [NSString stringWithFormat:@"Error code %i", [parseError code]]);
    NSLog(@"Error Description: %@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    NSLog(@"Parse Validation Error: %@", [NSString stringWithFormat:@"Error code %i", [validationError code]]);
    NSLog(@"Error Description: %@", [validationError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if (![elementName isEqualToString:@"xml"]) {
        [result addObject: attributeDict];
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {}

-(void)parserDidStartDocument:(NSXMLParser *)parser {}

-(void)parserDidEndDocument:(NSXMLParser *)parser {}


@end
