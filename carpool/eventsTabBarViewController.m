//
//  eventsTabBarViewController.m
//  carpool
//
//  Created by Jiannan on 9/3/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "eventsTabBarViewController.h"
#import "eventPoolCollectionViewController.h"

@interface eventsTabBarViewController ()

@end

@implementation eventsTabBarViewController

@synthesize accountType;
@synthesize username;
@synthesize phoneNumber;

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEventPool"]) {
        NSLog(@"AAAA");
        eventPoolCollectionViewController *eventPoolCollectionViewController=[segue destinationViewController];
        eventPoolCollectionViewController.userName=username;
        eventPoolCollectionViewController.phoneNumber=phoneNumber;
        eventPoolCollectionViewController.accountType=accountType;
    }
}*/

@end
