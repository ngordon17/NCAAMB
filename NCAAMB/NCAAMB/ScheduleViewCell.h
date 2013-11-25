//
//  ScheduleViewCell.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/24/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel *home_team_name;
@property(nonatomic, strong) IBOutlet UILabel *home_record;
@property(nonatomic, strong) IBOutlet UILabel *home_score;
@property(nonatomic, strong) IBOutlet UILabel *away_team_name;
@property(nonatomic, strong) IBOutlet UILabel *away_record;
@property(nonatomic, strong) IBOutlet UILabel *away_score;
@property(nonatomic, strong) IBOutlet UILabel *scheduled;


@end
