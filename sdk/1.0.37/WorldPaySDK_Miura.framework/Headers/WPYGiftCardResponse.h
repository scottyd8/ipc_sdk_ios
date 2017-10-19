//
//  WPYGiftCardResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYResponseObject.h"

@class WPYTenderedCard;

@interface WPYGiftCardResponse : WPYResponseObject
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, strong) WPYTenderedCard *card;
@end
