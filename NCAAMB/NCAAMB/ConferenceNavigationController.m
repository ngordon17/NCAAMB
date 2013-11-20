//
//  ConferenceNavigationController.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/14/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//

#import "ConferenceNavigationController.h"

@implementation ConferenceNavigationController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conferenceData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self.conferenceData objectAtIndex:indexPath.row];
    NSLog(@"%@ \n", cell.textLabel.text );
    
    return cell;
}

- (void)getDown {
    ServiceConnector *serviceConnector = [[ServiceConnector alloc] init];
    serviceConnector.delegate = self;
    [serviceConnector getTest:@"http://dukedb-dma13.cloudapp.net/ncaamb/conferences.php"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.conferenceData = [[NSMutableArray alloc] init];
    [self getDown];
    NSLog(@"Number: %lu", (unsigned long)self.conferenceData.count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ServiceConnectorDelegate -
-(void)requestReturnedData:(NSData *)data {
    XMLParser *parser = [[XMLParser alloc] initWithData:data];
    NSMutableDictionary* dict = [parser parse];
    self.conferenceData = [dict valueForKey:@"name"];
    
    [self.tableView reloadData];
}


@end