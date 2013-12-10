//
//  GameViewController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/26/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "GameViewController.h"
#import "BoxScoreTableSection.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize data;
@synthesize gameID;
@synthesize home_team;
@synthesize away_team;
@synthesize tableSections;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    DBRequest* dataRequest = [[DBRequest alloc] init:[@"http://dukedb-dma13.cloudapp.net/ncaamb/getBoxScore.php?game_id=" stringByAppendingString: gameID]];
    DBResult* result = [dataRequest exec];
    data = [result getResult];
    NSLog(@"Team Result Size: %d", data.count);
    [self initBoxScore];
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

-(void) initBoxScore {
    NSMutableArray* home = [[NSMutableArray alloc] init];
    NSMutableArray* away = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in data) {
        if ([[dict valueForKey:@"alias"] isEqualToString: home_team]) {
            [home addObject:dict];
        }
        else {
            [away addObject:dict];
        }
    }
    
    BoxScoreTableSection* section1 = [[BoxScoreTableSection alloc] init];
    [section1 setRows: [[NSArray alloc] initWithArray:home]];
    [section1 setHeader: [NSString stringWithFormat:@"%@ - %@", @"Home Team", [[home objectAtIndex:0] valueForKey:@"alias"]]];
    BoxScoreTableSection* section2 = [[BoxScoreTableSection alloc] init];
    [section2 setRows: [[NSArray alloc] initWithArray:away]];
    [section2 setHeader:[NSString stringWithFormat:@"%@ - %@", @"Home Team", [[away objectAtIndex:0] valueForKey:@"alias"]]];
    [self setTableSections: [NSArray arrayWithObjects: section1, section2, nil]];
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
