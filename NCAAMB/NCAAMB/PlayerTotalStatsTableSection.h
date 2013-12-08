//
//  PlayerTotalStatsTableSection.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 12/8/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerTotalStatsTableSection : NSObject


@property(nonatomic, copy) NSString* header;
@property(nonatomic, copy) NSArray* rows;

-(NSInteger) numberOfRows;
-(UITableViewCell *) cellInTableView: (UITableView *) tableView forRow: (NSInteger) row;

@end
