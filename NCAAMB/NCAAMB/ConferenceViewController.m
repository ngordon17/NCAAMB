//
//  ConferenceView.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/20/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "ConferenceViewController.h"

@implementation ConferenceViewController

@synthesize data;

-(void) viewDidLoad {
    DBRequest* dataRequest = [[DBRequest alloc] init:@"http://dukedb-dma13.cloudapp.net/ncaamb/getTeamStandings.php?conference_id=b11c69c8-e2cc-4a36-bd3b-80cdf91fef57"];
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
    StandingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {cell = [[StandingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    
    NSDictionary* row = [data objectAtIndex:indexPath.row];
    cell.team_name.text = [row valueForKey:@"team_id"];
    cell.conference_record.text = [[[row valueForKey:@"num_wins"] stringByAppendingString:@"-"]stringByAppendingString:[row valueForKey:@"num_losses"]];
    cell.overall_record.text = [[[row valueForKey:@"num_wins"] stringByAppendingString:@"-"]stringByAppendingString:[row valueForKey:@"num_losses"]];
    return cell;
}

@end
