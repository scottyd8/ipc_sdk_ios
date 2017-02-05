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

/**
 * This indicates what interface was used for obtaining the card data.
 */
typedef NS_ENUM(NSInteger, WPYCardSource)
{
    /// There is an intermediate state indicating we have not yet received the source type
    WPYCardSourceNotSet = -1,
    /// Cannot identify the card transaction type.
    WPYCardSourceUnknown = 0,
    /// Magnetic Stripe Credit
    WPYCardSourceCreditMSR = 100,
    /// EMV Credit
    WPYCardSourceCreditEMV = 101,
    /// Contactless EMV Credit
    WPYCardSourceCreditEMVContactless = 102,
    /// Manually Entered Credit
    WPYCardSourceCreditManual = 103,
    /// Magnetic Stripe Debit
    WPYCardSourceDebitSwiped = 200,
    /// EMV Debit
    WPYCardSourceDebitEMV = 201,
    /// Contactless EMV Debit
    WPYCardSourceDebitEMVContactless = 202,
    /// Magnetic Striped Stored Value (Prepaid)
    WPYCardSourceStoredValueSwiped = 300,
    /// Manually Entered Stored Value (Prepaid)
    WPYCardSourceStoredValueManual = 301
};

/**
 * This class is used when the customer tendered a credit card.
 */
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
 * Card expiration year
 */
@property (nonatomic, readonly) NSInteger expirationYear;
/**
 * Last four digits of the card number
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
@property (nonatomic) WPYCardSource sourceType;
/**
 * This property indicates what encryption method is used to secure the SRED data on
 * from the terminal
 */
@property WPYSwiperType swiperType;

/**
 * Returns a pointer to a read only credit card object
 *
 * @param cardHolder Full card holder name, as seen on the card
 * @param expiration Expiration date of the card
 * @param maskedPan Masked Primary Account Number for the card
 * @param trackDict Dictionary containing track1, track2, track3, track1Length, track2Length, track3Length data.
 * @param cvv CVV number from the back of the card
 * @param ksn Key Serial Number used to encrypt the card data
 * @param pinBlock Encrypted PIN data
 * @param pinKsn Key Serial Number used to encrypt the PIN data
 * @param iccCard BOOL indicating whether or not the card has a chip, based on track service code
 * @param swiperType Type of the swiper used to encrypt the card data
 * @param fallbackIndicator A boolean that indicates this was a fallback transaction
 *
 * @return WPYSwiper object
 */
- (instancetype)initSwipedCardWithCardHolderName:(NSString *)cardHolder expirationDate:(NSDate *)expiration maskedPan:(NSString *)maskedPan trackData:(NSDictionary *)trackDict cvv:(NSString *)cvv ksn:(NSString *)ksn pinBlock:(NSString *)pinBlock pinKSN:(NSString *)pinKsn isICCCapable:(BOOL)iccCard withSwiperType:(WPYSwiperType)swiperType fallback:(BOOL)fallbackIndicator;

/**
 * Returns a pointer to a read only credit card object
 *
 * @param tlv Tag, Length, Value string of the card data from the terminal
 * @param swiperType Type of the swiper used to encrypt the card data
 * @param pinBlock encrypted PIN data
 * @param pinKsn Key Serial Number used to encrypt the PIN data
 * @param ksn Key Serial Number used to encrypt the card data
 * @param signatureRequired A BOOL indicating whether or not the CVM Results indicate that a signature is required
 * @param aid String containing the Application ID that represents the card being used
 * @param cardSource The input method and account type for the selected card (Contact Debit versus Contacless Debit, etc0.
 *
 * @return WPYSwiper object
 */
- (instancetype)initCardWithTLV:(NSString *)tlv withSwiperType:(WPYSwiperType)swiperType pinBlock:(NSString *)pinBlock pinKSN:(NSString *)pinKsn andKSN:(NSString *)ksn requireSignature:(BOOL)signatureRequired applicationId:(NSString*)aid cardSource:(WPYCardSource)cardSource;

/// Flag indicating that the card has an associated PIN
- (BOOL)cardHasPinData;
@end
