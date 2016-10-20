//
//  WPYTenderServiceData.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/**
 * This optional object contains information pertaining to the service industry and a payment transaction
 */
@interface WPYTenderServiceData : WPYDomainObject
/**
 * An optional parameter is the gratiuty amount being added to the transaction. It does not modify data
 * sent to the terminal in an EMV transaction
 */
@property (nonatomic, strong) NSDecimalNumber *gratuityAmount;
/**
 * An optional parameter specifying the server who is entitled to the gratuity
 */
@property (nonatomic, strong) NSString *server;
@end
