//
//  GamesParser.m
//  CSJ
//
//  Created by Jeferson on 15/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "GamesParser.h"
#import "Game.h"
@implementation GamesParser
+ (NSMutableArray *)parseObject:(id)object
{
    
    NSMutableArray *games = [NSMutableArray array];
    
    for (NSDictionary *_game in object) {
        Game *g = [[Game alloc] init];
        g.gameid = [_game objectForKey:@"ID"];
        g.name = [_game objectForKey:@"Name"];
        g.image =[_game objectForKey:@"BoxArt"][@"Small"];
        g.achievements = [_game objectForKey:@"Progress"][@"Achievements"];
        [games addObject:g];
        g = nil;
    }
  
    return games;
}

+ (NSMutableArray *)getName:(id)object
{
    
    NSMutableArray *games = [NSMutableArray array];
    
    for (NSDictionary *_game in object) {
        [games addObject:[_game objectForKey:@"Name"]];
    }
    
    return games;
}

@end
