//
//  WPYCheckTransactionData.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYTenderedCheck.h"

/**
 * Check Transaction Data returned from the payment gateway
 */
@interface WPYCheckTransactionData : WPYDomainObject
/**
 * Redacted account number for the check
 */
@property (nonatomic, strong) NSString *accountNumber;
/**
 * Trace Number for the transaction
 */
@property (nonatomic, strong) NSString *traceNumber;
/**
 * Check number used in the payment request
 */
@property (nonatomic, strong) NSString *checkNumber;
/**
 * Name of bank associated with the account
 */
@property (nonatomic, strong) NSString *bank;
/**
 * The type of account associated with the check
 */
@property WPYCheckAccountType accountType;
@end
