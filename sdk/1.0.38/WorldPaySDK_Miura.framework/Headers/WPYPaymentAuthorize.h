//
//  WPYPaymentAuthorize.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYPaymentRequest.h"

@class WPYTenderedCard;
@class WPYExtendedCardData;
@class WPYPaymentToken;

/**
 * This requests authorization of the provided token or Tendered Card.  Inherits the following properties from WPYPaymentRequest: 
 * amount, amountOther, card, extendedData (for card processing)
 */
@interface WPYPaymentAuthorize : WPYPaymentRequest

@end
