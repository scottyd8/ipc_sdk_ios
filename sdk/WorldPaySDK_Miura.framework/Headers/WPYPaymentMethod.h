//
//  WPYPaymentMethod.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYResponseObject.h"

@class WPYStoredCheck;
@class WPYStoredCard;

/** 
 * This object contains information about a stored payment method for a customer
 */
@interface WPYPaymentMethod : WPYResponseObject
/**
 * The customer ID associated with the payment method
 */
@property (nonatomic, strong) NSString *customerId;
/**
 * The stored card, if any, associated with the payment method
 */
@property (nonatomic, strong) WPYStoredCard *card;
/**
 * The stored check, if any, associated with the payment method
 */
@property (nonatomic, strong) WPYStoredCheck *check;
/**
 * Notes associated with the payment method
 */
@property (nonatomic, strong) NSString *notes;
/**
 * A flag indicating whether the payment method is the primary method associated with the customer
 */
@property BOOL primary;
/**
 * Date that the payment method was last used
 */
@property (nonatomic, strong) NSDate *lastAccessDate;
/**
 * Customer definied data associated with the payment method
 */
@property (nonatomic, strong) NSDictionary *userDefinedFields;
@end
