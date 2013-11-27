//
//  PlayerStatsViewCell.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/25/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerStatsViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel *season;
@property(nonatomic, strong) IBOutlet UILabel *team;
@property(nonatomic, strong) IBOutlet UILabel *mpg;
@property(nonatomic, strong) IBOutlet UILabel *twop;
@property(nonatomic, strong) IBOutlet UILabel *threep;
@property(nonatomic, strong) IBOutlet UILabel *freep;
@property(nonatomic, strong) IBOutlet UILabel *ppg;
@property(nonatomic, strong) IBOutlet UILabel *orpg;
@property(nonatomic, strong) IBOutlet UILabel *drpg;
@property(nonatomic, strong) IBOutlet UILabel *spg;
@property(nonatomic, strong) IBOutlet UILabel *apg;
@property(nonatomic, strong) IBOutlet UILabel *pfpg;

@end
