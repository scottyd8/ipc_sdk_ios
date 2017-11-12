//
//  WPYPaymentCharge.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYPaymentRequest.h"

@class WPYTenderedCard;
@class WPYTenderedCheck;
@class WPYExtendedCardData;

/**
 * This requests immediate authorization and capture of the tendered check or card.  Inherits the following properties from WPYPaymentRequest:
 * amount, amountOther, card, extendedData (for card processing)
 */
@interface WPYPaymentCharge : WPYPaymentRequest

@end
