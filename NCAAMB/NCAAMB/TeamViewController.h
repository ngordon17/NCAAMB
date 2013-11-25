//
//  TeamViewController.h
//  NCAAMB
//
//  Created by Dustin Alin on 11/24/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBRequest.h"
#import "DBResult.h"
#import "ScheduleViewCell.h"

@interface TeamViewController : UITableViewController

@property (nonatomic, strong) NSString* teamID;
@property (nonatomic, retain) NSArray* data;

@end
