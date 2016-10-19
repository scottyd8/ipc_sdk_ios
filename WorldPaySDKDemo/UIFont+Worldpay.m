//
//  UIFont+Worldpay.m
//  WorldPaySDKDemo
//
//  Created by Jonas Whidden on 10/6/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "UIFont+Worldpay.h"

#define PRIMARYFONTNAME @"AdelleSans-Regular"
#define BOLDPRIMARYFONTNAME @"AdelleSans-Bold"
#define TERTIARYFONTNAME @"ArialMT-Regular"
#define BOLDTERTIARYFONTNAME @"ArialMT-Bold"

@implementation UIFont (Worldpay)

+ (UIFont *) worldpayPrimaryWithSize: (CGFloat) size
{
    return [self fontWithName: PRIMARYFONTNAME size: size];
}

+ (NSDictionary *) worldpayPrimaryAttributesWithSize: (CGFloat) size
{
    return @{NSFontAttributeName : [self worldpayPrimaryWithSize: size]};
}

+ (UIFont *) worldpayBoldPrimaryWithSize: (CGFloat) size
{
    return [self fontWithName: BOLDPRIMARYFONTNAME size: size];
}

+ (NSDictionary *) worldpayBoldPrimaryAttributesWithSize: (CGFloat) size
{
    return @{NSFontAttributeName : [self worldpayBoldPrimaryWithSize: size]};
}

// Secondary should be Calibri, but it's a Microsoft font, leave out for now

+ (UIFont *) worldpayTertiaryWithSize: (CGFloat) size
{
    return [self fontWithName: TERTIARYFONTNAME size: size];

}

+ (NSDictionary *) worldpayTertiaryAttributesWithSize: (CGFloat) size
{
    return @{NSFontAttributeName : [self worldpayTertiaryWithSize: size]};
}

+ (UIFont *) worldpayBoldTertiaryWithSize: (CGFloat) size
{
    return [self fontWithName: BOLDTERTIARYFONTNAME size: size];
}

+ (NSDictionary *) worldpayBoldTertiaryAttributesWithSize: (CGFloat) size
{
    return @{NSFontAttributeName : [self worldpayBoldTertiaryWithSize: size]};
}

@end
