//
//  HomeViewController.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/2/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "HomeViewController.h"

#define CREDITDEBITINDEX 1
#define REFUNDVOIDINDEX 2
#define SETTLEMENTINDEX 3
#define VAULTINDEX 4

@interface HomeViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Home";
    
    for(UIButton * button in self.buttons)
    {
        [Helper styleButtonPrimary:button];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)creditDebit:(id)sender
{
    [self.tabBarController setSelectedIndex:CREDITDEBITINDEX];
}

- (IBAction)refundVoid:(id)sender
{
    [self.tabBarController setSelectedIndex:REFUNDVOIDINDEX];
}

- (IBAction)settlement:(id)sender
{
    [self.tabBarController setSelectedIndex:SETTLEMENTINDEX];
}

- (IBAction)vault:(id)sender
{
    [self.tabBarController setSelectedIndex:VAULTINDEX];
}

@end
