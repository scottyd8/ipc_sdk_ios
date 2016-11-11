//
//  WPYPaymentMethodCreate.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYTenderedCard;
@class WPYTenderedCheck;

/**
 * This object is used both to create a new payment method and to update an existing payment method for a customer
 */
@interface WPYPaymentMethodRequest : WPYDomainObject
/**
 * The card associated with the payment method
 */
@property (nonatomic, strong) WPYTenderedCard *card;
/**
 * The check associated with the payment method
 */
@property (nonatomic, strong) WPYTenderedCheck *check;
/**
 * A flag indicating whether or not this should be the primary payment method for the associated customer ID
 */
@property BOOL primary;
/**
 * Notes provided by the merchant for that customer
 */
@property (nonatomic, strong) NSString *notes;
/**
 * The phone number associated with this customer and payment method
 */
@property (nonatomic, strong) NSString *phone;
/**
 * If a check is presented, this is the duplicate check type to be used
 */
@property WPYPaymentMethodDuplicateCheckType duplicateCheckType;
/**
 * A custom mapping of name/value pairs provided by the merchant
 */
@property (nonatomic, strong) NSDictionary *userDefinedFields;
@end
