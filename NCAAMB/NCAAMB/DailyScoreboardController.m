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
    DBRequest* dataRequest = [[DBRequest alloc] init:@"http://dukedb-dma13.cloudapp.net/ncaamb/conferences.php"];
    DBResult* result = [dataRequest exec];
    data = [result getResult];
    NSLog(@"Daily Scoreboard Result Size: %d", data.count);
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
