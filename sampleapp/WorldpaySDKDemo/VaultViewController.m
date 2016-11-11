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
    
    NSMutableArray * list = [@[] mutableCopy];
    
    // Placeholder mock customer data until we get API endpoint for list
    
    WPYCustomerResponseData * customer1 = [WPYCustomerResponseData new];
    
    //customer1.identifier = @"1"; (identifier has been changed to read only)
    customer1.firstName = @"John";
    customer1.lastName = @"Doe";
    customer1.address = [WPYAddressInfo new];
    customer1.address.line1 = @"1st Street";
    customer1.address.city = @"Austin";
    customer1.address.state = @"Texas";
    customer1.address.zip = @"78759";
    customer1.address.country = @"US";
    customer1.address.company = @"Worldpay";
    customer1.address.phone = @"800-000-5555";
    customer1.email = @"test1@securenet.com";
    customer1.phone = @"800-000-5556";
    customer1.company = @"SecureNet";
    customer1.notes = @"Notes";
    customer1.userDefinedFields = @{@"key1" : @"value1", @"key2" : @"value2"};
    customer1.primaryPaymentMethodId = @"1";
    
    WPYPaymentMethod * method1 = [WPYPaymentMethod new];
    method1.customerId = customer1.identifier;
    WPYStoredCard * card = [WPYStoredCard new];
    card.maskedNumber = @"XXXX-XXXX-XXXX-1234";
    card.lastFourDigits = @"1234";
    card.expirationMonth = 10;
    card.expirationYear = 20;
    card.brand = @"VISA";
    card.firstName = customer1.firstName;
    card.lastName = customer1.lastName;
    card.address = customer1.address;
    card.email = customer1.email;
    card.company = customer1.company;
    method1.card = card;
    method1.notes = @"Notes";
    method1.primary = YES;
    method1.lastAccessDate = [NSDate date];
    method1.userDefinedFields = customer1.userDefinedFields;
    
    WPYPaymentMethod * method2 = [WPYPaymentMethod new];
    method2.customerId = customer1.identifier;
    WPYStoredCheck * check = [WPYStoredCheck new];
    check.accountType = WPYCheckAccountTypeChecking;
    check.routingNumber = @"234523523452";
    check.lastFourDigits = @"1234";
    check.address = customer1.address;
    check.name = [NSString stringWithFormat:@"%@ %@",customer1.firstName,customer1.lastName];
    check.email = customer1.email;
    check.bank = @"Bank of America";
    method2.check = check;
    method2.notes = @"Notes";
    method2.primary = NO;
    method2.lastAccessDate = [NSDate date];
    method2.userDefinedFields = customer1.userDefinedFields;
    
    customer1.paymentMethods = @[method1, method2];
    
    [list addObject:customer1];
    
    WPYCustomerResponseData * customer2 = [WPYCustomerResponseData new];
    
    //customer2.identifier = @"2"; (identifier has been changed to read only)
    customer2.firstName = @"Jane";
    customer2.lastName = @"Doe";
    customer2.address = [WPYAddressInfo new];
    customer2.address.line1 = @"2nd Street";
    customer2.address.city = @"Round Rock";
    customer2.address.state = @"Texas";
    customer2.address.zip = @"78681";
    customer2.address.country = @"US";
    customer2.address.company = @"Worldpay";
    customer2.address.phone = @"800-000-5555";
    customer2.email = @"test2@securenet.com";
    customer2.phone = @"800-000-5556";
    customer2.company = @"SecureNet";
    customer2.notes = @"Notes";
    
    [list addObject:customer2];
    
    CustomerListViewController * customerListVC = [[CustomerListViewController alloc] initWithList:[list copy]];
    
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
