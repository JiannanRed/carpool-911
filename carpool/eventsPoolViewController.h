//
//  eventsPoolViewController.h
//  carpool
//
//  Created by Jiannan on 9/7/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eventPoolTableViewCell.h"
#import <AWSSimpleDB/AWSSimpleDB.h>

AmazonSimpleDBClient *sdbClient;

@interface eventsPoolViewController : UIViewController

@property (strong, nonatomic) NSArray *eventDetailInfo;
@property (strong,nonatomic) NSString *accountType;
@property (strong,nonatomic) NSString *phoneNumber;
@property (strong, nonatomic)NSString *eventType;
@property (strong, nonatomic)NSString *eventPhoneNumber;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventTime;
@property (strong, nonatomic) IBOutlet UILabel *eventPoster;
@property (strong, nonatomic) IBOutlet UILabel *availableSeatNumber;
@property (strong, nonatomic) IBOutlet UILabel *eventContent;
@property (strong, nonatomic) IBOutlet UIButton *contactEventHolderButton;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) id detailItem;

- (IBAction)goBackButtonClick:(id)sender;
- (IBAction)chooseContactEventHolderButton:(id)sender;
@end
