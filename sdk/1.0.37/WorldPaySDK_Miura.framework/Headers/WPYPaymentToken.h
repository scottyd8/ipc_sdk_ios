//
//  WPYPaymentToken.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYTender.h"

/** 
 * This object represents a payment token used in place of a payment card or check
 */
@interface WPYPaymentToken : WPYDomainObject
/**
 * The ID of the token 
 */
@property (nonatomic, strong) NSString *token;
/**
 * The payment type associated with the token
 */
@property WPYPaymentType paymentType;
/**
 * The ID of the customer associated with the token
 */
@property (nonatomic, strong) NSString *customerId;
/**
 * Public Key used to identify the merchant.
 */
@property (nonatomic, strong) NSString *publicKey;

@end
