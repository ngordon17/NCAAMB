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
    
    cell.date.text = [[rows objectAtIndex:row] valueForKey:@"DATE"];
    cell.opponent.text = [[rows objectAtIndex:row] valueForKey:@"OPP"];
    cell.result.text = [[rows objectAtIndex:row] valueForKey:@"RESULT"];
    cell.minutes.text = [[rows objectAtIndex:row] valueForKey:@"MIN"];
    cell.fgma.text = [[rows objectAtIndex:row] valueForKey:@"FGM-FGA"];
    cell.fgp.text = [[rows objectAtIndex:row] valueForKey:@"FGpercent"];
    cell.three_pma.text = [[rows objectAtIndex:row] valueForKey:@"threePM-threePA"];
    cell.threep.text = [[rows objectAtIndex:row] valueForKey:@"threepercent"];
    cell.ftma.text = [[rows objectAtIndex:row] valueForKey:@"FTM-FTA"];
    cell.ftp.text = [[rows objectAtIndex:row] valueForKey:@"Ftpercent"];
    cell.reb.text = [[rows objectAtIndex:row] valueForKey:@"REB"];
    cell.ast.text =[[rows objectAtIndex:row] valueForKey:@"AST"];
    cell.blk.text = [[rows objectAtIndex:row] valueForKey:@"BLK"];
    cell.stl.text = [[rows objectAtIndex:row] valueForKey:@"STL"];
    cell.pf.text = [[rows objectAtIndex:row] valueForKey:@"PF"];
    cell.to.text = [[rows objectAtIndex:row] valueForKey:@"TO"];
    cell.pts.text = [[rows objectAtIndex:row] valueForKey:@"PTS"];
    
    return cell;
}

@end
