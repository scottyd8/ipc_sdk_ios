//
//  WPYPaymentResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYResponseObject.h"
#import "WPYSwiper.h"

@class WPYEMVData;
@class WPYTransaction;
@class WPYReceiptObject;

/**
 * This object is returned by the server upon completion of a payment request
 */
@interface WPYPaymentResponse : WPYResponseObject

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
 * This object contains the EMV data from the server
 */
@property (nonatomic, strong) WPYEMVData *emvResponse;

@end
