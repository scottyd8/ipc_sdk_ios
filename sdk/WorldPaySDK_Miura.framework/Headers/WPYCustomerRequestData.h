//
//  WPYCustomerRequestDta.h
//  WorldPaySDK
//
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYAddressInfo;

@interface WPYCustomerRequestData : WPYDomainObject
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
@property (nonatomic, strong) NSString *phone;
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
@end
