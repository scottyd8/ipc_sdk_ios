//
//  WPYTransactionSearchResponse.h
//  WorldPaySDK
//
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYTransaction;

@interface WPYTransactionSearchResponse : WPYDomainObject
@property (nonatomic, readonly) NSArray <WPYTransaction *> *transactions;
@end
