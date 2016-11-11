//
//  WPYPaymentResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYSwiper.h"

@class WPYEMVData;
@class WPYTransaction;
@class WPYReceiptObject;

/**
 * This object is returned by the server upon completion of a payment request
 */
@interface WPYPaymentResponse : WPYDomainObject
/**
 * This object contains the transaction data from the server
 */
@property (nonatomic, readonly) WPYTransaction *transaction;
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
@end
