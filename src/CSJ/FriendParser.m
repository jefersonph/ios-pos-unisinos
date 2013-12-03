//
//  FriendParser.m
//  CompartilheSeuJogo
//
//  Created by Jeferson on 14/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "FriendParser.h"
#import "Friend.h"

@implementation FriendParser

+ (NSMutableArray *)parseObject:(id)object
{

    NSMutableArray *friends = [NSMutableArray array];
    
    for (NSDictionary *_friend in object) {
        Friend *f = [[Friend alloc] init];
        f.gamertag = [_friend objectForKey:@"GamerTag"];
        f.gamerscore = [_friend objectForKey:@"GamerScore"];
        f.image = [_friend objectForKey:@"LargeGamerTileUrl"];
        [friends addObject:f];
        f = nil;
    }
    
    return friends;
}
+ (NSMutableArray *)getName:(id)object
{
    NSMutableArray *friends = [NSMutableArray array];
    
    for (NSDictionary *_friend in object) {
        [friends addObject:[_friend objectForKey:@"GamerTag"]];
    }
    
    return friends;
    
}
@end
