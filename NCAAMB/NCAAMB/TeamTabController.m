//
//  TeamTabControllerViewController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/29/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "TeamTabController.h"
#import "TeamRosterViewController.h"
#import "TeamViewController.h"

@implementation TeamTabController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initTabs: (NSString *) teamID {
    [((TeamRosterViewController *) self.viewControllers[1]) setTeamID: teamID];
    [((TeamViewController *) self.viewControllers[0]) setTeamID: teamID];
}


@end
