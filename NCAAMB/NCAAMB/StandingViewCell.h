//
//  StandingViewCell.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/24/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StandingViewCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel *team_name;
@property(nonatomic, strong) IBOutlet UILabel *conference_record;
@property(nonatomic, strong) IBOutlet UILabel *overall_record;


@end
