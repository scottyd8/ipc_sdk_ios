//
//  CustomerPaymentDetailViewController.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/17/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "CustomerPaymentDetailViewController.h"

@interface CustomerPaymentDetailViewController ()

@property (nonatomic, strong) NSArray<WPYPaymentMethod *> * methods;

@end

@implementation CustomerPaymentDetailViewController

-(instancetype)initWithPaymentMethods:(NSArray<WPYPaymentMethod *> *)methods
{
    if((self = [super initWithNibName:nil bundle:nil]))
    {
        self.methods = methods;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Payment Method Details";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
