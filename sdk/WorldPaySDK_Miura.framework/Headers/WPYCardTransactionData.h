//
//  WPYCardTransactionData.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

typedef NS_ENUM(NSInteger, WPYAvsResultType)
{
    WPYAvsResultTypeMatch = 0,
    WPYAvsResultTypeNotMatched = 1,
    WPYAvsResultTypeNotChecked = 2
};

/**
 * Information about the credit card that was received from the payment gateway
 */
@interface WPYCardTransactionData : WPYDomainObject
/** 
 * Redacted card number
 */
@property (nonatomic, strong) NSString *number;
/** 
 * Cardholder first name
 */
@property (nonatomic, strong) NSString *firstName;
/**
 * Cardholder last name
 */
@property (nonatomic, strong) NSString *lastName;
/**
 * Brand associated with the card
 */
@property (nonatomic, strong) NSString *brand;
/** 
 * Card expiration month
 */
@property NSInteger expirationMonth;
/**
 * Card expiration year
 */
@property NSInteger expirationYear;
/**
 * AVS Code sent from gateway
 */
@property (nonatomic, strong) NSString *avsCode;
/**
 * Type of the AVS Result received
 */
@property WPYAvsResultType avsResult;
@end
