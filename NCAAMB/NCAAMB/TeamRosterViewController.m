//
//  TeamRosterViewController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/26/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "TeamRosterViewController.h"

@implementation TeamRosterViewController

@synthesize data;
@synthesize teamID;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Get Player Bio"]) {
        if ([segue.destinationViewController isKindOfClass:[PlayerViewController class]]) {
            PlayerViewController *playerController = (PlayerViewController *)segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            playerController.playerID = [[data objectAtIndex:indexPath.row] valueForKey:@"id"];
        }
    }
}

-(void) viewDidLoad {
    DBRequest* dataRequest = [[DBRequest alloc] init:[@"" stringByAppendingFormat: @"%@%@", @"http://dukedb-dma13.cloudapp.net/ncaamb/getTeamPlayers.php?team_id=", teamID]];
    DBResult* result = [dataRequest exec];
    data = [result getResult];
    NSLog(@"Player Result Size: %d", data.count);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    cell.textLabel.text = [[data objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}


@end
