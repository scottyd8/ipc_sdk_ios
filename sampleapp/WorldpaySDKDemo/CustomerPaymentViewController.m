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

@end

@implementation CustomerPaymentViewController

- (instancetype)initWithPaymentMethod:(WPYPaymentMethod *)method
{
    if((self = [super initWithNibName:nil bundle:nil]))
    {
        self.method = method;
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

@end
