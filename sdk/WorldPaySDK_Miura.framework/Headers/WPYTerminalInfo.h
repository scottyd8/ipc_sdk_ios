//
//  WPYTerminalInfo.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/** 
 * This object contains information about the terminal used to capture a card read.  This can be set on a request prior to starting
 * a card transaction.  If it is not set, or if certain fields are left unpopulated, the SDK will automatically add this object to
 * the request and populate any missing fields.
 */
@interface WPYTerminalInfo : WPYDomainObject
/**
 * This parameter corresponds to the identifier associated with the terminal used to capture the transaction.  If the terminal ID was
 * not set at the time an authorization token was requested and is not provided through this object, then the SDK will automatically
 * use the terminal serial number as the ID
 */
@property (nonatomic, strong) NSString *terminalId;
/**
 * An optional parameter indicating the city that the terminal is located in
 */
@property (nonatomic, strong) NSString *city;
/**
 * An optional parameter indicating the state that the terminal is located in
 */
@property (nonatomic, strong) NSString *state;
/**
 * An optional parameter that is indicates the location that the terminal is associated with
 */
@property (nonatomic, strong) NSString *location;
/**
 * An optional parameter corresponding to the store number that the terminal is associated with
 */
@property (nonatomic, strong) NSString *storeNumber;
/**
 * If not provided, this parameter is automatically provided by the SDK when a card terminal is used to capture credit card data.
 */
@property (nonatomic, strong) NSString *kernelVersionNo;
/**
 * If not provided, this parameter is automatically provided by the SDK when a card terminal is used to capture credit card data.
 */
@property (nonatomic, strong) NSString *pOSTerminalInputCapabilityInd;
@end
