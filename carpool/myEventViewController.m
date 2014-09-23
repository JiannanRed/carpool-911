//
//  myEventViewController.m
//  carpool
//
//  Created by Jiannan on 9/10/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "myEventViewController.h"

@interface myEventViewController ()

@end

@implementation myEventViewController

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
    _phoneNumber=[[NSUserDefaults standardUserDefaults]stringForKey:@"phoneNumber"];
    _accountType=[[NSUserDefaults standardUserDefaults]stringForKey:@"accountType"];
    [self loadData];
}

-(void)loadData{
    NSLog(@"Start to load data in myEventView");
    NSString *domainName=[[NSString alloc]init];
    if ([[[NSUserDefaults standardUserDefaults]stringForKey:@"accountType"] isEqualToString:@"driver"]) {
        domainName=@"driverEventTable";
    } else {
        domainName=@"passengerEventTable";
    }
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
    SimpleDBGetAttributesRequest *getRequest=[[SimpleDBGetAttributesRequest alloc]initWithDomainName:domainName andItemName:_phoneNumber];
    SimpleDBGetAttributesResponse *getResponse=[sdbClient getAttributes:getRequest];
    if (getResponse.attributes.count>1) {
        for (SimpleDBAttribute *attri in getResponse.attributes) {
            if ([attri.name isEqualToString:@"eventTitleAttribute"]) {
                _eventTitleTextView.textColor=[UIColor blackColor];
                _eventTitleTextView.font=[UIFont systemFontOfSize:20];
                _eventTitleTextView.text=attri.value;
            }
            if ([attri.name isEqualToString:@"eventDateAttribute"]) {
                _eventTimeLabel.font=[UIFont systemFontOfSize:13];
                _eventTimeLabel.text=attri.value;
            }
            if ([attri.name isEqualToString:@"eventContentAttribute"]) {
                _eventContentTextView.font=[UIFont systemFontOfSize:14];
                _eventContentTextView.text=attri.value;
            }
            if ([attri.name isEqualToString:@"availableSeatNumberAttribute"]) {
                if([attri.value isEqualToString:@"Touch to add available seat"]){
                    _availableSeatNumberLabel.text=@"Seat number is undecided";
                }else{
                    _availableSeatNumberLabel.text=[NSString stringWithFormat:@"%@ seats available",attri.value];
                }
            }
        }
    } else {
        _eventContentTextView.font=[UIFont systemFontOfSize:22];
        _eventContentTextView.font=[UIFont boldSystemFontOfSize:14];
        _eventContentTextView.textColor=[UIColor darkTextColor];
        _eventContentTextView.text=@"You do not have any event yet.";
        _eventTitleTextView.hidden=YES;
        _eventTimeLabel.hidden=YES;
        _availableSeatNumberLabel.hidden=YES;
        _disableEventButton.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseLogoutButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)disableEvent:(id)sender {
    NSString *domainName=[[NSString alloc]init];
    if ([[[NSUserDefaults standardUserDefaults]stringForKey:@"accountType"] isEqualToString:@"driver"]) {
        domainName=@"driverEventTable";
    } else {
        domainName=@"passengerEventTable";
    }
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
    NSMutableArray *attrList=[[NSMutableArray alloc]init];
    SimpleDBGetAttributesRequest *getRequest=[[SimpleDBGetAttributesRequest alloc]initWithDomainName:domainName andItemName:_phoneNumber];
    SimpleDBGetAttributesResponse *getResponse=[sdbClient getAttributes:getRequest];
    if(getResponse.exception==nil){
        for(SimpleDBAttribute *attrib in getResponse.attributes){
            NSLog(@"%@,%@",attrib.name,attrib.value);
            if ([attrib.name isEqualToString:@"availableSeatNumberAttribute"]) {
                SimpleDBReplaceableAttribute *attrib3=[[SimpleDBReplaceableAttribute alloc]initWithName:@"availableSeatNumberAttribute" andValue:@"0" andReplace:YES];
                [attrList addObject:(id)attrib3];
            }else{
                [attrList addObject:(id)attrib];
            }
        }
    }else{
        NSLog(@"error getting attributes:%@",getResponse.exception);
    }
    /*SimpleDBReplaceableAttribute *attri=[[SimpleDBReplaceableAttribute alloc]initWithName:@"availableSeatNumberAttribure" andValue:@"0" andReplace:YES];
    [attrList addObject:attri];*/
    SimpleDBPutAttributesRequest *putRequest=[[SimpleDBPutAttributesRequest alloc]initWithDomainName:domainName andItemName:_phoneNumber andAttributes:attrList];
    SimpleDBPutAttributesResponse *putReponse=[sdbClient putAttributes:putRequest];
    if(putReponse.error==nil){
        _availableSeatNumberLabel.text=@"None available seat left";
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Fail to disable this event." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
