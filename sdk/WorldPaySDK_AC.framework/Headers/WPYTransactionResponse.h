//
//  WPYTransactionResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYTender.h"

@class WPYCheckTransactionData;
@class WPYCardTransactionData;
@class WPYAddressInfo;


/** 
 * This object contains transaction response information returned from the gateway after sending a payment request
 * to the server
 */
@interface WPYTransactionResponse : WPYDomainObject
/**
 * The ID of the customer associated with the transaction, if any
 */
@property (nonatomic, strong) NSString *customerId;
/**
 * The date/time of the transaction
 */
@property (nonatomic, strong) NSDate *date;
/**
 * The authorization code returned from the payment gateway
 */
@property (nonatomic, strong) NSString *authorizationCode;
/**
 * The amount of the transaction
 */
@property (nonatomic, strong) NSDecimalNumber *amount;
/**
 * The amount of the gratiuty associated with the transaction
 */
@property (nonatomic, strong) NSDecimalNumber *gratuityAmount;
/**
 * The credit card specific transaction data associated with the request, if any
 */
@property (nonatomic, strong) WPYCardTransactionData *card;
/**
 * The check specific transaction data associated with the request, if any
 */
@property (nonatomic, strong) WPYCheckTransactionData *check;
/**
 * The billing address associated with the payment request
 */
@property (nonatomic, strong) WPYAddressInfo *billAddress;
/**
 * The email address that is associated with the request 
 */
@property (nonatomic, strong) NSString *email;
/**
 * The payment type associated with the request
 */
@property WPYPaymentType paymentType;
/**
 * Additional data that may be associated with the transaction stored as key/value pairs
 */
@property (nonatomic, strong) NSDictionary *additionalData;
/**
 * Response text from the payment processor containing information about the transaction.
 * This will be displayed on the terminal, when possible (See WPYSwiper)
 */
@property (nonatomic, strong) NSString *responseText;
/**
 * A convenience method to get the WPYTransactionResponse.identifier associated with the transaction
 */
@property (nonatomic, getter=getTransactionId) NSString *transactionId;
@end
