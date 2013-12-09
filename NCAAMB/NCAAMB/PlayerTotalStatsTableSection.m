//
//  PlayerTotalStatsTableSection.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 12/8/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "PlayerTotalStatsTableSection.h"
#import "PlayerStatsViewCell.h"

@implementation PlayerTotalStatsTableSection


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
    cell.mpg.text = [[rows objectAtIndex:row] valueForKey:@"total_minutes"];
    cell.twop.text = [[rows objectAtIndex:row] valueForKey:@"two_percent"];
    cell.threep.text = [[rows objectAtIndex:row] valueForKey:@"three_percent"];
    cell.freep.text = [[rows objectAtIndex:row] valueForKey:@"free_percent"];
    cell.ppg.text = [[rows objectAtIndex:row] valueForKey:@"total_points"];
    cell.orpg.text = [[rows objectAtIndex:row] valueForKey:@"total_offense_rebounds"];
    cell.drpg.text = [[rows objectAtIndex:row] valueForKey:@"total_def_rebounds"];
    cell.spg.text = [[rows objectAtIndex:row] valueForKey:@"total_steals"];
    cell.apg.text = [[rows objectAtIndex:row] valueForKey:@"total_assists"];
    cell.pfpg.text = [[rows objectAtIndex:row] valueForKey:@"total_fouls"];
    return cell;
}

@end
