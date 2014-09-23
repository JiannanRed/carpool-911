//
//  exploreTableViewController.m
//  carpool
//  Created by Jiannan on 9/5/14.
//  Copyright (c) 2014 The casual Programmer. All rights reserved.
//

#import "exploreTableViewController.h"
#import "exploreDetailViewController.h"

@interface exploreTableViewController ()

@end

@implementation exploreTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl=[[UIRefreshControl alloc]init];
    refreshControl.tintColor=[UIColor grayColor];
    [refreshControl addTarget:self action:@selector(loadEventData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl=refreshControl;
    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    [self loadEventData];
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

-(void) loadEventData{
    _eventTitle=[[NSMutableArray alloc]init];
    _eventTime=[[NSMutableArray alloc]init];
    _eventContentAttribute=[[NSMutableArray alloc]init];
    _availableSeatNumberAttribute=[[NSMutableArray alloc]init];
    _postUsernameAttribute=[[NSMutableArray alloc]init];
    _eventType=[[NSMutableArray alloc]init];
    NSLog(@"Start to load event information from database.\n\n");
    
    NSString *domainName1=[[NSString alloc]initWithFormat:@"driverEventTable"];
    sdbClient=[[AmazonSimpleDBClient alloc]initWithAccessKey:@"AKIAJEQEBCR7QH37QXZQ" withSecretKey:@"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"];
    sdbClient.endpoint=@"http://sdb.us-west-2.amazonaws.com";
    NSString *selectExpression=[NSString stringWithFormat:@"select availableSeatNumberAttribute,eventContentAttribute,postUsernameAttribute,eventDateAttribute,eventTitleAttribute from %@",domainName1];
    SimpleDBSelectRequest *selectRequest1=[[SimpleDBSelectRequest alloc]initWithSelectExpression:selectExpression andConsistentRead:YES];
    //selectRequest1.nextToken=nextToken;
    SimpleDBSelectResponse *select1Response=[sdbClient select:selectRequest1];
    for (SimpleDBItem *item in select1Response.items){
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
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.eventTime count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"exploreEventCell";
    exploreEventsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    long row=[indexPath row];
    cell.eventTitleLabel.font=[UIFont boldSystemFontOfSize:15.0f];
    cell.eventTitleLabel.text=_eventTitle[row];
    cell.eventTimeLabel.font=[UIFont italicSystemFontOfSize:13.0f];
    cell.eventTimeLabel.text=_eventTime[row];
    if ([_eventType[row] isEqualToString:@"driverEvent"]) {
        cell.backgroundColor=[UIColor orangeColor];
    } else {
        cell.backgroundColor=[UIColor colorWithRed:180.0/255.0 green:238.0/255.0 blue:180.0/255.0 alpha:1.0];
    }
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showEventDetail"]){
        exploreDetailViewController *detailViewController=[segue destinationViewController];
        NSIndexPath *myIndexPath=[self.tableView indexPathForSelectedRow];
        long row=[myIndexPath row];
        detailViewController.eventDetailInfo=@[_eventTitle[row],_eventTime[row],_eventContentAttribute[row],_availableSeatNumberAttribute[row],_postUsernameAttribute[row]];
    }
}

- (IBAction)chooseExitButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end