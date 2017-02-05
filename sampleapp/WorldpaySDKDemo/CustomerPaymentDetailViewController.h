//
//  CustomerPaymentDetailViewController.h
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/17/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerPaymentDetailViewController : UIViewController

- (instancetype) initWithPaymentMethods: (NSArray<WPYPaymentMethod *> *) methods;

@end
