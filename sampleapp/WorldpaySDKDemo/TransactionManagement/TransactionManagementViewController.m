//
//  TransactionManagementViewController.m
//  WorldpaySDKDemo
//
//  Created by Rakesh Ravva on 3/28/17.
//  Copyright © 2017 Worldpay. All rights reserved.
//

#import "TransactionManagementViewController.h"
#import "GetTransactionDataViewController.h"
#import "TransactionSearchViewController.h"
#import "TransactionUpdateViewController.h"

@interface TransactionManagementViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getTransactionDataButton;
@property (weak, nonatomic) IBOutlet UIButton *transactionSearchButton;
@property (weak, nonatomic) IBOutlet UIButton *transactionUpdateButton;

@end

@implementation TransactionManagementViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = @"Manage Transactions";
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [Helper styleButtonPrimary:self.getTransactionDataButton];
    [Helper styleButtonPrimary:self.transactionSearchButton];
    [Helper styleButtonPrimary:self.transactionUpdateButton];
    

   [self enableButtons];
}

- (IBAction)getTransactionData:(id)sender
{
    [self disableButtons];
    
    GetTransactionDataViewController *getTransDataVC = [[GetTransactionDataViewController alloc]init];
    
    [self.navigationController pushViewController:getTransDataVC animated:YES];
    
  
}

- (IBAction)transactionSearch:(id)sender
{
    [self disableButtons];

    TransactionSearchViewController *tsVC = [[TransactionSearchViewController alloc]init];
    
    [self.navigationController pushViewController:tsVC animated:YES];
    
    
}

- (IBAction)transactionUpdate:(id)sender
{
    [self disableButtons];
    TransactionUpdateViewController *tuVC = [[TransactionUpdateViewController alloc]init];
    [self.navigationController pushViewController:tuVC animated:YES];
    
}

- (void) enableButtons
{
   
    [self.getTransactionDataButton setEnabled:true];
    [self.transactionSearchButton setEnabled:true];
    [self.transactionUpdateButton setEnabled:true];

}

- (void) disableButtons
{
    [self.getTransactionDataButton setEnabled:false];
    [self.transactionSearchButton setEnabled:false];
    [self.transactionUpdateButton setEnabled:false];

}
 

@end
