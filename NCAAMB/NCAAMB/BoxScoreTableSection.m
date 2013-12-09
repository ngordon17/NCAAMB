//
//  BoxScoreTableSection.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 12/9/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "BoxScoreTableSection.h"
#import "BoxScoreCell.h"

@implementation BoxScoreTableSection


@synthesize header;
@synthesize rows;

-(NSInteger) numberOfRows {
    return rows.count;
}

-(UITableViewCell *) cellInTableView: (UITableView *) tableView forRow:(NSInteger)row {
    BoxScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {cell = [[BoxScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    
    cell.name.text = [[rows objectAtIndex:row] valueForKey:@"player_name"];
    cell.position.text = @"F";
    cell.min.text = [[rows objectAtIndex:row] valueForKey:@"minutes"];
    cell.fgma.text = [NSString stringWithFormat:@"%@-%@", [[rows objectAtIndex:row] valueForKey:@"field_goal_makes"], [[rows objectAtIndex:row] valueForKey: @"field_goal_attempts"]];
    cell.three_pma.text = [NSString stringWithFormat:@"%@-%@", [[rows objectAtIndex:row] valueForKey:@"three_point_makes"], [[rows objectAtIndex:row] valueForKey: @"three_point_attempts"]];
    cell.ftma.text = [NSString stringWithFormat:@"%@-%@", [[rows objectAtIndex:row] valueForKey:@"free_throw_makes"], [[rows objectAtIndex:row] valueForKey: @"free_throw_attempts"]];
    cell.oreb.text = [[rows objectAtIndex:row] valueForKey:@"offensive_rebounds"];
    cell.dreb.text = [[rows objectAtIndex:row] valueForKey:@"defensive_rebounds"];
    cell.reb.text = [NSString stringWithFormat:@"%f", [cell.oreb.text floatValue] + [cell.dreb.text floatValue]];
    cell.ast.text = [[rows objectAtIndex:row] valueForKey:@"assists"];
    cell.stl.text = [[rows objectAtIndex:row] valueForKey:@"steals"];
    //cell.blk.text = [[rows objectAtIndex:row] valueForKey:@"blocks"];
    //cell.to.text = [[rows objectAtIndex:row] valueForKey:@"turnovers"];
    cell.pf.text = [[rows objectAtIndex:row] valueForKey:@"personal_fouls"];
    cell.pts.text = [[rows objectAtIndex:row] valueForKey:@"points"];

    return cell;
}

@end
