//
//  eventsPoolViewController.m
//  carpool
//
//  Created by Jiannan on 9/7/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "eventsPoolViewController.h"
#import <MessageUI/MessageUI.h>

@interface eventsPoolViewController ()<MFMessageComposeViewControllerDelegate>
- (void)configureView;
@end

@implementation eventsPoolViewController

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
    [self configureView];
    _eventTitle.text=_eventDetailInfo[0];
    _eventTime.font=[UIFont italicSystemFontOfSize:13.0f];
    _eventTime.text=_eventDetailInfo[1];
    _eventContent.text=_eventDetailInfo[2];
    _availableSeatNumber.text=_eventDetailInfo[3];
    _eventPoster.text=_eventDetailInfo[4];
    _eventPhoneNumber=_eventDetailInfo[5];
    _phoneNumber=[[NSUserDefaults standardUserDefaults]stringForKey:@"phoneNumber"];
    if (([_accountType isEqualToString:@"driver"]&&[_eventType isEqualToString:@"driverEvent"])||([_phoneNumber isEqualToString:_eventPhoneNumber])) {
        _contactEventHolderButton.hidden=TRUE;
        _contactEventHolderButton.enabled=FALSE;
    } else {
        _contactEventHolderButton.hidden=NO;
        _contactEventHolderButton.enabled=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chooseContactEventHolderButton:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Contact this event holder" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call Event Holder", nil];
    [alert addButtonWithTitle:@"Text Event Holder"];
    [alert show];
}

-(void)addCurrentEventToContactEvent{
    NSString *domainName1=[[NSString alloc]init];
    NSString *domainName2=[[NSString alloc]init];
    if ([_eventType isEqualToString:@"driverEvent"]) {
        domainName1=@"driverEventTable";
    } else {
        domainName1=@"passengerEventTable";
    }
    if ([_accountType isEqualToString:@"driver"]) {
        domainName2=@"driverAccountTable";
    } else {
        domainName2=@"passengerAccountTable";
    }
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSLog(@"Choose to call.");
        NSString *URL=[NSString stringWithFormat:@"tel:%@",_eventPhoneNumber];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:URL]];;
    }
    if (buttonIndex==2) {
        NSLog(@"Choose to send message.");
        [self showSMS];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MessageComposeResultFailed:{
            UIAlertView *warningAlert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Failed to send SMS" delegate:nil cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
            [warningAlert show];
            [self addCurrentEventToContactEvent];
            break;
        }
        case MessageComposeResultSent:
            [self addCurrentEventToContactEvent];
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showSMS{
    if(![MFMessageComposeViewController canSendText]){
        UIAlertView *warningAlert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Your device doesn't support SMS" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [warningAlert show];
        return;
    }
    NSArray *recipents=@[_eventPhoneNumber];
    MFMessageComposeViewController *messageController=[[MFMessageComposeViewController alloc]init];
    messageController.messageComposeDelegate=self;
    [messageController setRecipients:recipents];
    [self presentViewController:messageController animated:YES completion:nil];
}

@end
