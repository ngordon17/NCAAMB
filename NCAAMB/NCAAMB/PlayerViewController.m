//
//  PlayerViewController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/25/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "PlayerViewController.h"


@implementation PlayerViewController

@synthesize data;
@synthesize header;
@synthesize stats;
@synthesize playerID;



- (void)viewDidLoad {
    [super viewDidLoad];
    DBRequest* dataRequest = [[DBRequest alloc] init:[@"" stringByAppendingFormat:@"%@%@", @"http://dukedb-dma13.cloudapp.net/ncaamb/getPlayer.php?player_id=", playerID]];
    DBResult* result = [dataRequest exec];
    data = [result getResult];
    [self initHeader];
    [self initStats];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView 

- (void) initHeader {
    NSDictionary* player_bio = [data objectAtIndex:0];
    NSString *htmlFile = @"/Users/yankeenjg/Desktop/PlayerViewHTML.html";
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_PLAYER_NAME" withString:[@"" stringByAppendingFormat:@"%@ %@", [player_bio valueForKey:@"first_name"], [player_bio valueForKey:@"last_name"]]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_NUMBER_POSITION" withString:[@"" stringByAppendingFormat:@"%@ %@", [player_bio valueForKey:@"jersey_number"], [player_bio valueForKey:@"position"]]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_YEAR" withString:[player_bio valueForKey:@"year"]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_TEAM_NAME" withString:[@"" stringByAppendingFormat:@"%@ %@", [player_bio valueForKey:@"team_alias"], [player_bio valueForKey:@"team_name"]]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_BIRTH_DATE" withString:@"November 20, 1992"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_HOME_TOWN" withString:[player_bio valueForKey:@"birthplace"]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_HEIGHT" withString:[player_bio valueForKey:@"height"]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_WEIGHT" withString:[player_bio valueForKey:@"weight"]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_PPG" withString:@"0"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_RPG" withString:@"0"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_APG" withString:@"0"];
    
    [header loadHTMLString:htmlString baseURL:nil];
    header.delegate = self;
}

- (void) webViewDidFinishLoad:(UIWebView *) view {
    CGSize contentSize = header.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    header.scrollView.minimumZoomScale = rw;
    header.scrollView.maximumZoomScale = rw;
    header.scrollView.zoomScale = rw;
    header.scrollView.scrollEnabled = NO;
    header.scrollView.bounces = NO;
    
    if(self.navigationController.navigationBar.translucent == YES) {
        view.scrollView.contentOffset = CGPointMake(view.frame.origin.x, view.frame.origin.y - 55);
    }
}

#pragma mark - UITableView

-(void) initStats {
    [stats setDelegate:self];
    [stats setDataSource:self];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerStatsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {cell = [[PlayerStatsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];}
    cell.season.text = @"2013-14";
    NSLog(@"%@=%@", @"SEASON", cell.season);
    return cell;
}


@end
