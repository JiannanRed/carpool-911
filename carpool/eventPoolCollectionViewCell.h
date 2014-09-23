//
//  eventPoolCollectionViewCell.h
//  carpool
//
//  Created by Jiannan on 9/7/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface eventPoolCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *eventTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;

@end
