//
//  PlayerStatsTableSection.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/26/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "PlayerStatsTableSection.h"
#import "PlayerStatsViewCell.h"

@implementation PlayerStatsTableSection

@synthesize header;
@synthesize rows;

-(NSInteger) numberOfRows {
    return rows.count;
}

-(UITableViewCell *) cellInTableView: (UITableView *) tableView forRow:(NSInteger)row {
    PlayerStatsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {cell = [[PlayerStatsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    cell.season.text = @"2013-14";
    cell.team.text = @"Duke Blue Devils";
    cell.mpg.text = [[rows objectAtIndex:row] valueForKey:@"MPG"];
    cell.twop.text = [[rows objectAtIndex:row] valueForKey:@"two_percent"];
    cell.threep.text = [[rows objectAtIndex:row] valueForKey:@"three_percent"];
    cell.freep.text = [[rows objectAtIndex:row] valueForKey:@"free_percent"];
    cell.ppg.text = [[rows objectAtIndex:row] valueForKey:@"avg_points"];
    cell.orpg.text = [[rows objectAtIndex:row] valueForKey:@"ORPG"];
    cell.drpg.text = [[rows objectAtIndex:row] valueForKey:@"DRPG"];
    cell.spg.text = [[rows objectAtIndex:row] valueForKey:@"SPG"];
    cell.apg.text = [[rows objectAtIndex:row] valueForKey:@"APG"];
    cell.pfpg.text = [[rows objectAtIndex:row] valueForKey:@"PFPG"];
    return cell;
}

@end
