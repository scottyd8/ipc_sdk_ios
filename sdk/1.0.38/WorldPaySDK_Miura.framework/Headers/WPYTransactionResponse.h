//
//  WPYTransactionResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYResponseObject.h"

@class WPYTransaction;

/** 
 * This object contains transaction response information returned from the gateway after sending a payment request
 * to the server
 */
@interface WPYTransactionResponse : WPYResponseObject
/**
 * An object containing all of the details for the transaction
 */
@property (nonatomic, readonly) WPYTransaction *transaction;
@end
