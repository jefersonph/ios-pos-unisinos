//
//  GamesParser.h
//  CSJ
//
//  Created by Jeferson on 15/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GamesParser : NSObject
+ (NSMutableArray *)parseObject:(id)object;
+ (NSMutableArray *)getName:(id)object;
@end
