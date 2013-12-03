//
//  DBHelper.h
//  CSJ
//
//  Created by Jeferson on 21/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBHelper : NSObject
+ (void)saveGames:(id)object;
+ (NSArray *)getGames;
+ (void)deleteGames;
@end
