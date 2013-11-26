//
//  PlayerViewController.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/25/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBRequest.h"
#import "DBResult.h"
#import "PlayerStatsViewCell.h"
#import "PlayerStatsTableSection.h"

@interface PlayerViewController : UIViewController <UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) IBOutlet UIWebView* header;
@property(nonatomic, retain) IBOutlet UITableView* stats;
@property(nonatomic, retain) NSArray* tableSections;
@property(nonatomic, strong) NSArray* data;
@property(nonatomic, strong) NSString* playerID;

@end
