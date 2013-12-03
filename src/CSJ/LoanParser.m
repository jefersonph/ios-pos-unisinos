//
//  LoanParser.m
//  CSJ
//
//  Created by Jeferson on 23/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "LoanParser.h"
#import "Loan.h"
@implementation LoanParser

+ (NSMutableArray *)parseObject:(id)object
{
    
    NSMutableArray *loans = [NSMutableArray array];
    
    for (NSDictionary *_l in object) {
        Loan *loan = [[Loan alloc] init];
        loan.game = [_l objectForKey:@"game_id"];
        loan.to = [_l objectForKey:@"to"];
        loan.userid = [_l objectForKey:@"user_id"];
        loan.loanid = [_l objectForKey:@"id"];
        [loans addObject:loan];
        loan = nil;
    }
    
    return loans;
}

@end
