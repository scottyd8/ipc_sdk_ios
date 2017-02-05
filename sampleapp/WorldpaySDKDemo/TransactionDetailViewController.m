//
//  TransactionDetailViewController.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/4/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "TransactionDetailCell.h"
#import "CardDataCell.h"
#import "BillingAddressCell.h"
#import "CustomerCell.h"


#define TRANSACTIONCELL @"TransactionCell"
#define CARDCELL @"CardCell"
#define BILLINGADDRESSCELL @"BillingAddress"
#define CUSTOMERCELL @"CustomerCell"

#define TRANSACTIONSECTION 0
#define CARDSECTION 1
#define BILLINGADDRESSSECTION 2
#define CUSTOMERSECTION 3

#define TRANSACTIONHEIGHT 332
#define CARDHEIGHT 208
#define BILLINGADDRESSHEIGHT 288
#define CUSTOMERHEIGHT 121

@implementation TransactionDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = @"Transaction Details";
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier;
    UITableViewCell *cell;
    
    
    switch (indexPath.section) {
        case TRANSACTIONSECTION:
            simpleTableIdentifier = TRANSACTIONCELL;
            cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil) {
                cell = [[TransactionDetailCell alloc] init];
                
            }
            
            [(TransactionDetailCell *)cell assignValues: self.transactionResponse];

            break;
        case CARDSECTION:
            simpleTableIdentifier = CARDCELL;
            cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil) {
                cell = [[CardDataCell alloc] init];
            }
            
            [(CardDataCell *)cell assignValues: self.transactionResponse];

            break;
        case BILLINGADDRESSSECTION:
            simpleTableIdentifier = BILLINGADDRESSCELL;
            cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil) {
                cell = [[BillingAddressCell alloc] init];
                
            }
            
            [(BillingAddressCell *)cell assignValues: self.transactionResponse.billAddress];


            break;
        case CUSTOMERSECTION:
            simpleTableIdentifier = CUSTOMERCELL;
            cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil) {
                cell = [[CustomerCell alloc] init];
            }
            
            [(CustomerCell *)cell assignValues: self.transactionResponse];

            break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case TRANSACTIONSECTION:
            return TRANSACTIONHEIGHT;
        case CARDSECTION:
            return CARDHEIGHT;
        case BILLINGADDRESSSECTION:
            return BILLINGADDRESSHEIGHT;
        case CUSTOMERSECTION:
            return CUSTOMERHEIGHT;
        default:
            return 0;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return false;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

@end
