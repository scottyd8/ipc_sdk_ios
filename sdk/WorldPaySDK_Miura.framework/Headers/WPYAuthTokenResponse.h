//
//  WPYAuthTokenResponse.h
//  WorldPaySDK
//
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "WPYResponseObject.h"
/**
 * This class defines the data fields returned back from a WPYAuthTokenRequest transaction. You typically
 * don't need to access the token as it is also kept in the device keychain, however you will likely need
 * other data from the super calss WPYResponseObject */
@interface WPYAuthTokenResponse : WPYResponseObject
/**
 * The authorization token issued by the server.
 */
@property (nonatomic, readonly, getter=authToken) NSString *authToken;
@end
