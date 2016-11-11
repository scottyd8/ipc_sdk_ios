//
//  Helper.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/7/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helper.h"

@implementation Helper

+(NSString *)getPaymentType: (WPYPaymentType)paymentType {
    
    NSString * result;
    
    switch (paymentType)
    {
        case WPYPaymentTypeUnknown:
            result = @"Unknown Payment Type";
            break;
        case WPYPaymentTypeCheck:
            result = @"Check Payment Type";
            break;
        case WPYPaymentTypeDebitCard:
            result = @"Debit Payment Type";
            break;
        case WPYPaymentTypeCreditCard:
            result = @"Credit Payment Type";
            break;
        case WPYPaymentTypeStoredValue:
            result  = @"Stored Vault Payment Type";
            break;
        default:
            break;
    }
    
    return result;
}

+ (void) constrainView:(UIView *)view toSecondView:(UIView *) secondView
{
    [view addSubview:secondView];
    
    view.translatesAutoresizingMaskIntoConstraints = false;
    secondView.translatesAutoresizingMaskIntoConstraints = false;
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:secondView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:secondView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:secondView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:secondView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
}

@end
