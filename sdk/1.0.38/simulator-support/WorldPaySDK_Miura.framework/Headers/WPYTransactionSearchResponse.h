//
//  WPYTransactionSearchResponse.h
//  WorldpaySDK
//
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "WPYResponseObject.h"

@class WPYTransaction;

/// Response object used for transaction that searches for customer transactions
@interface WPYTransactionSearchResponse : WPYResponseObject
/**
 * The list of transactions that matches the parameters in the initial search
 */
@property (nonatomic, readonly) NSArray <WPYTransaction *> *transactions;
@end
