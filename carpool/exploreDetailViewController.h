//
//  exploreDetailViewController.h
//  carpool
//
//  Created by Jiannan on 9/5/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exploreEventsTableViewCell.h"


@interface exploreDetailViewController : UIViewController

@property (strong, nonatomic) NSArray *eventDetailInfo;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *eventTitle;
@property (strong, nonatomic) IBOutlet UILabel *eventTime;
@property (strong, nonatomic) IBOutlet UILabel *eventPoster;
@property (strong, nonatomic) IBOutlet UILabel *availableSeatNumber;
@property (strong, nonatomic) IBOutlet UILabel *eventContent;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) id detailItem;
@end
