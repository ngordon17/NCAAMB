//
//  XMLParser.m
//  NCAAMB
//
//  Created by Dustin Alin on 11/20/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser

-(instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        self.attributes = [[NSMutableDictionary alloc] init];
        self.parser = [[NSXMLParser alloc] initWithData:data];
        [self.parser setDelegate:self];
    }
    return self;
}

-(NSMutableDictionary *)parse {
    [self.parser parse];
    return self.attributes;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
}

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    //NSLog(@"didStartDocument");
}

-(void)parserDidEndDocument:(NSXMLParser *)parser {
    //NSLog(@"didEndDocument");
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //print all attributes for this element
    NSEnumerator *attributes = [attributeDict keyEnumerator];
    NSString *key, *value;
    
    while((key = [attributes nextObject]) != nil) {
        NSMutableArray *dictArray = [self.attributes objectForKey:key];
        if (dictArray == nil) {
            dictArray = [[NSMutableArray alloc] init];
        }
        value = [attributeDict objectForKey:key];
        [dictArray addObject:value];
        [self.attributes setObject:dictArray forKey:key];
        NSLog(@"attribute: %@ = %@", key, value);
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //NSLog(@"didEndElement: %@", elementName);
}

// error handling
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"XMLParser error: %@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    NSLog(@"XMLParser error: %@", [validationError localizedDescription]);
}

@end
