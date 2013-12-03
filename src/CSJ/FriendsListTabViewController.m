//
//  FriendsListTabViewController.m
//  CSJ
//
//  Created by Jeferson on 14/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "FriendsListTabViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "FriendParser.h"
#import "Friend.h"
#import "config.h"
#import "AccountViewController.h"

@interface FriendsListTabViewController ()
{
    NSArray *friends;
}
@end

@implementation FriendsListTabViewController

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
    ws = [ws stringByAppendingString:@"friends/"];
    ws = [ws stringByAppendingString:user];
    ws = [ws stringByAppendingString:@".json"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     [manager GET:ws parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         friends = [FriendParser parseObject:[responseObject objectForKey:@"Friends"]];
         
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
    return friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"amigosCelula";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Friend *f = [friends objectAtIndex:indexPath.row];
    
    cell.textLabel.text = f.gamertag;
    
    NSString *ap = @"GamerScore: ";
    cell.detailTextLabel.text = [ap stringByAppendingString:[NSString stringWithFormat:@"%@", f.gamerscore]];
    
    NSURL *url = [NSURL URLWithString:f.image];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [cell.imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"friendplaceholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.imageView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    return cell;

}

#pragma mark - UIStoryBoardSegue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"friendProfile"]) {
        
        AccountViewController *ac = (AccountViewController *)segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Friend *f = [friends objectAtIndex:indexPath.row];
        
        ac.user = f.gamertag;
        
    }
    
    
}



@end
