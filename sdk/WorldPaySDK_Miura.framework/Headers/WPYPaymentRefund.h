//
//  WPYPaymentRefund.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/**
 * This requests that the specified transaction be refunded to the account holder
 */
@interface WPYPaymentRefund : WPYDomainObject
/**
 * The amount of the refund being requested
 */
@property (nonatomic, strong) NSDecimalNumber *amount;
/**
 * The transaction ID that the refund will be applied against
 */
@property (nonatomic, strong) NSString *transactionId;
@end
