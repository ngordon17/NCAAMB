//
//  TeamRosterViewController.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/26/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBRequest.h"
#import "DBResult.h"
#import "PlayerViewController.h"

@interface TeamRosterViewController : UITableViewController


@property(nonatomic, strong) NSArray* data;
@property(nonatomic, strong) NSString* teamID;

@end
