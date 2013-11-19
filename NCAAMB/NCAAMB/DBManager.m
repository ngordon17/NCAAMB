//
//  DBManager.m
//  NCAAMB
//
//  Created by Nicholas Gordon on 11/15/13.
//  Copyright (c) 2013 Nicholas Gordon. All rights reserved.
//


#import "DBManager.h"
#import <stdio.h>



@implementation DBManager

static PGconn* conn;

-(void) initConnection {
    conn = PQsetdbLogin("dukedb-njg10.cloudapp.net", "8080", "", "", "azureuser", "azureuser", "Soccer1792");
    if (PQstatus(conn) != CONNECTION_OK) {
        printf("ERROR: dbname = %s user = %s, pwd = %s, host = %s, port = %s, status = %u", PQdb(conn), PQuser(conn), PQpass(conn), PQhost(conn), PQport(conn), PQstatus(conn));
        printf("ERROR = %s", PQerrorMessage(conn));
    }
    
}

-(PGconn*) getConnection {
    return conn;
}

-(void) closeConnection {
    
}

@end



