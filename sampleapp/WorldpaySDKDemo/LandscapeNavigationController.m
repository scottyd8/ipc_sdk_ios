//
//  LandscapeNavigationController.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/10/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "LandscapeNavigationController.h"

@interface LandscapeNavigationController ()

@end

@implementation LandscapeNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

@end
