//
//  RosterViewCell.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/26/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "RosterViewCell.h"

@implementation RosterViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
