//
//  LoanViewController.m
//  CSJ
//
//  Created by Jeferson on 17/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "LoanViewController.h"
#import "AFNetworking.h"
#import "Friend.h"
#import "FriendParser.h"
#import "Game.h"
#import "GamesParser.h"
#import "config.h"
#import "AFNetworking.h"

@interface LoanViewController ()

@end

@implementation LoanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [self fetchGames];
    [self fetchFriends];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)fetchGames
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"gamertag"];
    NSString *ws = [config getXBOXUrl];
    ws = [ws stringByAppendingString:@"games/"];
    ws = [ws stringByAppendingString:user];
    ws = [ws stringByAppendingString:@".json"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:ws parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.games = [GamesParser getName:[responseObject objectForKey:@"Games"]];
        
        [self.gamesPicker reloadAllComponents];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"Error: %@", error);
        
    }];
}

-(void)fetchFriends
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"gamertag"];
    NSString *ws = [config getXBOXUrl];
    ws = [ws stringByAppendingString:@"friends/"];
    ws = [ws stringByAppendingString:user];
    ws = [ws stringByAppendingString:@".json"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:ws parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.friends = [FriendParser getName:[responseObject objectForKey:@"Friends"]];
        
        [self.friendsPicker reloadAllComponents];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"Error: %@", error);
        
    }];
    
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == self.friendsPicker)
        return [self.friends objectAtIndex:row];
    else
        return [self.games objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView == self.friendsPicker){
        self.friend = [self.friends objectAtIndex:row];
        
    }else{
        self.game = [self.games objectAtIndex:row];
        
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if(pickerView == self.friendsPicker){
        return self.friends.count;
    }else{
        return self.games.count;
    }
    
}


- (IBAction)loan:(id)sender {
    
    NSString* userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"lend[to]": self.friend, @"lend[game_id]": self.game};
    NSString *ws = [config getAPPUrl];
    ws = [ws stringByAppendingString:@"users/"];
    ws = [ws stringByAppendingString:[NSString stringWithFormat:@"%@", userid]];
    ws = [ws stringByAppendingString:@"/lends.json"];
    [manager POST:ws parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Empréstimo efetuado." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
    }];
   
}

@end
