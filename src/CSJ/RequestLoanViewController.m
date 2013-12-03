//
//  RequestLoanViewController.m
//  CSJ
//
//  Created by Jeferson on 17/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "RequestLoanViewController.h"
#import "AFNetworking.h"
#import "Friend.h"
#import "FriendParser.h"
#import "Game.h"
#import "GamesParser.h"
#import "config.h"

@interface RequestLoanViewController ()

@end

@implementation RequestLoanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [self fetchFriends];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchGames:(id)user
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
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

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if(pickerView == self.friendsPicker)
        return [self.friends objectAtIndex:row];
    else
        return [self.games objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    
    if(pickerView == self.friendsPicker){
        [self.games addObject:@"aguarde.."];

        [self fetchGames:[[self.friends objectAtIndex:row] stringByReplacingOccurrencesOfString:@" " withString:@""]];
        
        [self.gamesPicker reloadAllComponents];
        
        self.friend = [self.friends objectAtIndex:row];
        NSLog(@"selected friend: %@", self.friend);

    }else{
        self.game = [self.games objectAtIndex:row];
        NSLog(@"selected game: %@", self.game);
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


- (IBAction)sendRequest:(id)sender {
    
    NSString *subject = @"Pode me emprestar o jogo ";
    subject = [subject stringByAppendingString:self.game];
    
    NSString  *text = @"Olá ";
    text = [text stringByAppendingString:self.friend];
    text = [text stringByAppendingString:@"\n Pode me emprestar o jogo "];
    text = [text stringByAppendingString:self.game];
    text = [text stringByAppendingString:@"?\n Baixe o aplicativo http://bit.ly/compartilheSeuJogo \n Obrigado."];
    self.mailComposer = [[MFMailComposeViewController alloc]init];
    self.mailComposer.mailComposeDelegate = self;
    [self.mailComposer setSubject:subject];
    [self.mailComposer setMessageBody:text isHTML:NO];
    [self presentModalViewController:self.mailComposer animated:YES];
     
}

#pragma mark - mail compose delegate
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    if (result) {
        NSLog(@"Result : %d",result);
    }
    if (error) {
        NSLog(@"Error : %@",error);
    }
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
