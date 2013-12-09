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
    BoxScoreTableSection* section1 = [[BoxScoreTableSection alloc] init];
    [section1 setRows: data];
    [section1 setHeader:@"Home"];
    BoxScoreTableSection* section2 = [[BoxScoreTableSection alloc] init];
    [section2 setRows: data];
    [section2 setHeader:@"Away"];
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
