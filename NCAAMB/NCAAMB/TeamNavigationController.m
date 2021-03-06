//
//  TeamViewController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/14/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//b11c69c8-e2cc-4a36-bd3b-80cdf91fef57

#import "TeamNavigationController.h"
#import "TeamTabController.h"


@implementation TeamNavigationController

@synthesize data;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TeamSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[TeamTabController class]]) {
            TeamTabController *teamTabController = (TeamTabController *)segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            [teamTabController initTabs: [[data objectAtIndex:indexPath.row] valueForKey:@"id"]];
        }
    }
}

-(void) viewDidLoad {
    DBRequest* dataRequest = [[DBRequest alloc] init:@"http://dukedb-dma13.cloudapp.net/ncaamb/teams.php"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    
    
    NSDictionary* row = [data objectAtIndex:indexPath.row];
    cell.textLabel.text = [[[row valueForKey:@"alias"] stringByAppendingString:@" "] stringByAppendingString:[row valueForKey:@"name"]];
    return cell;
}

#pragma mark - Search Bar Action

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    for (int row = 0; row < data.count; row++) {
        NSDictionary *dict = [data objectAtIndex:row];
        if ([[dict valueForKey:@"alias"] isEqualToString:searchBar.text] || [[dict valueForKey:@"name"] isEqualToString:searchBar.text] || [[[[dict valueForKey:@"alias"] stringByAppendingString:@" "] stringByAppendingString:[dict valueForKey:@"name"]] isEqualToString: searchBar.text]) {
            
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }
   

}


@end
