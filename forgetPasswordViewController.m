//
//  forgetPasswordViewController.m
//  carpool
//
//  Created by Jiannan on 9/6/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "forgetPasswordViewController.h"

@interface forgetPasswordViewController ()

@end

@implementation forgetPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
