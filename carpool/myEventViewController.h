//
//  myEventViewController.h
//  carpool
//
//  Created by Jiannan on 9/10/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSSimpleDB/AWSSimpleDB.h>

AmazonSimpleDBClient *sdbClient;

@interface myEventViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *eventTitleTextView;
@property (strong, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (strong, nonatomic) IBOutlet UITextView *eventContentTextView;
@property (strong, nonatomic) IBOutlet UILabel *availableSeatNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *disableEventButton;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *accountType;

- (IBAction)chooseLogoutButton:(id)sender;
- (IBAction)disableEvent:(id)sender;

@end
