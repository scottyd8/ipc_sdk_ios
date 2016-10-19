//
//  WPYPaymentVoid.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/** 
 * This enumeration indicates who is requesting the void - the merchant or the terminal / card.  This
 * does not ever need to be used by the merchant or developer as WPYVoidTypeMerchant is automatically
 * set and overridden by the SDK when an EMV reversal is being performed
 */
typedef NS_ENUM(uint8_t, WPYVoidType)
{
    WPYVoidTypeMerchant = 1,
    WPYVoidTypeSystem = 2
};

@class WPYTenderedCard;

/**
 * This requests that the transaction specified be voided.  An EMV card need only be specified if handling the reversal
 * of a transaction that was authorized online.  In the event of an EMV reversal, the SDK will automatically populate
 * the card field with the reversal request data
 */
@interface WPYPaymentVoid : WPYDomainObject
/**
 * The amount of the transaction being voided
 */
@property (nonatomic, strong) NSDecimalNumber *amount;
/**
 * The ID of the transaction being voided
 */
@property (nonatomic, strong) NSString *transactionId;
/**
 * This optional parameter is automatically provided by the SDK when a void is being requested due to an EMV reversal 
 * situation.  This parameter should not be included when a normal merchant initiated void is occuring
 */
@property (nonatomic, strong) WPYTenderedCard *card; // optional for card generated EMV reversals
/**
 * The type of void being sent to the gateway.  This is automatically set by the SDK to merchant unless
 * the transaction is caused by an EMV reversal.  The application developer does not need to do anything
 * with this parameter
 */
@property (nonatomic) WPYVoidType voidType;
@end
