//
//  securityCodeViewController.h
//  carpool
//
//  Created by Jiannan on 9/3/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newRegisterViewController.h"
#import <AWSSimpleDB/AWSSimpleDB.h>
#import "eventsTabBarViewController.h"
#import "eventsPoolViewController.h"

AmazonSimpleDBClient *sdbClient;

@interface securityCodeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *securityCodeText;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *identity;

- (IBAction)chooseBackButton:(id)sender;
- (IBAction)confirmSecurityCodeButtonPress:(id)sender;
-(IBAction)textFieldReturn:(id)sender;
@end
