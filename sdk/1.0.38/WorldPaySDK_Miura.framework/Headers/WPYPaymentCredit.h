//
//  WPYPaymentCredit.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYPaymentRequest.h"

@class WPYTenderedCard;
@class WPYTenderedCheck;

/**
 * This requests a credit to the tendered check or card.  Inherits the following properties from WPYPaymentRequest:
 * amount, amountOther, card, extendedData (for card processing)
 */
@interface WPYPaymentCredit : WPYPaymentRequest

@end
