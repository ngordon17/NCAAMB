//
//  GameLogCell.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 12/9/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameLogCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel *date;
@property(nonatomic, strong) IBOutlet UILabel *opponent;
@property(nonatomic, strong) IBOutlet UILabel *result;
@property(nonatomic, strong) IBOutlet UILabel *minutes;
@property(nonatomic, strong) IBOutlet UILabel *fgma;
@property(nonatomic, strong) IBOutlet UILabel *fgp;
@property(nonatomic, strong) IBOutlet UILabel *three_pma;
@property(nonatomic, strong) IBOutlet UILabel *threep;
@property(nonatomic, strong) IBOutlet UILabel *ftma;
@property(nonatomic, strong) IBOutlet UILabel *ftp;
@property(nonatomic, strong) IBOutlet UILabel *reb;
@property(nonatomic, strong) IBOutlet UILabel *ast;
@property(nonatomic, strong) IBOutlet UILabel *blk;
@property(nonatomic, strong) IBOutlet UILabel *stl;
@property(nonatomic, strong) IBOutlet UILabel *pf;
@property(nonatomic, strong) IBOutlet UILabel *to;
@property(nonatomic, strong) IBOutlet UILabel *pts;



@end
