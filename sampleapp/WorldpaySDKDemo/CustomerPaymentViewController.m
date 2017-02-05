//
//  CustomerPaymentViewController.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/13/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "CustomerPaymentViewController.h"

@interface CustomerPaymentViewController ()

@property (nonatomic, strong) WPYPaymentMethod * method;
@property (nonatomic, assign) RESTMode mode;
@property (nonatomic, weak) IBOutlet UIButton * submitButton;
@property (nonatomic, weak) IBOutlet UIButton * cancelButton;

@end

@implementation CustomerPaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [Helper styleButtonPrimary:self.submitButton];
    [Helper styleButtonPrimary:self.cancelButton];
    
    if(self.mode == RESTModeCreate)
    {
        self.title = @"Create Payment Method";
        self.method = [[WPYPaymentMethod alloc] init];
        [self.submitButton setTitle:@"Create" forState:UIControlStateNormal];
        [self.submitButton addTarget:self action:@selector(createPayment) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(self.mode == RESTModeEdit)
    {
        self.title = @"Edit Payment Method";
        [self syncUIToMethod:self.method];
        [self.submitButton setTitle:@"Save" forState:UIControlStateNormal];
        [self.submitButton addTarget:self action:@selector(savePayment) forControlEvents:UIControlEventTouchUpInside];
    }
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

- (void) syncUIToMethod:(WPYPaymentMethod *) method
{
    // TODO: Fill in UI with data from model
}

- (void) syncMethodToUI
{
    // TODO: Fill in model with data from UI
}

- (void) createPayment
{
    [self disableButtons];
    
    [self syncMethodToUI];
    
    // TODO: Process create and re-enable buttons
}

- (void) savePayment
{
    [self disableButtons];
    
    [self syncMethodToUI];
    
    // TODO: Process save and re-enable buttons
}

- (void) setRESTMode: (RESTMode) mode
{
    self.mode = mode;
}

- (BOOL) setEditablePaymentMethod: (WPYPaymentMethod *) method
{
    if(self.mode == RESTModeEdit)
    {
        self.method = method;
        
        return true;
    }
    
    return false;
}

- (void) enableButtons
{
    [self.submitButton setEnabled:true];
    [self.cancelButton setEnabled:true];
}

- (void) disableButtons
{
    [self.submitButton setEnabled:false];
    [self.cancelButton setEnabled:false];
}

- (IBAction) cancel: (id) sender
{
    [self disableButtons];
    
    [self.navigationController popViewControllerAnimated:true];
}

@end
