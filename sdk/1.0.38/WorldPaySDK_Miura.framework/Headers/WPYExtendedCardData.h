//
//  WPYExtendedCardData.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYTerminalInfo;
@class WPYLevelTwoData;
@class WPYTenderServiceData;
@class WPYMailOrTelephoneOrderData;

/**
 * This object contains extended information that is, in general, optional when making a payment request.  This will automatically
 * be added to a payment request if not provided so that some terminal information can be passed up to the server (terminal id, 
 * if not provided then the terminal serial number will be used, and other information).
 */
@interface WPYExtendedCardData : WPYDomainObject
/**
 * This flag indicates whether the card was presented at the time a transaction is processed.  This will automatically be provided
 * based on the method used to acquire the card data (manual entry versus card terminal)
 */
@property BOOL cardPresent;
/**
 * This contains additional information about the terminal used to process the transaction.  If this information is not provided then the
 * payment processing routines will automatically add the data when a terminal is used to obtain card information
 */
@property (nonatomic, strong) WPYTerminalInfo *terminalData;
/**
 * This optional parameter contains data that the merchant wishes to pass up to the payment gateway for that specific transaction
 */
@property (nonatomic, strong) WPYLevelTwoData *levelTwoData;
/**
 * This optional parameter is used when processing a transaction with a gratuity.
 */
@property (nonatomic, strong) WPYTenderServiceData *serviceData;
/**
 * An optional parameter containing any additional notes the merchant would like to include with the transaction
 */
@property (nonatomic, strong) NSString *notes;
/**
 * An optional parameter indicating the invoice number that the merchant associated with this transaction
 */
@property (nonatomic, strong) NSString *invoiceNumber;
/**
 * An optional parameter describing the invoice associated with the transaction
 */
@property (nonatomic, strong) NSString *invoiceDescription;
/**
 * An optional parameter 
 */
@property (nonatomic, strong) NSString *deviceCode;
/**
 * An optional parameter indicating the entry source for the transaction data
 */
@property (nonatomic, strong) NSString *entrySource;
/**
 * An optional parameter indicates the cashback amount set on the transaction, this does not control the cashback amount sent to
 * the terminal (where applicable - See WPYPaymentRequest)
 */
@property (nonatomic, strong) NSDecimalNumber *cashBackAmount;
/**
 * An optional parameter indicating whether or not to add the current tendered information to the secure payment vault
 */
@property (nonatomic) BOOL addToVault;
/**
 * An optional parameter indicating whether orn ot to add the current tendered information to the secure payment vault in the event of a failure 
 */
@property (nonatomic) BOOL addToVaultOnFailure;
/**
 * An optional parameter indicating whether or not the merchant allows partial charges
 */
@property (nonatomic) BOOL allowPartialCharges;
/**
 * An optional parameter indicating the type of duplicate check used for a check transaction
 */
@property (nonatomic) WPYTransactionDuplicateCheckType transactionDuplicateCheckIndicator;
/**
 * An optional parameter corresponding to the order ID the merchant has assigned to this transaction
 */
@property (nonatomic) NSString *orderId;
/**
 * An optional parameter indicating the currency code used in the transaction.  This does not override or change the country code
 * programmed into a card terminal
 */
@property (nonatomic) NSString *currencyCode;
/**
 * A dictionary of user defined key/value pairs of custom data provided about the customer
 */
@property (nonatomic, strong) NSDictionary *userDefinedFields;
/**
 * Type of goods that are being purchased. Valid values are DIGITAL or PHYSICAL.
 */
@property (nonatomic, strong) NSString * typeOfGoods;
/**
 * Additional data for remote orders. Required in the case of a mail, phone, or ecommerce transaction.
 */
@property (nonatomic, strong) WPYMailOrTelephoneOrderData * mailOrTelephoneOrderData;

@end
