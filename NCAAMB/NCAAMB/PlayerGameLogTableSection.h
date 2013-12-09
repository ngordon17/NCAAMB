//
//  PlayerGameLogTableSection.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 12/9/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerGameLogTableSection : NSObject

@property(nonatomic, copy) NSString* header;
@property(nonatomic, copy) NSArray* rows;

-(NSInteger) numberOfRows;
-(UITableViewCell *) cellInTableView: (UITableView *) tableView forRow: (NSInteger) row;


@end
