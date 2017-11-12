//
//  WPYCustomerRequestDta.h
//  WorldpaySDK
//
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYAddressInfo;

/**
 * Request object used in customer vault transactions.
 */
@interface WPYCustomerRequestData : WPYDomainObject
/**
 * Optional on create requests: Customer ID is set by the server if not provided.
*/
@property (nonatomic, strong) NSString *customerId;
/**
* Customer First Name
 */
@property (nonatomic, strong) NSString *firstName;
/**
 * Customer Last Name
 */
@property (nonatomic, strong) NSString *lastName;
/**
 * An object representing the customer address information
 */
@property (nonatomic, strong) WPYAddressInfo *address;
/**
 * Customer email address
 */
@property (nonatomic, strong) NSString *email;
/**
 * Indicator on whether to email receipts to the customer
 */
@property BOOL sendEmailReceipts;
/**
 * Phone number associated with customer
 */
@property (nonatomic, strong) NSString *phoneNumber;
/**
 * Name of the company the customer works for
 */
@property (nonatomic, strong) NSString *company;
/**
 * Notes associated with the customer
 */
@property (nonatomic, strong) NSString *notes;
/**
 * A dictionary of user defined key/value pairs of custom data provided about the customer
 */
@property (nonatomic, strong) NSDictionary *userDefinedFields;
/**
 * If a check is presented, this is the duplicate check type to be used
 */
@property WPYCustomerDuplicateCheckType customerDuplicateCheckIndicator;

@end
