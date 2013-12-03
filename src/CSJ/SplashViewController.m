//
//  SplashViewController.m
//  CSJ
//
//  Created by Jeferson on 14/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fechar) userInfo:nil repeats:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fechar
{
    NSString* usuario = [[NSUserDefaults standardUserDefaults] objectForKey:@"gamertag"];
    
    if (usuario == nil)
        [self performSegueWithIdentifier:@"LoginSplah" sender:self];
    else
        [self performSegueWithIdentifier:@"SplashEntrar" sender:self];
    
}

@end
