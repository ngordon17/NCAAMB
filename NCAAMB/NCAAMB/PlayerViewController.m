//
//  PlayerViewController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/25/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayerGameLogTableSection.h"


@implementation PlayerViewController

@synthesize player_bio_data;
@synthesize player_season_stats;
@synthesize player_season_game_log;
@synthesize header;
@synthesize player_season_totals;
@synthesize stats;
@synthesize playerID;
@synthesize tableSections;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    player_bio_data = [self getPlayerData:@"http://dukedb-dma13.cloudapp.net/ncaamb/getPlayer.php?player_id=" player:playerID];
  
    
    player_season_stats = [self getPlayerData:@"http://dukedb-dma13.cloudapp.net/ncaamb/getStats.php?player_id=" player:playerID];
    
    player_season_game_log = [self getPlayerData:@"http://dukedb-dma13.cloudapp.net/ncaamb/getGameLog.php?player_id=" player:playerID];
    
    [self initHeader];
    [self initStats];
}

-(NSArray *) getPlayerData: (NSString*) url player: (NSString*) pid {
    DBRequest* request = [[DBRequest alloc] init: [@"" stringByAppendingFormat:@"%@%@", url, pid]];
    DBResult* result = [request exec];
    return [result getResult];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView 

- (void) initHeader {
    NSDictionary* player_bio = [player_bio_data objectAtIndex:0];
    NSDictionary* player_stats = [player_season_stats objectAtIndex:0];
    NSString *htmlFile = @"/Users/yankeenjg/Desktop/NCAAMB/NCAAMB/NCAAMB/PlayerViewHTML.html";
   // NSString *htmlFile = @"/Users/dalin/Desktop/School/Duke/Senior Fall/CS 316/NCAAMB/NCAAMB/NCAAMB/PlayerViewHTML.html";
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_PLAYER_NAME" withString:[@"" stringByAppendingFormat:@"%@ %@", [player_bio valueForKey:@"first_name"], [player_bio valueForKey:@"last_name"]]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_NUMBER_POSITION" withString:[@"" stringByAppendingFormat:@"%@ %@", [player_bio valueForKey:@"jersey_number"], [player_bio valueForKey:@"position"]]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_YEAR" withString:[player_bio valueForKey:@"year"]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_TEAM_NAME" withString:[@"" stringByAppendingFormat:@"%@ %@", [player_bio valueForKey:@"team_alias"], [player_bio valueForKey:@"team_name"]]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_BIRTH_DATE" withString:@"November 20, 1992"];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_HOME_TOWN" withString:[player_bio valueForKey:@"birthplace"]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_HEIGHT" withString:[player_bio valueForKey:@"height"]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_WEIGHT" withString:[player_bio valueForKey:@"weight"]];

    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_PPG" withString:[player_stats valueForKey:@"avg_points"]];
    
    float rpg = [[player_stats valueForKey:@"avg_def_rebounds"] floatValue] + [[player_stats valueForKey:@"avg_offense_rebounds"] floatValue];
    
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_RPG" withString:[NSString stringWithFormat: @"%f", rpg]];
    htmlString = [htmlString stringByReplacingOccurrencesOfString:@"$_APG" withString:[player_stats valueForKey: @"avg_assists"]];
    
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
    
    //if(self.navigationController.navigationBar.translucent == YES) {
        view.scrollView.contentOffset = CGPointMake(view.frame.origin.x, view.frame.origin.y - 55);
    //}
}

#pragma mark - UITableView

-(void) initStats {
    PlayerAvgStatsTableSection* section1 = [[PlayerAvgStatsTableSection alloc] init];
    [section1 setRows: player_season_stats];
    [section1 setHeader:@"Season Averages"];
    PlayerTotalStatsTableSection* section2 = [[PlayerTotalStatsTableSection alloc] init];
    [section2 setRows: player_season_stats];
    [section2 setHeader:@"Season Totals"];
    PlayerGameLogTableSection* section3 = [[PlayerGameLogTableSection alloc] init];
    [section3 setRows: player_season_game_log];
    [section3 setHeader: @"Game Log"];
    [self setTableSections: [NSArray arrayWithObjects: section1, section2, section3, nil]];
    [stats setDelegate:self];
    [stats setDataSource:self];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return tableSections.count;
}

- (NSString*)tableView: (UITableView*)tableView titleForHeaderInSection: (NSInteger)section {
    return [[tableSections objectAtIndex: section] header];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [[tableSections objectAtIndex: section] numberOfRows];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[tableSections objectAtIndex: indexPath.section] cellInTableView: tableView forRow: indexPath.row];
}

@end
