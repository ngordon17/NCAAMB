//
//  DailyScoreboardController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/14/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "DailyScoreboardController.h"

@implementation DailyScoreboardController

@synthesize data;


-(void) viewDidLoad {
    DBRequest* dataRequest = [[DBRequest alloc] init:[@"" stringByAppendingFormat:@"%@%@", @"http://dukedb-dma13.cloudapp.net/ncaamb/getDateSchedule.php?date=", [self getCurrentDate]]];
    DBResult* result = [dataRequest exec];
    data = [result getResult];
    NSLog(@"Team Result Size: %d", data.count);
    [super viewDidLoad];
}

-(NSString *) getCurrentDate {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd%20hh:mm:ss"];
    NSString* date = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@", date);
    return date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {cell = [[ScheduleViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    
    NSDictionary* row = [data objectAtIndex:indexPath.row];
    
    cell.home_team_name.text = [@"" stringByAppendingFormat:@"%@ %@", [row valueForKey:@"home_team_alias"], [row valueForKey:@"home_team_name"]];
    cell.home_record.text = [@"" stringByAppendingFormat:@"%@-%@", [row valueForKey:@"home_team_wins"], [row valueForKey:@"home_teams_losses"]];
    cell.home_score.text = [row valueForKey:@"home_score"];
    
    cell.away_team_name.text = [@"" stringByAppendingFormat:@"%@ %@", [row valueForKey:@"away_team_alias"], [row valueForKey:@"away_team_name"]];
    cell.away_record.text = [@"" stringByAppendingFormat:@"%@-%@", [row valueForKey:@"away_team_wins"], [row valueForKey:@"away_teams_losses"]];
    cell.away_score.text = [row valueForKey:@"away_score"];
    
    cell.scheduled_date.text = [[[row valueForKey:@"scheduled_datetime"] componentsSeparatedByString:@" "] objectAtIndex:0];
    cell.scheduled_time.text = [[[row valueForKey:@"scheduled_datetime"] componentsSeparatedByString:@" "] objectAtIndex:1];
    
    return cell;
}


@end
