//
//  carpoolViewController.m
//  carpool
//
//  Created by Jiannan on 9/2/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "carpoolViewController.h"
#import "forgetPasswordViewController.h"
NSInteger viewAppearTimes;
@interface carpoolViewController ()

@end

@implementation carpoolViewController

-(IBAction)textFieldReturn:(id)sender{
    [self showOriginalText];
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    viewAppearTimes=0;
    [super viewDidLoad];
    _accountType=[[NSString alloc]init];
    
    _passwordText.secureTextEntry=NO;
	_passwordText.textColor=[UIColor grayColor];
    
    _phoneNumberText.textColor=[UIColor grayColor];
    
    _phoneNumber=[[NSUserDefaults standardUserDefaults]stringForKey:@"phoneNumber"];
    _password=[[NSUserDefaults standardUserDefaults]stringForKey:@"password"];
    if(_phoneNumber.length>3 && viewAppearTimes==0){
        [self loginToDataBase];
    }
    if(viewAppearTimes>0){
        _phoneNumberText.text=_phoneNumber;
        _passwordText.text=_password;
    }
    viewAppearTimes++;
}

-(void) viewDidAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)originalTextDisappear:(id)sender {
    if ([_phoneNumberText.text isEqual:@"Phone Number"]) {
        _phoneNumberText.text=@"";
    }
    _phoneNumberText.textColor=[UIColor blackColor];
}

-(void)showOriginalText{
    if ([_phoneNumberText.text isEqualToString:@""]) {
        _phoneNumberText.textColor=[UIColor grayColor];
        _phoneNumberText.text=@"Phone Number";
    }
    if ([_passwordText.text isEqualToString:@""]) {
        _passwordText.secureTextEntry=NO;
        _passwordText.textColor=[UIColor grayColor];
        _passwordText.text=@"Password";
    }
}

- (IBAction)loginButtonPress:(id)sender {
    BOOL continues=YES;
    UIAlertView *alert=[[UIAlertView alloc]init];
    if ([_phoneNumberText.text isEqual:@"Phone number"] && [_phoneNumberText.textColor isEqual:[UIColor grayColor]]) {
        alert.message=@"Phone number can not be empty";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
        continues=NO;
    }
    if ([_passwordText.text isEqual:@"Password"] && [_passwordText.textColor isEqual:[UIColor grayColor]]&&continues) {
        alert.message=@"Password can not be empty";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
        continues=NO;
    }
    if(continues){
        _phoneNumber=_phoneNumberText.text;
        _password=_passwordText.text;
        [self loginToDataBase];
    }
}

-(void)loginToDataBase{
    
    UIAlertView *alert=[[UIAlertView alloc]init];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    NSString *domainName1=[[NSString alloc]initWithFormat:@"driverAccountTable"];
    BOOL accountExist=NO;
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
    SimpleDBGetAttributesRequest *getRequest=[[SimpleDBGetAttributesRequest alloc]initWithDomainName:domainName1 andItemName:_phoneNumber];
    SimpleDBGetAttributesResponse *getResponse=[sdbClient getAttributes:getRequest];
    if(getResponse.exception==nil){
        for(SimpleDBAttribute *attrib in getResponse.attributes){
            NSLog(@"%@,%@",attrib.name,attrib.value);
            if ([attrib.name isEqualToString:@"passwordAttribute"] && [attrib.value isEqualToString:_password]) {
                accountExist=YES;
                _accountType=@"driver";
            }
            if([attrib.name isEqualToString:@"usernameAttribute"]){
                _username=attrib.value;
            }
        }
    }else{
        NSLog(@"error getting attributes:%@",getResponse.exception);
    }
    
    if(accountExist==NO){
        NSString *domainName2=[[NSString alloc]initWithFormat:@"passengerAccountTable"];
        SimpleDBGetAttributesRequest *getRequest=[[SimpleDBGetAttributesRequest alloc]initWithDomainName:domainName2 andItemName:_phoneNumber];
        SimpleDBGetAttributesResponse *getResponse=[sdbClient getAttributes:getRequest];
        if(getResponse.exception==nil){
            for(SimpleDBAttribute *attrib in getResponse.attributes){
                if ([attrib.name isEqualToString:@"passwordAttribute"] && [attrib.value isEqualToString:_password]) {
                    accountExist=YES;
                    //_phoneNumber=_phoneNumberText.text;
                    _accountType=@"passenger";
                }
                if([attrib.name isEqualToString:@"usernameAttribute"]){
                    _username=attrib.value;
                }
            }
        }else{
            NSLog(@"error getting attributes:%@",getResponse.exception);
        }
    }
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    if (accountExist==NO) {
        alert.message=@"Phone number or password is wrong!";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
    }else{
        [[NSUserDefaults standardUserDefaults]setValue:_phoneNumber forKey:@"phoneNumber"];
        [[NSUserDefaults standardUserDefaults]setValue:_password forKey:@"password"];
        [[NSUserDefaults standardUserDefaults]setValue:_accountType forKey:@"accountType"];
        [[NSUserDefaults standardUserDefaults]setValue:_username forKey:@"username"];
        [self login];
    }
}

- (IBAction)chooseForgetPasswordButton:(id)sender {
    forgetPasswordViewController *forgetPasswordViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"forgetPasswordViewControll"];
    [self presentViewController:forgetPasswordViewController animated:YES completion:nil];
}

-(void)login{
    
    eventsTabBarViewController *eventsTabBarView=[self.storyboard instantiateViewControllerWithIdentifier:@"eventsTabBarView"];
    
    [eventsTabBarView setAccountType:[NSString stringWithString:_accountType]];
    [eventsTabBarView setUsername:[NSString stringWithString:_username]];
    [eventsTabBarView setPhoneNumber:[NSString stringWithString:_phoneNumber]];
    eventsTabBarView.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:eventsTabBarView animated:YES completion:nil];
}

- (IBAction)originalPasswordTextDisappear:(id)sender {
    if ([_passwordText.text isEqual:@"Password"]) {
        _passwordText.text=@"";
    }
    _passwordText.secureTextEntry=YES;
    _passwordText.textColor=[UIColor blackColor];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches]anyObject];
    if([_phoneNumberText isFirstResponder] && [touch view]!=_phoneNumberText){
        [_phoneNumberText resignFirstResponder];
    }
    if([_passwordText isFirstResponder] && [touch view]!=_passwordText){
        [_passwordText resignFirstResponder];
    }
    [self showOriginalText];
    [super touchesBegan:touches withEvent:event];
}
@end
