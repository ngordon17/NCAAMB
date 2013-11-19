//
//  ConferenceNavigationController.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/14/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnector.h"

@interface ConferenceNavigationController : UITableViewController <UITableViewDataSource, ServiceConnectorDelegate, NSXMLParserDelegate>

@property(nonatomic, retain) NSMutableArray* conferenceData;
@property(nonatomic, weak) IBOutlet UITableView* CNCTableView;

/**
 * Retrieve the number of cells that must be created in the table
 * @param tableView: the table view in question
 * @param numberOfRowsInSection: number of rows for a given section of the view
 * @return number of cells to create in the table i.e. number of conferences
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 * Create table cells to serve as buttons to go to specific conference views.
 * @param tableView: the table view in question
 * @param cellForrowAtIndexPath: index path for the newly created cell
 * @return UITableViewCell representing a conference
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)getDown;

@end