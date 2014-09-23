//
//  newRegisterViewController.h
//  carpool
//
//  Created by Jiannan on 9/3/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "securityCodeViewController.h"
#import <AWSSimpleDB/AWSSimpleDB.h>

AmazonSimpleDBClient *sdbClient;
@interface newRegisterViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (strong, nonatomic) IBOutlet UITextField *usernameText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgainText;
@property (strong, nonatomic) IBOutlet UIButton *chooseIdentityButtonText;

- (IBAction)confirmButton:(id)sender;
- (IBAction)chooseIdentityButton:(id)sender;
- (IBAction)chooseBackButton:(id)sender;

@end
