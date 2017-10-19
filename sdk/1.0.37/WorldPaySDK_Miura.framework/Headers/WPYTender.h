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
    /// Unknown payment type
    WPYPaymentTypeUnknown = 0,
    /// Payment is a check
    WPYPaymentTypeCheck = 1,
    /// Payment is a debit card
    WPYPaymentTypeDebitCard = 2,
    /// Payment is a credit card
    WPYPaymentTypeCreditCard = 3,
    /// Payment is a prepaid card
    WPYPaymentTypeStoredValue = 4,
};

/**
 * The card brand associated with a card.  This is used internally when performing card number validation
 */
typedef NS_ENUM(NSInteger, WPYCardType)
{
    ///Visa
    WPYCardTypeVisa = 1,
    ///MasterCard
    WPYCardTypeMaster = 2,
    ///American Express
    WPYCardTypeAmex = 3,
    ///Discover Card
    WPYCardTypeDiscover = 4,
    ///Diners Club
    WPYCardTypeDiners = 5,
    ///JCB (Japanese Credit Bureau)
    WPYCardTypeJcb= 6,
    ///Barclay Card
    WPYCardTypeBc = 7,
    ///DinaCard (Serbian)
    WPYCardTypeDina = 8,
    ///Maestro (MasterCard debit)
    WPYCardTypeMaestro = 9,
    ///Union Pay
    WPYCardTypeUnionPay = 10,
    ///Unknown
    WPYCardTypeUnknown= 11,
};

/**
 * This is the base class for a tendered payment method
 */
@interface WPYTender : WPYDomainObject
/**
 * Perform a Luhn check on the account number provided to make sure that it is a valid PAN (helps catch transpositions
 * and other manual card entry errors)
 * @param number - The account number to check.
 */
+ (BOOL)cardLuhnCheck:(NSString *)number;
/**
 * Returns the expected card type based on the BIN of the card number provided.  Used to validate PAN lengths on manual entries
 * @param cardNumber The account number to validate.
 */
+ (WPYCardType)cardTypeFromCardNumber:(NSString *)cardNumber;
@end
