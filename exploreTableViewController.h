//
//  exploreTableViewController.h
//  carpool
//
//  Created by Jiannan on 9/5/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exploreEventsTableViewCell.h"
#import <AWSSimpleDB/AWSSimpleDB.h>

AmazonSimpleDBClient *sdbClient;
@interface exploreTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *eventDetailInfo;
@property (nonatomic, strong) NSMutableArray *eventType;
@property (nonatomic, strong) NSMutableArray *eventTitle;
@property (nonatomic, strong) NSMutableArray *eventTime;
@property (nonatomic, strong) NSMutableArray *eventContentAttribute;
@property (nonatomic, strong) NSMutableArray *availableSeatNumberAttribute;
@property (nonatomic, strong) NSMutableArray *postUsernameAttribute;
- (IBAction)chooseExitButton:(id)sender;

@end
