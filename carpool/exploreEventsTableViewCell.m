//
//  exploreEventsTableViewCell.m
//  carpool
//
//  Created by Jiannan on 9/5/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "exploreEventsTableViewCell.h"

@implementation exploreEventsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    /*if (self) {
        CGRect eventTitleLabelRectangle=CGRectMake(44, 8, 100, 28);
        _eventTitleLabel=[[UILabel alloc]initWithFrame:eventTitleLabelRectangle];
        _eventTitleLabel.textAlignment=NSTextAlignmentLeft;
        _eventTitleLabel.font=[UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:_eventTitleLabel];
        
        CGRect eventTimeLabelRectangle=CGRectMake(200, 8, 100, 28);
        _eventTimeLabel=[[UILabel alloc]initWithFrame:eventTimeLabelRectangle];
        _eventTimeLabel.textAlignment=NSTextAlignmentRight;
        _eventTimeLabel.font=[UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:_eventTimeLabel];
    }*/
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
