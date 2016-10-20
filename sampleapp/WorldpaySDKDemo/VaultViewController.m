//
//  VaultViewController.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/13/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "VaultViewController.h"
#import "UIColor+Worldpay.h"
#import "CustomerViewController.h"
#import "CustomerListViewController.h"

@interface VaultViewController ()
@property (weak, nonatomic) IBOutlet UIButton *retrieveButton;
@property (weak, nonatomic) IBOutlet UIButton *createButton;

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
    
    self.retrieveButton.backgroundColor = [UIColor worldpayEmerald];
    [self.retrieveButton setTitleColor:[UIColor worldpayWhite] forState:UIControlStateNormal];
    self.createButton.backgroundColor = [UIColor worldpayEmerald];
    [self.createButton setTitleColor:[UIColor worldpayWhite] forState:UIControlStateNormal];
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

- (IBAction)retrieveCustomers:(id)sender
{
    [self disableButtons];
    
    CustomerListViewController * customerListVC = [[CustomerListViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:customerListVC animated:true];
}

- (IBAction)createCustomer:(id)sender
{
    [self.retrieveButton setEnabled:false];
    
    CustomerViewController * customerVC = [[CustomerViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:customerVC animated:true];
}

- (void) enableButtons
{
    [self.retrieveButton setEnabled:true];
    [self.createButton setEnabled:true];
}

- (void) disableButtons
{
    [self.retrieveButton setEnabled:false];
    [self.createButton setEnabled:false];
}

@end
