//
//  WPYTransaction.h
//  WorldPaySDK
//
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYTender.h"

@class WPYCheckTransactionData;
@class WPYCardTransactionData;
@class WPYAddressInfo;
@class WPYLevelTwoData;
@class SettlementData;
@class VaultData;

/**
 * This class contains the attributes and methods to perform a credit/debit/check transaction
 */
@interface WPYTransaction : WPYDomainObject
/**
 * The ID of the customer associated with the transaction, if any
 */
@property (nonatomic, readonly) NSString *customerId;
/**
 * The date/time of the transaction
 */
@property (nonatomic, readonly) NSDate *date;
/**
 * The authorization code returned from the payment gateway
 */
@property (nonatomic, readonly) NSString *authorizationCode;
/**
 * The amount of the transaction
 */
@property (nonatomic, readonly) NSDecimalNumber *amount;
/**
 * The amount of the gratuity associated with the transaction
 */
@property (nonatomic, readonly) NSDecimalNumber *gratuity;
/**
 * The credit card specific transaction data associated with the request, if any
 */
@property (nonatomic, readonly) WPYCardTransactionData *card;
/**
 * The check specific transaction data associated with the request, if any
 */
@property (nonatomic, readonly) WPYCheckTransactionData *check;
/**
 * The billing address associated with the payment request
 */
@property (nonatomic, readonly) WPYAddressInfo *billAddress;
/**
 * The email address that is associated with the request
 */
@property (nonatomic, strong) NSString *email;
/**
 * The payment type associated with the request
 */
@property (nonatomic, readonly) WPYPaymentType paymentType;
/**
 * Response text from the payment processor containing information about the transaction.
 * This will be displayed on the terminal, when possible (See WPYSwiper)
 */
@property (nonatomic, readonly) NSString *responseText;
/**
 * A convenience method to get the WPYTransaction.identifier associated with the transaction
 */
@property (nonatomic, readonly, getter=getTransactionIdentifier) NSString *transactionIdentifier;
/**
 * This optional parameter contains data that the merchant wishes to pass up to the payment gateway for that specific transaction
 */
@property (nonatomic, strong) WPYLevelTwoData *levelTwoData;
/**
 * transaction type identifier.
 * type of transaction. Values are:
 *
 * AUTH_ONLY
 * PARTIAL_AUTH_ONLY
 * AUTH_CAPTURE
 * PARTIAL_AUTH_CAPTURE
 * PRIOR_AUTH_CAPTURE
 * UPDATE_TRANS_INFO
 * CAPTURE_ONLY
 * VOID
 * PARTIAL_VOID
 * CREDIT
 * CREDIT_AUTHONLY
 * CREDIT_PRIORAUTHCAPTURE
 * FORCE_CREDIT
 * FORCE_CREDIT_AUTHONLY
 * FORCE_CREDIT_PRIORAUTHCAPTURE
 * VERIFY
 * ACCOUNT_VERIFICATION
 * AUTH_INCREMENT
 * ISSUE
 * ACTIVATE
 * REDEEM
 * REDEEM_PARTIAL
 * DEACTIVATE
 * REACTIVATE
 * INQUIRY_BALANCE
 * RECHARGE
 * ISSUE_VIRTUAL
 * CASH_OUT
 */
@property (nonatomic, strong) NSString * transactionType;
/**
 * client-generated unique ID for each transaction, used as a way to prevent the processing of duplicate transactions. The orderId must be unique to
 * the merchant's SecureNet ID; however, uniqueness is only evaluated for APPROVED transactions and only for the last 30 days. If a transaction is
 * declined, the corresponding orderId may be used again.
 *
 * The orderId is limited to 25 characters; e.g., “CUSTOMERID MMddyyyyHHmmss”.
 */
@property (nonatomic, strong) NSString * orderId;
/**
 * indicates whether partial payments are to be accepted.
 */
@property (nonatomic, assign) BOOL allowedPartialCharges;
/**
 *  credit card or check type. Valid values are:
 *
 * ACH - Check
 * DB - PIN Debit
 * PD - Pinless Debit
 * VI - VISA
 * MC - MasterCard
 * AX - American Express
 * DS - Discover
 * MCF - MasterCard Fleet
 * VIF - VISA Fleet
 * WX - Wex
 * VY - Voyager
 * SV - Stored Value
 */
@property (nonatomic, strong) NSString * paymentTypeCode;
/**
 * transaction method. Valid values are:
 *
 * CHECK
 * CREDIT_CARD
 * DEBIT_CARD
 * FLEET_CARD
 * STORED_VALUE
 * UNKNOWN
 */
@property (nonatomic, strong) NSString * paymentTypeResult;
/**
 * indicates whether the credit card is level 2 eligible.
 */
@property (nonatomic, assign) BOOL level2Valid;
/**
 * card security code result. Valid values are:
 *
 * MATCH
 * NOT_MATCH
 * NOT_CHECKED
 */
@property (nonatomic, strong) NSString * cardCodeResult;
/**
 * cash back amount given to a customer. Commonly used for debit transactions.
 */
@property (nonatomic, strong) NSDecimalNumber * cashbackAmount;
/**
 * industry-specific data for ecommerce and moto transactions.
 *
 * For eCommerce transactions:
 *
 * P - Physical goods
 * D - Digital goods
 *
 * For MO/TO transactions:
 *
 * 1 - Single purchase transaction (AVS is required)
 * 2 - Recurring billing transaction (do not submit AVS)
 * 3 - Installment transaction
 */
@property (nonatomic, strong) NSString * industrySpecificData;
/**
 * identifier for the network that returned the transaction response.
 */
@property (nonatomic, strong) NSString * networkCode;
/**
 * indicates whether the functionality to send reciept via email is enabled or not.
 */
@property (nonatomic, assign) BOOL emailReceipt;
/**
 * For stored value cards this is the Previous Balance (15 characters long zero filled decimal number with explicit decimal point) followed by Cash Out
 * Amount (15 characters long zero filled decimal number with explicit decimal point).
 */
@property (nonatomic, strong) NSString * additionalData1;
/**
 * For EBT transactions, it will contain the FNS # echoed from the ADDITIONALINFO field of the MERCHANT_KEY object. For stored value cards this is the
 * virtual issued card number.
 */
@property (nonatomic, strong) NSString * additionalData2;
/**
 * For EBT transactions, it will contain the Voucher # echoed from the ADDITIONALINFO field of the CARD object. For stored value cards it is the issued
 * card EXP date.
 */
@property (nonatomic, strong) NSString * additionalData3;
/**
 * Virtual issued card pin number. Used only for specific stored value card transactions.
 */
@property (nonatomic, strong) NSString * additionalData4;
/**
 * P2P Encryption Transaction Response-String (22 Characters): 7-digit Key ID + {1,2} + MMddyyyyHHmmss
 */
@property (nonatomic, strong) NSString * additionalData5;
/**
 * authorized amount.
 */
@property (nonatomic, strong) NSDecimalNumber * authorizedAmount;
/**
 * date/time, amount, and batchId of the settled transaction.
 */
@property (nonatomic, strong) SettlementData * settlementData;
/**
 * customer data and Vault token.
 */
@property (nonatomic, strong) VaultData * vaultData;

@end
