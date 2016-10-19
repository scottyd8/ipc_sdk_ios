//
//  UIColor+Worldpay.m
//  WorldPaySDKDemo
//
//  Created by Jonas Whidden on 10/6/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "UIColor+worldPay.h"

@implementation UIColor (Worldpay)

+ (UIColor *) worldpayRed
{
    return [UIColor colorWithR:240 g:30 b:20];
}

+ (UIColor *) worldpayGrey
{
    return [UIColor colorWithR:145 g:145 b:145];
}

+ (UIColor *) worldpayWhite
{
    return [UIColor colorWithR:255 g:255 b:255];
}

+ (UIColor *) worldpayCoral
{
    return [UIColor colorWithR:255 g:46 b:58];
}

+ (UIColor *) worldpayRose
{
    return [UIColor colorWithR:255 g:95 b:116];
}

+ (UIColor *) worldpayWine
{
    return [UIColor colorWithR:180 g:20 b:55];
}

+ (UIColor *) worldpayMango
{
    return [UIColor colorWithR:255 g:185 b:0];
}

+ (UIColor *) worldpayPurple
{
    return [UIColor colorWithR:105 g:25 b:125];
}

+ (UIColor *) worldpayEmerald
{
    return [UIColor colorWithR:0 g:120 b:103];
}

+ (UIColor *) worldpayBlack
{
    return [UIColor colorWithR:0 g:0 b:0];
}

+ (UIColor *) worldpayGunMetal
{
    return [UIColor colorWithR:57 g:57 b:57];
}

+ (UIColor *) worldpaySlate
{
    return [UIColor colorWithR:90 g:90 b:90];
}

+ (UIColor *) worldpaySmoke
{
    return [UIColor colorWithR:190 g:190 b:190];
}

+ (UIColor *) worldpayMist
{
    return [UIColor colorWithR:220 g:220 b:220];
}

+ (UIColor *) worldpayPaleGrey
{
    return [UIColor colorWithR:235 g:235 b:235];
}

+ (UIColor *) colorWithR: (NSUInteger) r g: (NSUInteger) g b: (NSUInteger) b
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

@end
