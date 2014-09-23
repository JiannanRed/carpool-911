//
//  exploreEventsTableViewCell.h
//  carpool
//
//  Created by Jiannan on 9/5/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol exploreEventsTableViewCellDelegate <NSObject>
@end

@interface exploreEventsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTimeLabel;

@end
