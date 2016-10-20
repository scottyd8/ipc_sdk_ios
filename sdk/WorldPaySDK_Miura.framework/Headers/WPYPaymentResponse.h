//
//  WPYPaymentResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYSwiper.h"

typedef NS_ENUM(uint8_t, WPYResponseCode)
{
    WPYResponseCodeApproved,
    WPYResponseCodeDeclined,
    WPYResponseCodeError
};

@class WPYEMVData;
@class WPYTransactionResponse;
@class WPYReceiptObject;

/**
 * This object is returned by the server upon completion of a payment request
 */
@interface WPYPaymentResponse : WPYDomainObject
/**
 * This object contains the transaction data from the server
 */
@property (nonatomic, readonly) WPYTransactionResponse *transaction;
/**
 * This object contains information to help create a proper receipt. See Worldpay's receipt
 * guide for more information
 */
@property (nonatomic, strong) WPYReceiptObject *receiptData;
/**
 * This contains information about the result of the transaction, based on the terminal response or
 * gateway response depending on whether it was an EMV or a magnetic stripe transaction
 */
@property (nonatomic) WPYTransactionResult resultCode;
/**
 * Gateway response code for the payment request
 */
@property (nonatomic) WPYResponseCode responseCode;
/**
 * Response Message containing a detailed message for the merchant, such as why a transaction was declined
 */
@property (nonatomic, readonly) NSString *responseMessage;
/**
 * Indicates whether or not the payment request was successfully processed
 */
@property (nonatomic, readonly) BOOL success;
/**
 * Short message indicating the result of processing. Suitable to display to the card holder
 */
@property (nonatomic, readonly) NSString *result;
@end
