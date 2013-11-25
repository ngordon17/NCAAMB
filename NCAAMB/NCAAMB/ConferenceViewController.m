//
//  ConferenceView.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/20/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "ConferenceViewController.h"
#import "TeamViewController.h"

@implementation ConferenceViewController

@synthesize data;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Get Team Schedule"]) {
        if ([segue.destinationViewController isKindOfClass:[TeamViewController class]]) {
            TeamViewController *teamController = (TeamViewController *)segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            teamController.teamID = [[data objectAtIndex:indexPath.row] valueForKey:@"team_id"];
        }
    }
}

-(void) viewDidLoad {
    DBRequest* dataRequest = [[DBRequest alloc] init:[@"http://dukedb-dma13.cloudapp.net/ncaamb/getTeamStandings.php?conference_id=" stringByAppendingString:self.conferenceID]];
    DBResult* result = [dataRequest exec];
    data = [result getResult];
    NSLog(@"Name: %@", self.conferenceName);
    self.navigationItem.title = self.conferenceName;
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
    StandingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {cell = [[StandingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    
    NSDictionary* row = [data objectAtIndex:indexPath.row];
    
    cell.team_name.text = [@"" stringByAppendingFormat:@"%@ %@", [row valueForKey:@"team_alias"], [row valueForKey:@"team_name"]];
    cell.conference_record.text = [@"" stringByAppendingFormat:@"%@-%@", [row valueForKey:@"num_wins"], [row valueForKey:@"num_losses"]];
    cell.overall_record.text = [@"" stringByAppendingFormat:@"%@-%@", [row valueForKey:@"num_wins"], [row valueForKey:@"num_losses"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
