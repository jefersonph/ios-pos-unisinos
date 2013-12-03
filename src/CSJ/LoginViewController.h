//
//  LoginViewController.h
//  CSJ
//
//  Created by Jeferson on 14/10/13.
//  Copyright (c) 2013 Unisinos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *gamertag;
@property (weak, nonatomic) IBOutlet UITextField *email;
@end
