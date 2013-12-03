//
//  AccountViewController.m
//  CSJ
//
//  Created by Jeferson on 17/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "AccountViewController.h"
#import "ProfileParser.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "config.h"
#import "Profile.h"

@interface AccountViewController ()
{
    NSArray *profile;
}
@end

@implementation AccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}

- (void)viewDidLoad
{
    
    [self fetchData];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeModal:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)fetchData
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *ws = [config getXBOXUrl];
    ws = [ws stringByAppendingString:@"profile/"];
    ws = [ws stringByAppendingString:[self.user stringByReplacingOccurrencesOfString:@" " withString:@""]];
    ws = [ws stringByAppendingString:@".json"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:ws parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        profile = [ProfileParser parseObject:responseObject];
        
        Profile *p = [profile objectAtIndex:0];
        
        self.gamertag.text = p.gamertag;
        self.gamerscore.text = [NSString stringWithFormat:@"%@", p.gamerscore];
        self.reputation.text = [NSString stringWithFormat:@"%@", p.reputation];
        self.act1.text = p.act1;
        self.act2.text = p.act2;
        self.act3.text = p.act3;
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        [self.image setImageWithURL:[NSURL URLWithString:p.image] placeholderImage:[UIImage imageNamed:nil]];


        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"Error: %@", error);
        
    }];

}

@end
