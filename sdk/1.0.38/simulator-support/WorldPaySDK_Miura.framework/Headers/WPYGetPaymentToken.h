//
//  WPYGetPaymentToken.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYTenderedCard;
@class WPYTenderedCheck;

/**
 * This request will generate a payment token that represents the presented card or check.  The customer ID must be provided
 */
@interface WPYGetPaymentToken : WPYDomainObject
/**
 * The card data that is to be tokenized
 */
@property (nonatomic, strong) WPYTenderedCard *card;
/**
 * The check data that is to be tokenized
 */
@property (nonatomic, strong) WPYTenderedCheck *check;
/**
 * The Customer ID that this payment token will be associated with
 */
@property (nonatomic, strong) NSString *customerId;
/**
 * A flag indicating whether or not this payment method should be saved in the payment vault
 */
@property BOOL addToVault;
@end
