//
//  WPYAuthTokenRequest.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPYDomainObject.h"

/**
 * This object is sent when requesting an authorization token from the server so that other APIs can be used.
 * The SDK automatically stores the token in the device keychain, but returns a copy of the token just in case
 * the developer needs it for some reason.  Only one ID and Key/PIN should be set, based on the processing
 * gateway the application is to use
 */
@interface WPYAuthTokenRequest : WPYDomainObject
/** 
 * If using the SecureNet gateway, this ID must be set
 */
@property (nonatomic, strong) NSString *secureNetId;

/**
 * If using the SecureNet gateway, this key must be set
 */
@property (nonatomic, strong) NSString *secureNetKey;
/**
 * If using the Merchant Partners gateway, this ID must be set
 */
@property (nonatomic, strong) NSString *merchantPartnersId;
/**
 * If using the Merchant Partners gateway, this PIN must be set
 */
@property (nonatomic, strong) NSString *merchantPartnersPin;
/**
 * All applications must set their ID
 */
@property (nonatomic, strong) NSString *applicationId;
/** 
 * All applications must present a terminal ID
 */
@property (nonatomic, strong) NSString *terminalId;
/**
 * All applications must present the name of their terminal vendor
 */
@property (nonatomic, strong) NSString *terminalVendor;
@end
