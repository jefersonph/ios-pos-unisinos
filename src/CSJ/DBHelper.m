//
//  DBHelper.m
//  CSJ
//
//  Created by Jeferson on 21/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "DBHelper.h"
#import "SCSQLite.h"

@implementation DBHelper

+ (void)saveGames:(id)object
{
    [SCSQLite initWithDatabase:@"database.db"];

    for (NSDictionary *_game in object) {
        [SCSQLite executeSQL:@"insert into games (id, name, achievements, image) values ('%@', '%@', '%@', '%@')", [_game objectForKey:@"ID"], [_game objectForKey:@"Name"] , [_game objectForKey:@"Progress"], [_game objectForKey:@"BoxArt"][@"Small"]];

    }

}

+ (NSArray *)getGames
{
    [SCSQLite initWithDatabase:@"database.db"];
    
    NSArray *friends = [SCSQLite selectRowSQL:@"Select * from games"];

    return friends;
}

+ (void)deleteGames
{
    [SCSQLite initWithDatabase:@"database.db"];
    
    BOOL delete = [SCSQLite executeSQL:@"delete from games"];
    
    NSLog(@"deletado: %hhd", delete);
    
}
@end
