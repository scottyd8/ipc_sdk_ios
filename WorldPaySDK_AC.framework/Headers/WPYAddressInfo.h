//
//  WPYAddressInfo.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/** 
 * This object allows the merchant to specify address information for the card holder
 */
@interface WPYAddressInfo : WPYDomainObject
/**
 * An optional parameter indicating the first line of the cardholder's address
 */
@property (nonatomic, strong) NSString *line1;
/**
 * An optional parameter indicating the city associated with he cardholder's address
 */
@property (nonatomic, strong) NSString *city;
/**
 * An optional parameter indicating the state associated with he cardholder's address
 */
@property (nonatomic, strong) NSString *state;
/**
 * An optional parameter indicating the postal code associated with he cardholder's address
 */
@property (nonatomic, strong) NSString *zip;
/**
 * An optional parameter indicating the country associated with he cardholder's address
 */
@property (nonatomic, strong) NSString *country;
/**
 * An optional parameter indicating the company associated with he cardholder's address
 */
@property (nonatomic, strong) NSString *company;
/**
 * An optional parameter indicating the phone number associated with he cardholder's address
 */
@property (nonatomic, strong) NSString *phone;
@end
