//
//  WPYTenderedCard.h
//  WorldpaySDK
//
//  Copyright (c) 2015 Worldpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPYTender.h"
#import "WPYSwiper.h"

@class WPYAddressInfo;

typedef NS_ENUM(NSInteger, WPYCardSource)
{
    WPYCardSourceNotSet = -1,
    WPYCardSourceUnknown = 0,
    WPYCardSourceCreditMSR = 100,
    WPYCardSourceCreditEMV = 101,
    WPYCardSourceCreditEMVContactless = 102,
    WPYCardSourceCreditManual = 103,
    WPYCardSourceDebitSwiped = 200,
    WPYCardSourceDebitEMV = 201,
    WPYCardSourceDebitEMVContactless = 202,
    WPYCardSourceStoredValueSwiped = 300,
    WPYCardSourceStoredValueManual = 301
};

@interface WPYTenderedCard : WPYTender
/**
 * The cardholder's first name
 */
@property (nonatomic, readonly) NSString *firstName;
/**
 * The cardholder's last name
 */
@property (nonatomic, readonly) NSString *lastName;
/**
 * Card expiration month
 */
@property (nonatomic, readonly) NSInteger expirationMonth;
/**
 * card expiration year
 */
@property (nonatomic, readonly) NSInteger expirationYear;
/**
 * last four digits of the card number
 */
@property (nonatomic, readonly) NSString *lastFourDigits;
/**
 * The first six digits of the card number, if available
 */
@property (nonatomic, readonly) NSString *firstSixDigits;
/**
 * Flag indicating that the card is a chip card that was read through the magnetic stripe interface
 */
@property (nonatomic, readonly) BOOL iccCardSwiped;
/**
 * Flag indicating whether or not a chip card is being read by MSR due to a technical fallback. If
 * not, then the card was read as MSR because there were no supported applications on the terminal
 */
@property (nonatomic, readonly) BOOL fallbackIndicator;
/**
 * Flag indicating whether or not the transaction is to be processed as debit
 */
@property (nonatomic, readonly) BOOL isDebit;
/**
 * A byte string containing the captured digital signature, if applicable
 */
@property (nonatomic, strong) NSString *signature;
/**
 * Email address associated with the cardholder
 */
@property (nonatomic, strong) NSString *email;
/**
 * Address for the account holder
 */
@property (nonatomic, strong) WPYAddressInfo *address;
/**
 * Flag indicating whether or not a successful transaction should include a signature
 */
@property (nonatomic, readonly) BOOL signatureRequired;
/**
 * The Application ID associated with an EMV transaction
 */
@property (nonatomic, readonly) NSString *applicationId;
/**
 * This property indicates what the source type of the card is - debit, msr, emv, etc
 */
@property WPYCardSource sourceType;
/**
 * This property indicates what encryption method is used to secure the SRED data on
 * from the terminal
 */
@property WPYSwiperType swiperType;

/**
 * Returns a pointer to a read only credit card object
 *
 * @param Full card holder name, as seen on the card
 * @param expiration date of the card
 * @param masked Primary Account Number for the card
 * @param dictionary containing track1, track2, track3, track1Length, track2Length, track3Length data.
 * @param CVV number from the back of the card
 * @param Key Serial Number used to encrypt the card data
 * @param encrypted PIN data
 * @param Key Serial Number used to encrypt the PIN data
 * @param BOOL indicating whether or not the card has a chip, based on track service code
 * @param Type of the swiper used to encrypt the card data
 *
 * @return WPYSwiper object
 */
- (instancetype)initSwipedCardWithCardHolderName:(NSString *)cardHolder expirationDate:(NSDate *)expiration maskedPan:(NSString *)maskedPan trackData:(NSDictionary *)trackDict cvv:(NSString *)cvv ksn:(NSString *)ksn pinBlock:(NSString *)pinBlock pinKSN:(NSString *)pinKsn isICCCapable:(BOOL)iccCard withSwiperType:(WPYSwiperType)swiperType fallback:(BOOL)fallbackIndicator;

/**
 * Returns a pointer to a read only credit card object
 *
 * @param Tag, Length, Value string of the card data from the terminal
 * @param Type of the swiper used to encrypt the card data
 * @param encrypted PIN data
 * @param Key Serial Number used to encrypt the PIN data
 * @param Key Serial Number used to encrypt the card data
 * @param BOOL indicating whether or not the CVM Results indicate that a signature is required
 * @param string containing the Application ID that represents the card being used
 * @param The input method and account type for the selected card (Contact Debit versus Contacless Debit, etc0.
 *
 * @return WPYSwiper object
 */

- (instancetype)initCardWithTLV:(NSString *)tlv withSwiperType:(WPYSwiperType)swiperType pinBlock:(NSString *)pinBlock pinKSN:(NSString *)pinKsn andKSN:(NSString *)ksn requireSignature:(BOOL)signatureRequired applicationId:(NSString*)aid cardSource:(WPYCardSource)cardSource;

- (BOOL)cardHasPinData;
@end
