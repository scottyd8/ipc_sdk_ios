//
//  WPYTransactionResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYTransaction;

/** 
 * This object contains transaction response information returned from the gateway after sending a payment request
 * to the server
 */
@interface WPYTransactionResponse : WPYDomainObject

@property (nonatomic, readonly) WPYTransaction *transaction;
@end
