//
//  RequestLoanViewController.h
//  CSJ
//
//  Created by Jeferson on 17/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface RequestLoanViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) NSString *game;
@property (weak, nonatomic) NSString *friend;
@property (weak, nonatomic) IBOutlet UIPickerView *friendsPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *gamesPicker;
-(void)fetchGames:(id)user;
-(void)fetchFriends;
@property (nonatomic,strong) NSMutableArray *games;
@property (nonatomic,strong) NSMutableArray *friends;
@property (nonatomic,strong) MFMailComposeViewController *mailComposer;
@end

@protocol UIPickerViewDataSource
@required

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component;


@end