//
//  AccountViewController.h
//  CSJ
//
//  Created by Jeferson on 17/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Profile.h"

@interface AccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *gamertag;
@property (weak, nonatomic) IBOutlet UILabel *gamerscore;
@property (weak, nonatomic) IBOutlet UILabel *reputation;
@property (weak, nonatomic) IBOutlet UILabel *act1;
@property (weak, nonatomic) IBOutlet UILabel *act2;
@property (weak, nonatomic) IBOutlet UILabel *act3;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, strong) NSString *user;
-(void)fetchData;
@end
