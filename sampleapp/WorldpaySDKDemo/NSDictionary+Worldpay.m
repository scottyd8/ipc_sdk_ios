//
//  NSDictionary+Worldpay.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/21/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "NSDictionary+Worldpay.h"

@implementation NSDictionary(Worldpay)

- (NSArray *) alphaSorted
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

@end
