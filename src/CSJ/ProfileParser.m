//
//  ProfileParser.m
//  CSJ
//
//  Created by Jeferson on 24/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "ProfileParser.h"
#import "Profile.h"

@implementation ProfileParser

+ (NSMutableArray *)parseObject:(id)object
{
    
    NSMutableArray *profile = [NSMutableArray array];
    NSMutableArray *rc = [NSMutableArray array];
    
    Profile *p = [[Profile alloc] init];
    p.gamertag = [object objectForKey:@"Player"][@"Gamertag"];
    p.image = [object objectForKey:@"Player"][@"Avatar"][@"Body"];
    p.gamerscore = [object objectForKey:@"Player"][@"Gamerscore"];
    p.reputation = [object objectForKey:@"Player"][@"Reputation"];

    for (NSDictionary *_recent in [object objectForKey:@"RecentGames"]) {
        [rc addObject: [_recent objectForKey:@"Name"]];
    }
    
    p.act1 = [rc objectAtIndex:0];
    p.act2 = [rc objectAtIndex:1];
    p.act3 = [rc objectAtIndex:2];
    [profile addObject:p];
    
    return profile;
}

@end
