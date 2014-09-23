//
//  addEventViewController.h
//  carpool
//
//  Created by Jiannan on 9/9/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AWSSimpleDB/AWSSimpleDB.h>

AmazonSimpleDBClient *sdbClient;

@interface addEventViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *eventBackgroundView;
@property (strong, nonatomic) IBOutlet UITextView *titleTextView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (strong, nonatomic) IBOutlet UIButton *availableSeatNumberLabel;
@property (strong, nonatomic) UIDatePicker *datepicker;

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *accountType;

@property (nonatomic, strong) NSString *eventType;
@property (strong, nonatomic) NSString *finalDateStringPart1;
@property (strong, nonatomic) NSString *finalDateStringPart2;
@property (strong, nonatomic) NSString *finalDateString;
@property (strong, nonatomic) NSString *eventTitle;
@property (strong, nonatomic) NSString *eventContent;
@property (strong, nonatomic) NSString *availableSeatNumber;
@property (strong, nonatomic) IBOutlet UITextField *availableSeatNumberText;

- (IBAction)chooseCancelButton:(id)sender;
- (IBAction)chooseDecideDateButton:(id)sender;
- (IBAction)chooseAvailableSeatNumber:(id)sender;
- (IBAction)chooseDecideTimeButton:(id)sender;
- (IBAction)chooseDoneButton:(id)sender;
- (IBAction)chooseEditEventTitleButton:(id)sender;
- (IBAction)chooseEditEventContentButton:(id)sender;

@end
