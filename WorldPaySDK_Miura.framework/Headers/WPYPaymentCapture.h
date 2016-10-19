//
//  WPYPaymentCapture.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYExtendedCardData;

/**
 * This requests that the previously authorized transaction be captured
 */
@interface WPYPaymentCapture : WPYDomainObject
/**
 * The amount to capture against the previous authorization
 */
@property (nonatomic, strong) NSDecimalNumber *amount;
/**
 * The transaction ID of the authorization to be captured
 */
@property (nonatomic, strong) NSString *transactionId;
/**
 * Additional card data that the merchant may wish to include with the transaction
 */
@property (nonatomic, strong) WPYExtendedCardData *extendedData;
@end
