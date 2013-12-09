//
//  PlayerGameLogTableSection.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 12/9/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "PlayerGameLogTableSection.h"
#import "GameLogCell.h"

@implementation PlayerGameLogTableSection


@synthesize header;
@synthesize rows;

-(NSInteger) numberOfRows {
    return rows.count;
}

-(UITableViewCell *) cellInTableView: (UITableView *) tableView forRow:(NSInteger)row {
    GameLogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
    if (cell == nil) {cell = [[GameLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell1"];}
    
    cell.date.text = [[rows objectAtIndex:row] valueForKey:@"scheduled_datetime"];
    cell.opponent.text = [[rows objectAtIndex:row] valueForKey:@""];
    cell.result.text = [[rows objectAtIndex:row] valueForKey:@""];
    cell.minutes.text = [[rows objectAtIndex:row] valueForKey:@"minutes"];
    cell.fgma.text = [[rows objectAtIndex:row] valueForKey:@"two_points"];
    cell.fgp.text = [[rows objectAtIndex:row] valueForKey:@"two_points"];
    cell.three_pma.text = [[rows objectAtIndex:row] valueForKey:@"three_points"];
    cell.threep.text = [[rows objectAtIndex:row] valueForKey:@"three_points"];
    cell.ftma.text = [[rows objectAtIndex:row] valueForKey:@"free_points"];
    cell.ftp.text = [[rows objectAtIndex:row] valueForKey:@"free_points"];
    cell.reb.text = [[rows objectAtIndex:row] valueForKey:@"offensive_rebounds"];
    cell.ast.text =[[rows objectAtIndex:row] valueForKey:@"assists"];
    cell.blk.text = [[rows objectAtIndex:row] valueForKey:@"blocks"];
    cell.stl.text = [[rows objectAtIndex:row] valueForKey:@"steals"];
    cell.pf.text = [[rows objectAtIndex:row] valueForKey:@"personal_fouls"];
    cell.to.text = [[rows objectAtIndex:row] valueForKey:@"turnovers"];
    cell.pts.text = [[rows objectAtIndex:row] valueForKey:@"points"];
    
    return cell;
}

@end
