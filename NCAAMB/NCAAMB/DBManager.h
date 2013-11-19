//
//  DBManager.h
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/15/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//


#import <libpq/libpq-fe.h>

@interface DBManager : NSObject

-(void) initConnection;
-(PGconn* ) getConnection;

@end


