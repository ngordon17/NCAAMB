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
@property(nonatomic, strong) IBOutlet UILabel *min;
@property(nonatomic, strong) IBOutlet UILabel *fg;
@property(nonatomic, strong) IBOutlet UILabel *fgp;
@property(nonatomic, strong) IBOutlet UILabel *three;
@property(nonatomic, strong) IBOutlet UILabel *threep;
@property(nonatomic, strong) IBOutlet UILabel *ft;
@property(nonatomic, strong) IBOutlet UILabel *ftp;
@property(nonatomic, strong) IBOutlet UILabel *reb;
@property(nonatomic, strong) IBOutlet UILabel *ast;
@property(nonatomic, strong) IBOutlet UILabel *blk;
@property(nonatomic, strong) IBOutlet UILabel *stl;
@property(nonatomic, strong) IBOutlet UILabel *pf;
@property(nonatomic, strong) IBOutlet UILabel *to;
@property(nonatomic, strong) IBOutlet UILabel *pts;


@end
