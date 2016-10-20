//
//  WPYStoredCheck.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYTenderedCheck.h"
@class WPYAddressInfo;

/**
 * Stored Check information from the secure vault
 */
@interface WPYStoredCheck : WPYDomainObject
/**
 * The account type of the stored check data
 */
@property WPYCheckAccountType accountType;
/**
 * The ACH routing number associated with the account
 */
@property (nonatomic, strong) NSString *routingNumber;
/**
 * The last four digits of the account number
 */
@property (nonatomic, strong) NSString *lastFourDigits;
/**
 * The address associated with the payment check
 */
@property (nonatomic, strong) WPYAddressInfo *address;
/**
 * The name associated with the account
 */
@property (nonatomic, strong) NSString *name;
/**
 * The email address associated with the account
 */
@property (nonatomic, strong) NSString *email;
/**
 * The name of the bank associated the account
 */
@property (nonatomic, strong) NSString *bank;
@end
