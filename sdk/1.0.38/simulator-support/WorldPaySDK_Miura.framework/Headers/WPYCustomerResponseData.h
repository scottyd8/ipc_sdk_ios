//
//  WPYCustomerResponseData.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYResponseObject.h"

@class WPYAddressInfo;
@class WPYPaymentMethod;

/**
 * This object contains data pertaining to the Customer APIs
 */
@interface WPYCustomerResponseData : WPYResponseObject
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
 * The ID of the primary payment method associated with the customer, if any
 */
@property (nonatomic, strong) NSString *primaryPaymentMethodId;
/**
 * A list of payment methods supported by the customer
 */
@property (nonatomic, strong) NSArray<WPYPaymentMethod *> *paymentMethods;

@end
