//
//  YourLoansViewController.m
//  CSJ
//
//  Created by Jeferson on 17/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import "YourLoansViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "LoanParser.h"
#import "Loan.h"
#import "config.h"
#import "DBHelper.h"

@interface YourLoansViewController ()
{
    NSMutableArray *loans;
}

@end

@implementation YourLoansViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [self fetchData];
    [self.tableView setContentInset:UIEdgeInsetsMake(5, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - FetchData
-(void)fetchData{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    NSString *ws = [config getAPPUrl];
    ws = [ws stringByAppendingString:@"users/"];
    ws = [ws stringByAppendingString:[NSString stringWithFormat:@"%@", userid]];
    ws = [ws stringByAppendingString:@"/lends.json"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:ws parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        loans = [LoanParser parseObject:responseObject];
        
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
    return loans.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"emprestimosCelula";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Loan *l = [loans objectAtIndex:indexPath.row];
    
    cell.textLabel.text = l.game;
    
    NSString *to = @"Emprestado para: ";
    cell.detailTextLabel.text = [to stringByAppendingString:l.to];
   
    
    NSURL *url = [NSURL URLWithString:[self getImage:l.game]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [cell.imageView setImageWithURLRequest:request placeholderImage:[UIImage imageNamed:@"gameplaceholder"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.imageView.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    return cell;
}

-(NSString *)getImage:(id)game;
{
    NSArray *teste = [DBHelper getGames];
    NSString *image = @"";
    
    for (NSDictionary *_game in teste) {
        if ([[_game objectForKey:@"name"] isEqualToString:game]){
            image = [_game objectForKey:@"image"];
        }
        
    }
    
    return image;
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        NSString* userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        
        Loan *l = [loans objectAtIndex:indexPath.row];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString *ws = [config getAPPUrl];
        ws = [ws stringByAppendingString:@"users/"];
        ws = [ws stringByAppendingString:[NSString stringWithFormat:@"%@", userid]];
        ws = [ws stringByAppendingString:@"/lends/"];
        ws = [ws stringByAppendingString:[NSString stringWithFormat:@"%@", l.loanid]];
        ws = [ws stringByAppendingString:@"/delete.json"];
        [manager POST:ws parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
             [loans removeObjectAtIndex:indexPath.row];
            
            [tableView beginUpdates];
            
            if (loans.count > 0)
            {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                 withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]
                         withRowAnimation:UITableViewRowAnimationFade];
            }
            
            [tableView endUpdates];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
        }];

        
    }
    
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
   
    [tableView setEditing:YES animated:YES];
    
}

@end
