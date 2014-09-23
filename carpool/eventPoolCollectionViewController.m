//
//  eventPoolViewController.m
//  carpool
//
//  Created by Jiannan on 9/7/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "eventPoolCollectionViewController.h"

@interface eventPoolCollectionViewController ()<UIAlertViewDelegate>

@end

@implementation eventPoolCollectionViewController

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
    
    _refreshControl=[[UIRefreshControl alloc]init];
    _refreshControl.tintColor=[UIColor grayColor];
    [_refreshControl addTarget:self action:@selector(refreshStart) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
    
    _orderIndex=[[NSMutableArray alloc]init];
    NSInteger count;
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    count=[self loadEventData];
    NSInteger orderedIndex[count];
    for (NSInteger i=0; i<count; ++i) {
        orderedIndex[i]=i;
    }
    [self sortEventByDate:orderedIndex];
    for (NSInteger i=0; i<count; ++i) {
        [_orderIndex addObject:(id)[NSString stringWithFormat:@"%ld",(long)orderedIndex[i]]];
    }
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

-(void)refreshStart{
    NSLog(@"Start to refresh collection view.");
    _orderIndex=[[NSMutableArray alloc]init];
    NSInteger count;
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    count=[self loadEventData];
    NSInteger orderedIndex[count];
    for (NSInteger i=0; i<count; ++i) {
        orderedIndex[i]=i;
    }
    [self sortEventByDate:orderedIndex];
    for (NSInteger i=0; i<count; ++i) {
        [_orderIndex addObject:(id)[NSString stringWithFormat:@"%ld",(long)orderedIndex[i]]];
    }
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    [self.collectionView reloadData];
    [self.refreshControl endRefreshing];
}

-(NSInteger) loadEventData{
    _eventTitle=[[NSMutableArray alloc]init];
    _eventTime=[[NSMutableArray alloc]init];
    _eventContentAttribute=[[NSMutableArray alloc]init];
    _availableSeatNumberAttribute=[[NSMutableArray alloc]init];
    _postUsernameAttribute=[[NSMutableArray alloc]init];
    _eventType=[[NSMutableArray alloc]init];
    _eventPhoneNumber=[[NSMutableArray alloc]init];
    NSLog(@"Start to load event information from database in collection view.\n\n");
    
    NSString *domainName1=[[NSString alloc]initWithFormat:@"driverEventTable"];
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
    NSString *selectExpression=[NSString stringWithFormat:@"select availableSeatNumberAttribute,eventContentAttribute,postUsernameAttribute,eventDateAttribute,eventTitleAttribute from %@",domainName1];
    SimpleDBSelectRequest *selectRequest1=[[SimpleDBSelectRequest alloc]initWithSelectExpression:selectExpression andConsistentRead:YES];
    //selectRequest1.nextToken=nextToken;
    SimpleDBSelectResponse *select1Response=[sdbClient select:selectRequest1];
    for (SimpleDBItem *item in select1Response.items){
        [_eventPhoneNumber addObject:(id)item.name];
        for(SimpleDBAttribute *attri in item.attributes){
            if([attri.name isEqualToString:@"eventTitleAttribute"]){
                [_eventTitle addObject:(id)attri.value];
                
            }
            if([attri.name isEqualToString:@"eventDateAttribute"]){
                [_eventTime addObject:(id)attri.value];
            }
            if([attri.name isEqualToString:@"eventContentAttribute"]){
                [_eventContentAttribute addObject:(id)attri.value];
            }
            if([attri.name isEqualToString:@"postUsernameAttribute"]){
                [_postUsernameAttribute addObject:(id)attri.value];
            }
            if([attri.name isEqualToString:@"availableSeatNumberAttribute"]){
                [_availableSeatNumberAttribute addObject:(id)attri.value];
            }
        }
        [_eventType addObject:(id)@"driverEvent"];
    }
    NSString *domainName2=[[NSString alloc]initWithFormat:@"passengerEventTable"];
    selectExpression=[NSString stringWithFormat:@"select availableSeatNumberAttribute,eventContentAttribute,postUsernameAttribute,eventDateAttribute,eventTitleAttribute from %@",domainName2];
    selectRequest1=[[SimpleDBSelectRequest alloc]initWithSelectExpression:selectExpression andConsistentRead:YES];
    //selectRequest1.nextToken=nextToken;
    
    select1Response=[sdbClient select:selectRequest1];
    for (SimpleDBItem *item in select1Response.items){
        [_eventPhoneNumber addObject:(id)item.name];
        for(SimpleDBAttribute *attri in item.attributes){
            if([attri.name isEqualToString:@"eventTitleAttribute"]){
                [_eventTitle addObject:(id)attri.value];
            }
            if([attri.name isEqualToString:@"eventDateAttribute"]){
                [_eventTime addObject:(id)attri.value];
            }
            if([attri.name isEqualToString:@"eventContentAttribute"]){
                [_eventContentAttribute addObject:(id)attri.value];
            }
            if([attri.name isEqualToString:@"postUsernameAttribute"]){
                [_postUsernameAttribute addObject:(id)attri.value];
            }
            if([attri.name isEqualToString:@"availableSeatNumberAttribute"]){
                [_availableSeatNumberAttribute addObject:(id)attri.value];
            }
        }
        [_eventType addObject:(id)@"passengerEvent"];
    }
    NSLog(@"Finish load data from dataBase in Collection View");
    return _eventTime.count;
}

-(void)sortEventByDate:(NSInteger *)orderedIndex{
    NSLog(@"Start sort Event by date in Collection View");
    NSInteger t,count=_eventTime.count;
    NSDate *date1,*date2;
    for (NSInteger i=0; i<count-1; ++i) {
        date1=[self getDateInFormat:_eventTime[orderedIndex[i]]];
        for (NSInteger j=i+1; j<count; ++j) {
            date2=[self getDateInFormat:_eventTime[orderedIndex[j]]];
            if([date2 compare:date1]==NSOrderedAscending){
                t=orderedIndex[i];
                orderedIndex[i]=orderedIndex[j];
                orderedIndex[j]=t;
                date1=[self getDateInFormat:_eventTime[orderedIndex[i]]];
            }
        }
    }
    NSLog(@"Finish sort Event by date in Collection View");
}

-(NSDate *)getDateInFormat:(NSString *)dateString{
    //NSLog(@"Start getDateInFormat by date in Collection View");
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    NSString *day,*hour,*minutes,*amOrPm,*finalDateString;
    [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"yy/MM/dd HH:mm"];
    day=[dateString substringWithRange:NSMakeRange(5, 8)];
    if ([[dateString substringWithRange:NSMakeRange(15, 1)] isEqualToString:@":"]) {
        hour=[dateString substringWithRange:NSMakeRange(14, 1)];
        minutes=[dateString substringWithRange:NSMakeRange(16, 2)];
        amOrPm=[dateString substringWithRange:NSMakeRange(19, 2)];
    }else{
        hour=[dateString substringWithRange:NSMakeRange(14, 2)];
        minutes=[dateString substringWithRange:NSMakeRange(17, 2)];
        amOrPm=[dateString substringWithRange:NSMakeRange(20, 1)];
    }
    if ([amOrPm isEqualToString:@"PM"]) {
        hour=[NSString stringWithFormat:@"%d",[hour intValue]+12];
    }
    finalDateString=[NSString stringWithFormat:@"%@ %@:%@",day,hour,minutes];
    NSDate *date;
    date=[dateFormatter dateFromString:finalDateString];
    return date;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.eventTime count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"eventPoolCollectionViewCell";
    eventPoolCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    long row=[indexPath row];
    cell.eventTitleLabel.font=[UIFont boldSystemFontOfSize:15.0f];
    cell.eventTitleLabel.text=_eventTitle[[_orderIndex[row] intValue]];
    cell.eventTimeLabel.font=[UIFont italicSystemFontOfSize:13.0f];
    cell.eventTimeLabel.text=_eventTime[[_orderIndex[row] intValue]];
    if ([_eventType[[_orderIndex[row] intValue]] isEqualToString:@"driverEvent"]) {
        cell.backgroundColor=[UIColor orangeColor];
    } else {
        cell.backgroundColor=[UIColor colorWithRed:180.0/255.0 green:238.0/255.0 blue:180.0/255.0 alpha:1.0];
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showEventDetail"]){
        eventsPoolViewController *detailViewController=[segue destinationViewController];
        //eventsTabBarViewController *tabBar=(eventsTabBarViewController *)self.tabBarController;
        NSIndexPath *myIndexPath=[[self.collectionView indexPathsForSelectedItems] lastObject];
        long row=[myIndexPath row];
        //detailViewController.accountType=tabBar.accountType;
        //detailViewController.phoneNumber=tabBar.phoneNumber;
        detailViewController.eventType=_eventType[[_orderIndex[row] intValue]];
        detailViewController.eventDetailInfo=@[_eventTitle[[_orderIndex[row] intValue]],_eventTime[[_orderIndex[row] intValue]],_eventContentAttribute[[_orderIndex[row] intValue]],_availableSeatNumberAttribute[[_orderIndex[row] intValue]],_postUsernameAttribute[[_orderIndex[row] intValue]],_eventPhoneNumber[[_orderIndex[row] intValue]]];
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    eventsPoolCollectionReusableView *header=nil;
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"eventsPoolCollectionResuableView" forIndexPath:indexPath];
        header.headerLabel.text=@"Events Pool";
    }
    return header;
}

- (IBAction)chooseAddEventButton:(id)sender {
    NSString *domainName=[[NSString alloc]init];
    if ([[[NSUserDefaults standardUserDefaults]stringForKey:@"accountType"] isEqualToString:@"driver"]) {
        domainName=@"driverEventTable";
    } else {
        domainName=@"passengerEventTable";
    }
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
    SimpleDBGetAttributesRequest *getRequest=[[SimpleDBGetAttributesRequest alloc]initWithDomainName:domainName andItemName:[[NSUserDefaults standardUserDefaults]stringForKey:@"phoneNumber"]];
    SimpleDBGetAttributesResponse *getResponse=[sdbClient getAttributes:getRequest];
    if (getResponse.attributes.count>1) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Can not add event" message:@"You can only post one event and have already posted one event." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        addEventViewController *addEventView=[self.storyboard instantiateViewControllerWithIdentifier:@"addEventViewController"];
        [self presentViewController:addEventView animated:YES completion:nil];
    }
}

@end
