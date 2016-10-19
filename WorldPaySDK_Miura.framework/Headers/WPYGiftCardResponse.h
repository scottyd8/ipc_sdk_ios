//
//  WPYGiftCardResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

@class WPYTenderedCard;

@interface WPYGiftCardResponse : WPYDomainObject
@property (nonatomic, strong) NSDecimalNumber *amount;
@property (nonatomic, strong) WPYTenderedCard *card;
@end
