//
//  TeamTabControllerViewController.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/29/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamTabController: UITabBarController

@property(nonatomic, strong) NSString* teamID;

- (void) initTabs: (NSString *) teamID;

@end
