//
//  WPYPaymentRequest.h
//  WorldpaySDK
//
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYTenderedCard;
@class WPYExtendedCardData;
@class WPYPaymentToken;
@class WPYTenderedCheck;
@class WPYAddressInfo;

/**
 * This base class is used to represent the common info used for various types of payment requests.  This allows a generic object to 
 * be used in order to request the automatic handling of EMV transactions.  This base class cannot be used to perform an actual transaction by itself
 * you must use a child object such as WPYPaymentAuthorize, WPYPaymentCredit, WPYPaymentVerify or WPYPaymentCharge.  WPYPaymentVoid should be used with a transaction
 * ID and not passed in as a payment request in an EMV transaction.  The SDK will automatically generate a PaymentVoid request if the terminal requests
 * that a transaction be reversed.
 */
@interface WPYPaymentRequest : WPYDomainObject
/**
 * The total amount of the request, excluding the amountOther for a cashback transaction.  This is because the Anywhere Commerce devices will automatically
 * add the "Amount Other" to the total on a cashback transaction and the Miura device ignores the amountOther field and presents the cashback prompt on the
 * terminal IF the card's Application Usage Control allows cashback
 */
@property (nonatomic, strong) NSDecimalNumber *amount;
/**
 * The amountOther is typically used to represent the cashback amount of a transaction and is an optional parameter.  It defaults to 0.00
 */
@property (nonatomic, strong) NSDecimalNumber *amountOther;
/**
 * The card that will be charged on this transaction.  If the card data comes from the terminal, the SDK will automatically add this parameter in order
 * to help limit the PCI obligations on the merchant
 */
@property (nonatomic, strong) WPYTenderedCard *card;
/**
 * If the purchaser is presenting a check instead of a card, this parameter should be supplied at the time of the transaction
 */
@property (nonatomic, strong) WPYTenderedCheck *check;
/**
 * If using a payment token instead of a presented card or check, this property should be set
 */
@property (nonatomic, strong) WPYPaymentToken *token;
/**
 * Address for the account holder
 */
@property (nonatomic, strong) WPYAddressInfo *address;
/**
 * Optional extended card data to be provided by the merchant.  On card present transactions, the SDK will automatically add this object and populate 
 * card terminal information, including "Terminal ID".  If a custom terminal ID is required, this object should be included or the terminal ID should
 * be set via the request Auth token method
 */
@property (nonatomic, strong) WPYExtendedCardData *extendedInformation;

@end
