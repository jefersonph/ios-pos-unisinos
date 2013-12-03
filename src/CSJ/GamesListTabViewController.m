//
//  GamesListTabViewController.m
//  CSJ
//
//  Created by Jeferson on 15/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "GamesListTabViewController.h"
#import "AFNetworking.h"
#import "Game.h"
#import "GamesParser.h"
#import "UIImageView+AFNetworking.h"
#import "DBHelper.h"
#import "config.h"


@interface GamesListTabViewController ()
{
    NSArray *games;
}
@end

@implementation GamesListTabViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    
    [self fetchData];
    [self.tableView setContentInset:UIEdgeInsetsMake(25, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - FetchData
-(void)fetchData{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"gamertag"];
    NSString *ws = [config getXBOXUrl];
    ws = [ws stringByAppendingString:@"games/"];
    ws = [ws stringByAppendingString:user];
    ws = [ws stringByAppendingString:@".json"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:ws parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        games = [GamesParser parseObject:[responseObject objectForKey:@"Games"]];
        
        //[DBHelper deleteGames];
        //[DBHelper saveGames:[responseObject objectForKey:@"Games"]];
        
        [self.tableView reloadData];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"Error: %@", error);
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return games.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"jogosCelula";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Game *g = [games objectAtIndex:indexPath.row];
    
    cell.textLabel.text = g.name;
    
    NSString *ap = @"Achievements: ";
    cell.detailTextLabel.text = [ap stringByAppendingString:[NSString stringWithFormat:@"%@", g.achievements]];
    
    NSURL *url = [NSURL URLWithString:g.image];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [cell.imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"gameplaceholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        cell.imageView.image = image;

        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    return cell;
}

@end
