//
//  TransactionSettings.h
//  MiuraBluetooth
//
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Determines what type of debit application will be allowed or whether the user can select one
 */
typedef NS_ENUM(uint8_t, USCommonDebitMode)
{
    /// Default behavior - cardholder or SDK selects application
    USCommonDebitModeDefault = 0x00,
    /// No Application Selection - Use US Common Debit
    USCommonDebitModePreferCommonDebit = 0x01,
    /// No Application Selection - Use Global Debit
    USCommonDebitModePreferGlobalDebit = 0x02
};

/// Type of transaction requested
typedef NS_ENUM(uint8_t, TransactionType)
{
    /// Standard charge transaction
    TransactionTypeSale = 0x00,
    /// Cash back transaction
    TransactionTypeCashBack = 0x09,
    /// Refund transaction
    TransactionTypeRefund = 0x20
};

/**
 * Class that establishes the parameters of the transaction
 *
 */
@interface TransactionSettings : NSObject

/**
 * The total amount of the transaction
 *
 */
@property (nonatomic, strong) NSDecimalNumber *amount;

/**
 * Optional - typically cash back
 *
 */
@property (nonatomic, strong) NSDecimalNumber *amountOther;

/**
 * Transaction type to perform. See WPYEMVTransactionType for the allowed values.
 *
 */
@property (nonatomic) TransactionType transactionType;

/**
 * Set terminal to provide an audible signal if successful. Cannot be used with 'See Phone' prompt
 * Cannot be used with 'See Phone' prompt
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL enableSuccessBeep;

/**
 * Set terminal to provide an audible signal if an error occurs. Cannot be used with 'See Phone' prompt
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL enableErrorBeep;

/**
 *
 * Not currently used.
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL enableSeePhoneMessage;

/**
 * Enable Terminal Risk Management stage
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL enableTRMStage;

/**
 * Allow cash back from the transaction
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL enableCashback;

/**
 * Allow a gratuity to be added
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL enableGratuity;

/**
 * Determine if terminal should allow credit/debit selection
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL creditDebitAllowed;

/**
 * Determine if you will allow the user to select the application of more than one aid.
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL terminalSelectsApplication; // default to YES - prompts terminal user to select app

/**
 * Prompt the user to confirm the transaction amount.
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) BOOL confirmTransactionAmount;
// Optional Parameters

/**
 * String that determines the currency. Currently only set to "0840" for US dollars
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic, strong) NSString *currencyCode;

/**
 * The designated terminal identification number in hex. The defaults to the device serial number if none provided
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic, strong) NSString *terminalId;

/**
 * Determines what type of debit transactions you will allow. See USCommonDebitMode for options
 *
 * This property is only used on the start of a transaction - not used to continue a transaction after
 * a decision is required by the card holder or the online processor.
 */
@property (nonatomic) USCommonDebitMode commonDebitMode;
@end
