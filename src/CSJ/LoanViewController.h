//
//  LoanViewController.h
//  CSJ
//
//  Created by Jeferson on 17/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoanViewController : UIViewController
@property (weak, nonatomic) NSString *game;
@property (weak, nonatomic) NSString *friend;
@property (weak, nonatomic) IBOutlet UIPickerView *gamesPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *friendsPicker;
@property (nonatomic,strong) NSMutableArray *games;
@property (nonatomic,strong) NSMutableArray *friends;

-(void)fetchGames;
-(void)fetchFriends;

@end

@protocol UIPickerViewDataSource
@required

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component;
@end