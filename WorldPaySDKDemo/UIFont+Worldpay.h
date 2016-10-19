//
//  UIFont+Worldpay.h
//  WorldPaySDKDemo
//
//  Created by Jonas Whidden on 10/6/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Worldpay)

+ (UIFont *) worldpayPrimaryWithSize: (CGFloat) size;

+ (NSDictionary *) worldpayPrimaryAttributesWithSize: (CGFloat) size;

+ (UIFont *) worldpayBoldPrimaryWithSize: (CGFloat) size;

+ (NSDictionary *) worldpayBoldPrimaryAttributesWithSize: (CGFloat) size;

+ (UIFont *) worldpayTertiaryWithSize: (CGFloat) size;

+ (NSDictionary *) worldpayTertiaryAttributesWithSize: (CGFloat) size;

+ (UIFont *) worldpayBoldTertiaryWithSize: (CGFloat) size;

+ (NSDictionary *) worldpayBoldTertiaryAttributesWithSize: (CGFloat) size;

@end
