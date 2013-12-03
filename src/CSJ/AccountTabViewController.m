//
//  AccountTabViewController.m
//  CSJ
//
//  Created by Jeferson on 17/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "AccountTabViewController.h"
#import "AccountViewController.h"


@interface AccountTabViewController ()
{
    NSArray *profile;
}
@end

@implementation AccountTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIStoryBoardSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"detailProfile"]) {
        
        AccountViewController *ac = (AccountViewController *)segue.destinationViewController;
        
        ac.user = [[NSUserDefaults standardUserDefaults] objectForKey:@"gamertag"];

    }
    
}

@end
