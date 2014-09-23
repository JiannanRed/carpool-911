//
//  carpoolViewController.h
//  carpool
//
//  Created by Jiannan on 9/2/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSSimpleDB/AWSSimpleDB.h>
#import "eventsTabBarViewController.h"

AmazonSimpleDBClient *sdbClient;
@interface carpoolViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (strong, nonatomic) IBOutlet UITextField *passwordText;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *accountType;

-(IBAction)textFieldReturn:(id)sender;
- (IBAction)originalTextDisappear:(id)sender;
- (IBAction)loginButtonPress:(id)sender;
- (IBAction)chooseForgetPasswordButton:(id)sender;
-(void)showOriginalText;

@end
