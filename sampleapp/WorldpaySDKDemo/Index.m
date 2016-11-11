//
//  Index.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/11/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "Index.h"

@interface Index ()

@property (nonatomic, assign) NSUInteger _index;

@end

@implementation Index

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self reset];
    }
    return self;
}

- (void) reset
{
    self._index = 0;
}

- (NSUInteger) current
{
    return self._index++;
}

@end
