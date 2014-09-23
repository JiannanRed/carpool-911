//
//  exploreDetailViewController.m
//  carpool
//
//  Created by Jiannan on 9/5/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "exploreDetailViewController.h"

@interface exploreDetailViewController ()
- (void)configureView;
@end

@implementation exploreDetailViewController

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    _eventTitle.text=_eventDetailInfo[0];
    _eventTime.text=_eventDetailInfo[1];
    _eventContent.text=_eventDetailInfo[2];
    _availableSeatNumber.text=_eventDetailInfo[3];
    _eventPoster.text=_eventDetailInfo[4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
