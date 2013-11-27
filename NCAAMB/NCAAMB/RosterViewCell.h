//
//  RosterViewCell.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/26/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RosterViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel *name;
@property(nonatomic, strong) IBOutlet UILabel *position;
@property(nonatomic, strong) IBOutlet UILabel *height;
@property(nonatomic, strong) IBOutlet UILabel *weight;
@property(nonatomic, strong) IBOutlet UILabel *year;
@property(nonatomic, strong) IBOutlet UILabel *number;
@property(nonatomic, strong) IBOutlet UILabel *birthplace;

@end
