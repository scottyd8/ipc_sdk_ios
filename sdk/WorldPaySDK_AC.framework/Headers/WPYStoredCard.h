//
//  WPYStoredCard.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYAddressInfo;

/**
 * Stored Card information from the secure vault
 */
@interface WPYStoredCard : WPYDomainObject
/** 
 * The masked card number for the stored payment card
 */
@property (nonatomic, strong) NSString *maskedNumber;
/**
 * The last four digits of the card
 */
@property (nonatomic, strong) NSString *lastFourDigits;
/**
 * Card expiration month
 */
@property NSInteger expirationMonth;
/**
 * Card expiration year
 */
@property NSInteger expirationYear;
/**
 * Card brand name
 */
@property (nonatomic, strong) NSString *brand;
/**
 * Cardholder first name
 */
@property (nonatomic, strong) NSString *firstName;
/**
 * Cardholder last name
 */
@property (nonatomic, strong) NSString *lastName;
/**
 * Address information associated with the stored card
 */
@property (nonatomic, strong) WPYAddressInfo *address;
/**
 * Email address associated with the payment method
 */
@property (nonatomic, strong) NSString *email;
/**
 * Company associated with the payment method
 */
@property (nonatomic, strong) NSString *company;
@end
