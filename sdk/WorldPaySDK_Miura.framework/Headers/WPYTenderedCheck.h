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
    WPYCheckAccountTypeUnknown = -1,
    WPYCheckAccountTypeChecking = 0,
    WPYCheckAccountTypeSavings = 1,
    WPYCheckAccountTypeBusinessChecking = 2,
    WPYCheckAccountTypeBusinessSavings = 3,
    WPYCheckAccountTypeEND
};

/**
 * This enumeration defines the types of checks that can be associated with a check.  Please note that any value
 * set to "Unknown" will NOT be sent to the server.
 */
typedef NS_ENUM(NSInteger, WPYCheckType)
{
    WPYCheckTypeUnknown = -1,
    WPYCheckTypeCorporateCashDispursement = 0,
    WPYCheckTypePointOfSale = 1,
    WPYCheckTypePrearrangedPaymentOrDeposit = 2,
    WPYCheckTypeTelephoneInitiated = 3,
    WPYCheckTypeWebInitiated = 4,
    WPYCheckTypePOP = 5,
    WPYCheckTypeARC = 6,
    WPYCheckTypeICL = 7,
    WPYCheckTypeRCK = 8,
    WPYCheckTypeBOC = 9,
    WPYCheckTypeEND
};

/**
 * These values correspond to the types of check verification that can be performed
 */
typedef NS_ENUM(NSInteger, WPYVerificationType)
{
    WPYVerificationTypeNone = 0,
    WPYVerificationTypeACHProvider = 1,
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
