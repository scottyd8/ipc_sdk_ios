//
//  BatchDetailTableViewController.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/12/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "BatchDetailTableViewController.h"
#import "BatchTransactionTableViewCell.h"
#import "TransactionDetailViewController.h"

#define ROWHEIGHT 44

@interface BatchDetailTableViewController ()

@property (strong, nonatomic) NSArray<WPYTransactionResponse *> * transactions;

@end

@implementation BatchDetailTableViewController

- (instancetype)initWithTransactions:(NSArray<WPYTransactionResponse *> *) transactions batchId: (NSString *) batchId
{
    if((self = [super initWithStyle:UITableViewStylePlain]))
    {
        self.transactions = transactions;
        self.title = [NSString stringWithFormat:@"Batch %@", batchId];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.transactions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WPYTransactionResponse * transaction = [self.transactions objectAtIndex:(NSUInteger)indexPath.row];
    
    BatchTransactionTableViewCell * cell = [[BatchTransactionTableViewCell alloc] initWithTransaction:transaction];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROWHEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WPYTransactionResponse * transaction = [self.transactions objectAtIndex:(NSUInteger)indexPath.row];
    TransactionDetailViewController * detailVC = [[TransactionDetailViewController alloc] initWithNibName:nil bundle:nil];
    detailVC.transactionResponse = transaction;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
