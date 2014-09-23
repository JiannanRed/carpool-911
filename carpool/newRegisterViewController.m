//
//  newRegisterViewController.m
//  carpool
//
//  Created by Jiannan on 9/3/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "newRegisterViewController.h"
#import "securityCodeViewController.h"

@interface newRegisterViewController ()

@end

@implementation newRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)textFieldReturn:(id)sender{
    [self showOriginalText];
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _usernameText.textColor=[UIColor grayColor];
    
    _phoneNumberText.textColor=[UIColor grayColor];
    
    _passwordText.secureTextEntry=NO;
    _passwordText.textColor=[UIColor grayColor];
    
    _passwordAgainText.secureTextEntry=NO;
    _passwordAgainText.text=@"Repeat Password";
    _passwordAgainText.textColor=[UIColor grayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)originalPhoneNumberTextDisappear:(id)sender {
    if ([_phoneNumberText.text isEqual:@"Phone Number"]) {
        _phoneNumberText.text=@"";
    }
    _phoneNumberText.textColor=[UIColor blackColor];
}

- (IBAction)originalUserNameTextDisappear:(id)sender {
    if ([_usernameText.text isEqual:@"Username"]) {
        _usernameText.text=@"";
    }
    _usernameText.textColor=[UIColor blackColor];
}

- (IBAction)originalPasswordTextDisappear:(id)sender {
    if ([_passwordText.text isEqual:@"Password"]) {
        _passwordText.text=@"";
    }
    _passwordText.secureTextEntry=YES;
    _passwordText.textColor=[UIColor blackColor];
}

- (IBAction)originalPasswordAgainTextDisappear:(id)sender {
    if ([_passwordAgainText.text isEqual:@"Repeat Password"]) {
        _passwordAgainText.text=@"";
    }
    _passwordAgainText.secureTextEntry=YES;
    _passwordAgainText.textColor=[UIColor blackColor];
}

- (IBAction)confirmButton:(id)sender {
    BOOL continues=YES;
    UIAlertView *alert=[[UIAlertView alloc]init];
    if ([_phoneNumberText.text isEqual:@"Phone Number"] && continues && [_phoneNumberText.textColor isEqual:[UIColor grayColor]]) {
        alert.message=@"Phone number can not be empty";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
        continues=NO;
    }
    if ([_usernameText.text isEqual:@"Username"] && continues && [_usernameText.textColor isEqual:[UIColor grayColor]]) {
        alert.message=@"Username can not be empty";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
        continues=NO;
    }
    if ([_passwordText.text isEqual:@"Password"] && continues && [_passwordText.textColor isEqual:[UIColor grayColor]]) {
        alert.message=@"Password can not be empty";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
        continues=NO;
    }
    if ([_passwordAgainText.text isEqual:@"Repeat Password"] && continues && [_passwordAgainText.textColor isEqual:[UIColor grayColor]]) {
        alert.message=@"Please input password again";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
        continues=NO;
    }
    if(continues && ![_passwordText.text isEqual:_passwordAgainText.text]){
        alert.message=@"Password does not match";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
        continues=NO;
    }
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
    NSLog(@"Running isADriver function");
    if([self isADriver]){
        NSLog(@"This user %@ has been a driver.",_phoneNumberText.text);
        alert.message=@"You have already been a driver";
        [alert addButtonWithTitle:@"Back"];
        [alert show];
        continues=NO;
    }else{
        NSLog(@"This user %@ hasn't been a driver.",_phoneNumberText.text);
    }
    NSLog(@"Running isAPassenger function");
    if([self isAPassenger]){
        NSLog(@"This user %@ has been a passenger.",_phoneNumberText.text);
        alert.message=@"You have already been a passenger";
        [alert addButtonWithTitle:@"Back"];
        [alert show];
        continues=NO;
    }else{
        NSLog(@"This user %@ hasn't been a passenger.",_phoneNumberText.text);
    }
    if(continues){
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Are you sure to register?" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert1 show];
     }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        NSLog(@"User pressed Button Cancel.");
    }else{
        NSLog(@"USer Pressed Button OK.");
        securityCodeViewController *securityCodeView=[self.storyboard instantiateViewControllerWithIdentifier:@"securityCodeView"];
        securityCodeView.phoneNumber=_phoneNumberText.text;
        securityCodeView.userName=_usernameText.text;
        securityCodeView.password=_passwordText.text;
        securityCodeView.identity=_chooseIdentityButtonText.titleLabel.text;
        [self presentViewController:securityCodeView animated:YES completion:nil];
    }
}

-(bool) isADriver{
    NSString *domainName=[[NSString alloc]initWithFormat:@"driverAccountTable"];
    BOOL accountExist=NO;
    SimpleDBGetAttributesRequest *getRequest=[[SimpleDBGetAttributesRequest alloc]initWithDomainName:domainName andItemName:_phoneNumberText.text];
    SimpleDBGetAttributesResponse *getResponse=[sdbClient getAttributes:getRequest];NSLog(@"Inside is driver.");
    if(getResponse.exception==nil){
        NSLog(@"%lu Attribute values found",(unsigned long)[getResponse.attributes count]);
        if ((unsigned long)[getResponse.attributes count]>0) {
            accountExist=YES;
            NSLog(@"account exists");
        }else{
            NSLog(@"This user %@ is not a driver.",_phoneNumberText.text);
        }
    }else{
        NSLog(@"error getting attributes:%@",getResponse.exception);
    }
    return accountExist;
}

-(bool) isAPassenger{
    NSString *domainName=[[NSString alloc]initWithFormat:@"passengerAccountTable"];
    BOOL accountExist=NO;
    SimpleDBGetAttributesRequest *getRequest=[[SimpleDBGetAttributesRequest alloc]initWithDomainName:domainName andItemName:_phoneNumberText.text];
    SimpleDBGetAttributesResponse *getResponse=[sdbClient getAttributes:getRequest];
    if(getResponse.exception==nil){
        NSLog(@"%lu Attribute values found",(unsigned long)[getResponse.attributes count]);
        if((unsigned long)[getResponse.attributes count]>0){
            accountExist=YES;
            NSLog(@"account exists");
        }else{
            NSLog(@"This user %@ is not a passenger.",_phoneNumberText.text);
        }
    }else{
        NSLog(@"error getting attributes:%@",getResponse.exception);
    }
    return accountExist;
}

- (IBAction)chooseIdentityButton:(id)sender {
    if ([_chooseIdentityButtonText.titleLabel.text isEqualToString:@"Driver"]) {
        [sender setTitle:@"Passenger" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"Driver" forState:UIControlStateNormal];
    }
}

- (IBAction)chooseBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if ([_passwordAgainText.text isEqualToString:@""]) {
        _passwordAgainText.secureTextEntry=NO;
        _passwordAgainText.textColor=[UIColor grayColor];
        _passwordAgainText.text=@"Repeat Password";
    }
    if ([_usernameText.text isEqualToString:@""]) {
        _usernameText.textColor=[UIColor grayColor];
        _usernameText.text=@"Username";
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches]anyObject];
    if([_phoneNumberText isFirstResponder] && [touch view]!=_phoneNumberText){
        [_phoneNumberText resignFirstResponder];
    }
    if([_passwordText isFirstResponder] && [touch view]!=_passwordText){
        [_passwordText resignFirstResponder];
    }
    if([_usernameText isFirstResponder] && [touch view]!=_usernameText){
        [_usernameText resignFirstResponder];
    }
    if([_passwordAgainText isFirstResponder] && [touch view]!=_passwordAgainText){
        [_passwordAgainText resignFirstResponder];
    }
    [self showOriginalText];
    [super touchesBegan:touches withEvent:event];
}
@end
