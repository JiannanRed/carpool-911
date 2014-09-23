//
//  securityCodeViewController.m
//  carpool
//
//  Created by Jiannan on 9/3/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "securityCodeViewController.h"


@interface securityCodeViewController ()

@end

@implementation securityCodeViewController

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

- (IBAction)chooseBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)confirmSecurityCodeButtonPress:(id)sender {
    if ([_securityCodeText.text isEqual:@"1234"]) {
        NSLog(@"Security Code is right.");
        [self addNewAccountToDatabase];
    } else {
        UIAlertView *alert=[[UIAlertView alloc]init];
        NSLog(@"Security Code is wrong.");
        alert.message=@"Security Code is wrong.";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
    }
}

-(void)addNewAccountToDatabase{
    BOOL continues=NO;
    UIAlertView *alert=[[UIAlertView alloc]init];
    NSLog(@"Start to add new accout %@ to database, he is a %@",_phoneNumber,_identity);
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
    NSString *domainName=[[NSString alloc]init];
    if([_identity isEqualToString:@"Driver"]){
        domainName=@"driverAccountTable";
    }else{
        domainName=@"passengerAccountTable";
    }
    SimpleDBReplaceableAttribute *attrib1=[[SimpleDBReplaceableAttribute alloc]initWithName:@"passwordAttribute" andValue:_password andReplace:YES];
    SimpleDBReplaceableAttribute *attrib2=[[SimpleDBReplaceableAttribute alloc]initWithName:@"usernameAttribute" andValue:_userName andReplace:YES];
    SimpleDBReplaceableAttribute *attrib3=[[SimpleDBReplaceableAttribute alloc]initWithName:@"Name" andValue:@"Value" andReplace:YES];
    NSMutableArray *attribList=[[NSMutableArray alloc]initWithObjects:attrib1, attrib2,attrib3, nil];
    SimpleDBPutAttributesRequest *putRequest=[[SimpleDBPutAttributesRequest alloc]initWithDomainName:domainName andItemName:_phoneNumber andAttributes:attribList];
    SimpleDBPutAttributesResponse *putResponse=[sdbClient putAttributes:putRequest];
    if(putResponse.exception==nil){
        NSLog(@"Attributes updated");
        continues=YES;
    }else{
        NSLog(@"error updating attributes:%@",putResponse.exception);
    }
    if (continues) {
        eventsTabBarViewController *eventsTabBarView=[self.storyboard instantiateViewControllerWithIdentifier:@"eventsTabBarView"];
        [self presentViewController:eventsTabBarView animated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        alert.message=@"Network is out of service. Failed to create new account.";
        [alert addButtonWithTitle:@"Reenter"];
        [alert show];
    }
}

-(IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches]anyObject];
    if([_securityCodeText isFirstResponder] && [touch view]!=_securityCodeText){
        [_securityCodeText resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
@end
