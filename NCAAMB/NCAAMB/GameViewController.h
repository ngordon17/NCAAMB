//
//  GameViewController.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/26/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBRequest.h"
#import "DBResult.h"

@interface GameViewController : UITableViewController

@property (nonatomic, retain) NSArray* data;
@property(nonatomic, retain) NSArray* tableSections;
@property (nonatomic, strong) NSString* gameID;

@end
