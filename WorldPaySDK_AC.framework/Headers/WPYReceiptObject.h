//
//  WPYReceiptObject.h
//  WorldpaySDK
//
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/**
 * This data indicates the type of cardholder verification that was performed on the transaction.
 * The type of CVM that is used to help determine what information will be on the receipt
 */
typedef NS_ENUM (uint8_t, WPYCVMethod)
{
    WPYCVMethodNoCVM = 0x00,
    WPYCVMethodPlaintextPIN = 0x01,
    WPYCVMethodOnlinePIN = 0x02,
    WPYCVMethodMobileConfirmCode = 0x03,
    WPYCVMethodOfflineEncipheredPIN = 0x04,
    WPYCVMethodSignature = 0x05
};

/**
 * This helps the application developer understand how the terminal read the card data in order to
 * execute the payment request.  This may affect the language printed to the receipt
 */
typedef NS_ENUM(uint8_t, WPYCardEntryMode)
{
    WPYCardEntryModeContact = 0x05,
    WPYCardEntryModeContactlessEMV = 0x07,
    WPYCardEntryModeContactlessMSR = 0x91,
    WPYCardEntryModeMSR = 0x90,
    WPYCardEntryModeManual = 0xFF
};

/** 
 * This indicates how the transaction was either authorized or denied.  Since Worldpay requires all
 * transactions to go online, an approval should be authorized by the issuing bank while a reversal
 * will likely come from the card instead
 */
typedef NS_ENUM(uint8_t, WPYAuthMode)
{
    WPYAuthModeIssuer = 0x00, // Transaction result was determined by the card issuer / gateway
    WPYAuthModeCard = 0x01 // Transactio result was determined by the card / terminal
};

/**
 * The purpose of this object is to consolidate all of the information that a developer will need to create
 * a receipt that is in compliance with card brand and Worldpay receipt formatting requirements
 */
@interface WPYReceiptObject : WPYDomainObject
/**
 * The cardholder's name.  It may be "Last Name / First Name" or just "Last Name" depending on how the data
 * was acquired
 */
@property (nonatomic, strong) NSString *cardHolderName;
/**
 * The masked card number
 */
@property (nonatomic, strong) NSString *maskedPan;
/**
 * This field indicates how the terminal acquired the card data
 */
@property (nonatomic) WPYCardEntryMode cardEntryMode;
/**
 * For EMV transactions only: This lists the Application ID that was used in the card transaction.  This data must
 * be included on all receipts, if available
 */
@property (nonatomic, strong) NSString *applicationId;
/**
 * For EMV transactions only: This is 'Brand Name' of the Card as supplied by the issuer and is required to be displayed on all receipts,
 * if available
 */
@property (nonatomic, strong) NSString *applicationPreferredName;
/**
 * For EMV transactions only: This is the TVR code that indicates what actions were performed between the terminal and the 
 * card to validate the authenticity of the card and the cardholder.  This information should be included on all receipts, if
 * available
 */
@property (nonatomic, strong) NSString *terminalVerificationResults;
/**
 * For EMV transactions only: This contains information about the functions that were performed throughout the transaction.
 * This should be included on all receipts, if available
 */
@property (nonatomic, strong) NSString *transactionStatusInformation;
/**
 * For EMV transactions only: This contains the application cryptogram supplied by the terminal
 */
@property (nonatomic, strong) NSString *applicationCryptogram;
/**
 * This property contains the cardholder verification method that was used to validate that a valid user presented the card.
 * You can use this information to help determine whether or not a signature should be captured, and the receipt should indicate
 * what method was used to validate the transaction, if any.
 */
@property (nonatomic) WPYCVMethod cardHolderVerificationMethod;
/**
 * This property indicates whether or not the transaction result is due to a determination made by the issuer / gateway or the
 * card / terminal.  
 */
@property (nonatomic) WPYAuthMode authMode;
/**
 * This flag is set when the SDK believes that a signature should be required for the transaction
 * While this is usually set in accordance with the CVM Method above, the Miura terminal sometimes
 * indicates that a signature is required even on a PIN based transaction.
 */
@property (nonatomic) BOOL cardRequiresSignature;
@end
