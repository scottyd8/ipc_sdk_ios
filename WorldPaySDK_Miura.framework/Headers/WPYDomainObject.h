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

@interface WPYDomainObject : NSObject <NSCopying>
/**
 * The server returns object ID's as "id", which is a protected word in Objective-C.  This property 
 * contains the id returned by the server for any object returned by the server
 */
@property (nonatomic, strong) NSString *identifier;
- (NSMutableDictionary *)jsonDictionary;
- (instancetype)initWithDictionary:(NSDictionary *)jsonDictionary;
@end
