//
//  WPYPaymentRefund.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYExtendedCardData;

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
/**
 * Client-generated unique ID for each transaction, used as a way to prevent the processing of duplicate
 * transactions. The orderId must be unique to the merchant's SecureNet ID; however, uniqueness is only
 * evaluated for APPROVED transactions and only for the last 30 days. If a transaction is declined, the
 * corresponding orderId may be used again.
 *
 * The orderId is limited to 25 characters; e.g., “CUSTOMERID MMddyyyyHHmmss”.
 */
@property (nonatomic, strong) NSString * orderId;
/**
 * Optional extended card data to be provided by the merchant.  On card present transactions, the SDK will automatically add this object and populate
 * card terminal information, including "Terminal ID".  If a custom terminal ID is required, this object should be included or the terminal ID should
 * be set via the request Auth token method
 */
@property (nonatomic, strong) WPYExtendedCardData *extendedInformation;

@end
