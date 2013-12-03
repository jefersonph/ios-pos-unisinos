//
//  FriendParser.h
//  CompartilheSeuJogo
//
//  Created by Jeferson on 14/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendParser : NSObject
+ (NSMutableArray *)parseObject:(id)object;
+ (NSMutableArray *)getName:(id)object;
@end
