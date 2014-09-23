//
//  eventPoolViewController.h
//  carpool
//
//  Created by Jiannan on 9/7/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "eventPoolCollectionViewCell.h"
#import "eventsPoolViewController.h"
#import <AWSSimpleDB/AWSSimpleDB.h>
#import "eventsPoolCollectionReusableView.h"
#import "eventsTabBarViewController.h"
#import "addEventViewController.h"

AmazonSimpleDBClient *sdbClient;
@interface eventPoolCollectionViewController : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *accountType;

@property (strong, nonatomic) NSArray *eventDetailInfo;
@property (nonatomic, strong) NSMutableArray *eventType;
@property (nonatomic, strong) NSMutableArray *eventTitle;
@property (nonatomic, strong) NSMutableArray *eventTime;
@property (nonatomic, strong) NSMutableArray *eventContentAttribute;
@property (nonatomic, strong) NSMutableArray *availableSeatNumberAttribute;
@property (nonatomic, strong) NSMutableArray *postUsernameAttribute;
@property (nonatomic, strong) NSMutableArray *eventPhoneNumber;
@property (nonatomic, strong) NSString *accountPhoneNumber;
@property (nonatomic, strong) NSMutableArray *orderIndex;
@property(nonatomic, strong) UIRefreshControl *refreshControl;
- (IBAction)chooseAddEventButton:(id)sender;

@end
