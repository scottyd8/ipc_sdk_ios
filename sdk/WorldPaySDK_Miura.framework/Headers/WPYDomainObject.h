//
//  WPYDomainObject.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, WPYPaymentMethodDuplicateCheckType)
{
    WPYPaymentMethodDuplicateCheckTypeUnset = -1,
    WPYPaymentMethodDuplicateCheckTypeNone = 0,
    WPYPaymentMethodDuplicateCheckTypeCustomer = 1,
    WPYPaymentMethodDuplicateCheckTypeAllCustomersUnderId = 2,
    WPYPaymentMethodDuplicateCheckTypeAllCustomersUnderGroup = 3
};

typedef NS_ENUM(NSInteger, WPYResponseCode)
{
    WPYResponseCodeApproved = 0x01,
    WPYResponseCodeDeclined,
    WPYResponseCodeError
};

@interface WPYDomainObject : NSObject <NSCopying>
/**
 * The server returns object ID's as "id", which is a protected word in Objective-C.  This property 
 * contains the id returned by the server for any object returned by the server
 */
@property (nonatomic, readonly) NSString *identifier;
/**
 * Gateway response code for the current request
 */
@property (nonatomic, readonly) WPYResponseCode responseCode;
/**
 * Response Message containing a detailed message for the merchant, such as why a transaction was declined
 */
@property (nonatomic, readonly) NSString *responseMessage;
/**
 * Indicates whether or not the current request was successfully processed
 */
@property (nonatomic, readonly) BOOL success;
/**
 * Short message indicating the result of processing. Suitable to display to the card holder
 */
@property (nonatomic, readonly) NSString *result;



- (NSMutableDictionary *)jsonDictionary;
- (instancetype)initWithDictionary:(NSDictionary *)jsonDictionary;
@end
