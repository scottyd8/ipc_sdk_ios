//
//  VaultViewController.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/13/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "VaultViewController.h"
#import "CustomerViewController.h"
#import "CustomerListViewController.h"

@interface VaultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *retrieveCustomerButton;
@property (weak, nonatomic) IBOutlet UIButton *createCustomerButton;
@property (weak, nonatomic) IBOutlet UIButton *createPaymentButton;

@end

@implementation VaultViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = @"Vault";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [Helper styleButtonPrimary:self.retrieveCustomerButton];
    [Helper styleButtonPrimary:self.createCustomerButton];
    [Helper styleButtonPrimary:self.createPaymentButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self enableButtons];
}

- (IBAction)createCustomer:(id)sender
{
    [self disableButtons];
    
    CustomerViewController * customerVC = [[CustomerViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:customerVC animated:true];
}

- (IBAction)retrieveCustomers:(id)sender
{
    [self disableButtons];
    
    CustomerListViewController * customerListVC = [[CustomerListViewController alloc] initWithList:nil];
    
    [self.navigationController pushViewController:customerListVC animated:true];
}

- (IBAction)createPayment:(id)sender
{
    [self disableButtons];
    
    CustomerViewController * customerVC = [[CustomerViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:customerVC animated:true];
}

- (void) enableButtons
{
    [self.retrieveCustomerButton setEnabled:true];
    [self.createCustomerButton setEnabled:true];
    [self.createPaymentButton setEnabled:true];
}

- (void) disableButtons
{
    [self.retrieveCustomerButton setEnabled:false];
    [self.createCustomerButton setEnabled:false];
    [self.createPaymentButton setEnabled:false];
}

@end
