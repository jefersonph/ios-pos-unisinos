//
//  CustomSegue.m
//  CompartilheSeuJogo
//
//  Created by Jeferson on 14/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "CustomSegue.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "config.h"

@implementation CustomSegue

-(void)perform
{
    if ([self.identifier isEqualToString:@"Login"]) {
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        LoginViewController *login = (LoginViewController*) self.sourceViewController;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"user[gamertag]": login.gamertag.text, @"user[email]": login.email.text};
        NSString *ws = [config getAPPUrl];
        ws = [ws stringByAppendingString:@"users.json"];
        [manager POST:ws parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [prefs setObject:[responseObject objectForKey:@"id"] forKey:@"id"];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
        }];
        
        [prefs setObject:login.gamertag.text forKey:@"gamertag"];
        [prefs setObject:login.email.text forKey:@"email"];
        [prefs synchronize];

    }
    
    if ([self.identifier isEqualToString:@"Logout"]) {
        NSLog(@"sair");
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs removeObjectForKey:@"gamertag"];
        [prefs synchronize];
    }
        
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    app.window.rootViewController = dst;
    
}

@end
