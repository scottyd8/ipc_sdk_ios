//
//  WPYTenderedCheck.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYTender.h"

/**
 * This enumeration defines the types of checking accounts that can be associated with a check.  Please note that any value
 * set to "Unknown" will NOT be sent to the server.
 */
typedef NS_ENUM(NSInteger, WPYCheckAccountType)
{
    /// If this is set, the transaction will not be sent to the servoer
    WPYCheckAccountTypeUnknown = -1,
    /// self-explanatory
    WPYCheckAccountTypeChecking = 0,
    /// self-explanatory
    WPYCheckAccountTypeSavings = 1,
    /// self-explanatory
    WPYCheckAccountTypeBusinessChecking = 2,
    /// self-explanatory
    WPYCheckAccountTypeBusinessSavings = 3,
    /// Used to determine end of presentation list
    WPYCheckAccountTypeEND
};

/**
 * This enumeration defines the types of checks that can be associated with a check.  Please note that any value
 * set to "Unknown" will NOT be sent to the server.
 */
typedef NS_ENUM(NSInteger, WPYCheckType)
{
    /// If this is set, the transaction will not be sent to the servoer
    WPYCheckTypeUnknown = -1,
    /// self-explanatory
    WPYCheckTypeCorporateCashDispursement = 0,
    /// self-explanatory
    WPYCheckTypePointOfSale = 1,
    /// self-explanatory
    WPYCheckTypePrearrangedPaymentOrDeposit = 2,
    /// self-explanatory
    WPYCheckTypeTelephoneInitiated = 3,
    /// self-explanatory
    WPYCheckTypeWebInitiated = 4,
    /// Point-of-Purchase. Paper checks that are converted (scanned) into electronic format at the point of sale. The original paper check is voided and returned to the customer. Point of Sale is authorization.
    WPYCheckTypePOP = 5,
    /// Accounts Receivable Conversion. Used for payments being made against a bill such as a utility. Signed Authorization by Customer required.
    WPYCheckTypeARC = 6,
    /// Check-21 transaction
    WPYCheckTypeICL = 7,
    /// Re-Presentation Check. After a check has been return for insufficient funds it may be attempted again using this format. RCK may only be retried once. Customer notification “Returned Checks are Electronically Re-Processed” required at Point of Sale.
    WPYCheckTypeRCK = 8,
    /// Back Office Conversion. Paper checks that are collected in a retail environment and then scanned and batched electronically. Customer notification “Checks are Electronically Processed” required at Point of Sale.
    WPYCheckTypeBOC = 9,
    /// Used to determine the end of the check presentation option list
    WPYCheckTypeEND
};

/**
 * These values correspond to the types of check verification that can be performed
 */
typedef NS_ENUM(NSInteger, WPYVerificationType)
{
    /// self-explanatory
    WPYVerificationTypeNone = 0,
    /// self-explanatory
    WPYVerificationTypeACHProvider = 1,
    /// self-explanatory
    WPYVerificationTypeCertegy = 2
};

@class WPYAddressInfo;

/**
 * Object representing the collection of data that is used to capture payment through an electronic
 * check
 */
@interface WPYTenderedCheck : WPYTender
/**
 * The type of account the check will be drafted against
 */
@property (nonatomic) WPYCheckAccountType accountType;
/**
 * Type of check used in this transaction
 */
@property (nonatomic) WPYCheckType checkType;
/**
 * ACH routing number for the bank
 */
@property (nonatomic, strong) NSString *routingNumber;
/**
 * Account number associated with this check
 */
@property (nonatomic, strong) NSString *accountNumber;
/**
 * The check number to be used reported to the account holder's bank
 */
@property (nonatomic, strong) NSString *checkNumber;
/**
 * The address of the account holder
 */
@property (nonatomic, strong) WPYAddressInfo *address;
/**
 * First name of the account holder
 */
@property (nonatomic, strong) NSString *firstName;
/**
 * Last name of the account holder
 */
@property (nonatomic, strong) NSString *lastName;
/**
 * Email address of the account holder
 */
@property (nonatomic, strong) NSString *email;
/**
 * byte string of an image of the front side of the check for capturing a paper check to process
 * electronically
 */
@property (nonatomic, strong) NSString *front;
/**
 * byte string of an image of the back side of the check for capturing a paper check to process
 */
@property (nonatomic, strong) NSString *back;
/**
 * The type of verification used to validate the check
 */
@property (nonatomic) WPYVerificationType verificationType;
@end
