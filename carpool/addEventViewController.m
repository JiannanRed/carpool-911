//
//  addEventViewController.m
//  carpool
//
//  Created by Jiannan on 9/9/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "addEventViewController.h"

@interface addEventViewController ()<UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@end

@implementation addEventViewController
@synthesize eventDateLabel;
@synthesize datepicker;

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
    
    NSLog(@"Start to load attEventView with type %@",_eventType);
    
    
    _phoneNumber=[[NSUserDefaults standardUserDefaults]stringForKey:@"phoneNumber"];sdardUserDefaults]stringForKey:@"username"];
    _accountType=[[NSUserDefaults standardUserDefaults]stringForKey:@"accountType"];
    
    if ([_accountType isEqualToString:@"passenger"]) {
        _availableSeatNumberText.text=@"Touch to add available seat";
        _availableSeatNumberText.hidden=YES;
        _availableSeatNumberLabel.hidden=YES;
    }
    _usernameLabel.text=_userName;
    if([_accountType isEqualToString:@"driver"]){
        self.eventBackgroundView.backgroundColor=[UIColor orangeColor];
        self.titleTextView.backgroundColor=[UIColor orangeColor];
        self.contentTextView.backgroundColor=[UIColor orangeColor];
    }else{
        self.eventBackgroundView.backgroundColor=[UIColor colorWithRed:180.0/255.0 green:238.0/255.0 blue:180.0/255.0 alpha:1.0];
        self.titleTextView.backgroundColor=[UIColor colorWithRed:180.0/255.0 green:238.0/255.0 blue:180.0/255.0 alpha:1.0];
        self.contentTextView.backgroundColor=[UIColor colorWithRed:180.0/255.0 green:238.0/255.0 blue:180.0/255.0 alpha:1.0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chooseDecideDateButton:(id)sender {
    NSString *title=UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)? @"\n\n\n\n\n\n\n\n\n":@"\n\n\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"%@%@",title,NSLocalizedString(@"Select Date", @"")] delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Done",nil, nil];
    [sheet showInView:self.view];
    datepicker=[[UIDatePicker alloc]init];
    datepicker.datePickerMode=UIDatePickerModeDate;
    sheet.tag=0;
    [datepicker setDate:[NSDate date]];
    [sheet addSubview:datepicker];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0 && actionSheet.tag==0) {
        NSDate *date=datepicker.date;
        [eventDateLabel setText:[self getFinalDateStringFromDate:date]];
    }
    if (buttonIndex==0 && actionSheet.tag==1) {
        NSDate *date=datepicker.date;
        [_eventTimeLabel setText:[self getFinalTimeStringFromDate:date]];
    }
}

-(NSString *)getFinalTimeStringFromDate:(NSDate *)time{
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    NSString *fullTime=[format stringFromDate:time];
    NSString *AmOrPM,*hour,*min;
    NSInteger h=[[fullTime substringWithRange:NSMakeRange(0, 2)] intValue];
    if (h>12) {
        AmOrPM=@"PM";
        hour=[NSString stringWithFormat:@"%ld",h-12];
        min=[fullTime substringWithRange:NSMakeRange(3, 2)];
    } else {
        AmOrPM=@"AM";
        hour=[NSString stringWithFormat:@"%ld",h];
        min=[fullTime substringWithRange:NSMakeRange(3, 2)];
    }
    self.finalDateStringPart2=[NSString stringWithFormat:@"%@:%@ %@",hour,min,AmOrPM];
    return [NSString stringWithFormat:@"%@:%@ %@",hour,min,AmOrPM];
}

-(NSString *)getFinalDateStringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSString *weekDay=[dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"MMM d y"];
    NSString *dateString=[dateFormatter stringFromDate:date];
    [dateFormatter setDateFormat:@"yy/MM/dd"];
    NSString *dateString1=[dateFormatter stringFromDate:date];
    self.finalDateStringPart1=[NSString stringWithFormat:@"%@, %@", [weekDay substringWithRange:NSMakeRange(0, 3)],dateString1];
    return [NSString stringWithFormat:@"%@, %@", [weekDay substringWithRange:NSMakeRange(0, 3)],dateString];
}

- (IBAction)chooseAvailableSeatNumber:(id)sender {
}

- (IBAction)chooseDecideTimeButton:(id)sender {
    NSString *title=UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)? @"\n\n\n\n\n\n\n\n\n":@"\n\n\n\n\n\n\n\n\n\n\n\n";
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:[NSString stringWithFormat:@"%@%@",title,NSLocalizedString(@"Select Time", @"")] delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Done",nil, nil];
    [sheet showInView:self.view];
    datepicker=[[UIDatePicker alloc]init];
    datepicker.datePickerMode=UIDatePickerModeTime;
    sheet.tag=1;
    [datepicker setDate:[NSDate date]];
    [sheet addSubview:datepicker];
}

- (IBAction)chooseDoneButton:(id)sender {
    BOOL continues=TRUE;
    if ([_titleTextView.text isEqualToString: @"Edit Title"] || [_titleTextView.text isEqualToString: @""]) {
        continues=FALSE;
    }
    if ([_contentTextView.text isEqualToString: @"Edit Event Content(Optional)"]) {
        continues=FALSE;
    }
    if(self.eventTimeLabel.text.length==0 && self.eventDateLabel.text.length==0){
        continues=FALSE;
    }
    if (self.availableSeatNumberText.text.length==0) {
        continues=FALSE;
    }
    if(!continues){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please Check" message:@"Some items are incompleted" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }else{
        if (self.eventDateLabel.text.length>0 && self.eventTimeLabel.text.length>0) {
            self.finalDateString=[NSString stringWithFormat:@"%@ %@",self.finalDateStringPart1,self.finalDateStringPart2];
        }
        NSLog(@"Start to add event to DataBase.");
        sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
        sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
        NSString *domainName=[[NSString alloc]init];
        if([_accountType isEqualToString:@"driver"]){
            domainName=@"driverEventTable";
        }else{
            domainName=@"passengerEventTable";
        }
        SimpleDBReplaceableAttribute *attrib1=[[SimpleDBReplaceableAttribute alloc]initWithName:@"Name" andValue:@"Value" andReplace:YES];
        SimpleDBReplaceableAttribute *attrib2=[[SimpleDBReplaceableAttribute alloc]initWithName:@"postUsernameAttribute" andValue:_userName andReplace:YES];
        SimpleDBReplaceableAttribute *attrib3=[[SimpleDBReplaceableAttribute alloc]initWithName:@"eventDateAttribute" andValue:_finalDateString andReplace:YES];
        SimpleDBReplaceableAttribute *attrib4=[[SimpleDBReplaceableAttribute alloc]initWithName:@"eventTitleAttribute" andValue:_titleTextView.text andReplace:YES];
        SimpleDBReplaceableAttribute *attrib5=[[SimpleDBReplaceableAttribute alloc]initWithName:@"eventContentAttribute" andValue:_contentTextView.text andReplace:YES];
        SimpleDBReplaceableAttribute *attrib6=[[SimpleDBReplaceableAttribute alloc]initWithName:@"availableSeatNumberAttribute" andValue:_availableSeatNumberText.text andReplace:YES];
        NSMutableArray *attribList=[[NSMutableArray alloc]initWithObjects:attrib1, attrib2,attrib3,attrib4,attrib5,attrib6, nil];
        //NSLog(@"%@,%@,%@,%@,%@,%@",_phoneNumber,_userName,_finalDateString,_titleTextView.text,_contentTextView.text,_availableSeatNumberText.text);
        SimpleDBPutAttributesRequest *putRequest=[[SimpleDBPutAttributesRequest alloc]initWithDomainName:domainName andItemName:_phoneNumber andAttributes:attribList];
        SimpleDBPutAttributesResponse *putResponse=[sdbClient putAttributes:putRequest];
        if(putResponse.exception==nil){
            NSLog(@"Attributes updated");
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Have posted the event" message:@"" delegate:self
                                               cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.tag=3;
            [alert show];
        }else{
            NSLog(@"error updating attributes:%@",putResponse.exception);
        }
    }
}

- (IBAction)chooseEditEventTitleButton:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Input Event Title" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    alert.tag=1;
    [alert show];
}

- (IBAction)chooseEditEventContentButton:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Input Event Content" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Done", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    alert.tag=2;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(alertView.tag==1){
        if(buttonIndex==1){
            _titleTextView.text=[alertView textFieldAtIndex:0].text;
        }
    }
    if(alertView.tag==2){
        if(buttonIndex==1){
            _contentTextView.text=[alertView textFieldAtIndex:0].text;
        }
    }
    if(alertView.tag==3){
        if(buttonIndex==0){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches]anyObject];
    if([_titleTextView isFirstResponder] && [touch view]!=_titleTextView){
        [_titleTextView resignFirstResponder];
    }
    if([_contentTextView isFirstResponder] && [touch view]!=_contentTextView){
        [_contentTextView resignFirstResponder];
    }
    if([_availableSeatNumberText isFirstResponder] && [touch view]!=_availableSeatNumberText){
        [_availableSeatNumberText resignFirstResponder];
    }
    //[self showOriginalText];
    [super touchesBegan:touches withEvent:event];
}
@end
