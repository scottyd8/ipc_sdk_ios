//
//  WPYTender.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/**
 * The type of payment method associated with this payment type. Typically used with stored payment methods
 */
typedef NS_ENUM(NSInteger, WPYPaymentType)
{
    WPYPaymentTypeUnknown = 0,
    WPYPaymentTypeCheck = 1,
    WPYPaymentTypeDebitCard = 2,
    WPYPaymentTypeCreditCard = 3,
    WPYPaymentTypeStoredValue = 4,
};

/**
 * The card brand associated with a card.  This is used internally when performing card number validation
 */
typedef NS_ENUM(NSInteger, WPYCardType)
{
    WPYCardTypeVisa = 1,
    WPYCardTypeMaster = 2,
    WPYCardTypeAmex = 3,
    WPYCardTypeDiscover = 4,
    WPYCardTypeDiners = 5,
    WPYCardTypeJcb= 6,
    WPYCardTypeBc = 7,
    WPYCardTypeDina = 8,
    WPYCardTypeMaestro = 9,
    WPYCardTypeUnionPay = 10,
    WPYCardTypeUnknown= 11,
};

/**
 * This is the base class for a tendered payment method
 */
@interface WPYTender : WPYDomainObject
/**
 * Perform a Luhn check on the account number provided to make sure that it is a valid PAN (helps catch transpositions
 * and other manual card entry errors)
 */
+ (BOOL)cardLuhnCheck:(NSString *)number;
/**
 * Returns the expected card type based on the BIN of the card number provided.  Used to validate PAN lengths on manual entries
 */
+ (WPYCardType)cardTypeFromCardNumber:(NSString *)cardNumber;
@end
