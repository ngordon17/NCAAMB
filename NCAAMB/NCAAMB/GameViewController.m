//
//  GameViewController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/26/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize data;
@synthesize gameID;

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
    DBRequest* dataRequest = [[DBRequest alloc] init:[@"http://dukedb-dma13.cloudapp.net/ncaamb/getBoxScore.php?game_id" stringByAppendingString: gameID]];
    DBResult* result = [dataRequest exec];
    data = [result getResult];
    NSLog(@"Team Result Size: %d", data.count);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
