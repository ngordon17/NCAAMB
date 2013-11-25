//
//  TeamViewController.m
//  NCAAMB
//
//  Created by Dustin Alin on 11/24/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "TeamViewController.h"
#import "Util.h"

@implementation TeamViewController

@synthesize data;

-(void) viewDidLoad {
    DBRequest* dataRequest = [[DBRequest alloc] init:@"http://dukedb-dma13.cloudapp.net/ncaamb/getTeamSchedule.php?team_id=290a5130-836d-45e6-824f-28704d6ba246"];
    DBResult* result = [dataRequest exec];
    data = [result getResult];
    NSLog(@"Team Result Size: %d", data.count);
    [super viewDidLoad];
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
    //cell.home_team_name.text = @"JOE";
    NSLog(@"%@",[@"" stringByAppendingFormat:@"%@ %@", [row valueForKey:@"home_team_alias"], [row valueForKey:@"home_team_name"]]);
    cell.home_record.text = [@"" stringByAppendingFormat:@"%@-%@", [row valueForKey:@"home_team_wins"], [row valueForKey:@"home_teams_losses"]];
    cell.home_score.text = [row valueForKey:@"home_score"];
    
    cell.away_team_name.text = [@"" stringByAppendingFormat:@"%@ %@", [row valueForKey:@"away_team_alias"], [row valueForKey:@"away_team_name"]];
    cell.away_record.text = [@"" stringByAppendingFormat:@"%@-%@", [row valueForKey:@"away_team_wins"], [row valueForKey:@"away_teams_losses"]];
    cell.away_score.text = [row valueForKey:@"away_score"];
    
    cell.scheduled.text = [row valueForKey:@"scheduled"];
    
    return cell;
}

@end
