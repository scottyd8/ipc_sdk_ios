//
//  WPYEMVData.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"
#import "WPYPaymentResponse.h"

/**
 * Private object that contains information that the SDK will pass down to the credit card terminal
 */
@interface WPYEMVData : WPYDomainObject
/**
 * EMV Auth Code (Used for tag 8A if provided, otherwise generated manually based on gateway response)
 */
@property (nonatomic, strong) NSString *emvAuthResponseCode;
/**
 * EMV Issuer Authentication Data tag 91, if provided.  This is cryptographically signed by the issuer
 * and cannot be derived.  The card has the option to decline if this data is not returned on an authorization
 */
@property (nonatomic, strong) NSString *issuerAuthenticationData;
/**
 * This is returned by the terminal after the issuer scripts have been completed
 */
@property (nonatomic, strong) NSString *issuerScriptResult;
/**
 * Issuer Script 1 is run prior to the Second AC generation and is embedded in tag 71.  The script result 
 * should be included in the 2nd AC upon completion
 */
@property (nonatomic, strong) NSString *issuerScriptTemplate1;
/**
 * Issuer SCript i2 is run after the Second AC generation and is embedded in tag 72.  The script result will
 * be returned by the terminal and the result should also be included in the next ARQC generated by the card
 */
@property (nonatomic, strong) NSString *issuerScriptTemplate2;

/**
 * This method will take the object and, based on the auth code and response message from the gateway, will
 * create the EMV result TLV to send down to the terminal for 2nd AC generation
 *
 * @param responseCode The response code returned on the Payment Response
 * @return The "Response Text" returned by the server, which may contain information about a declined transaction.
 */
- (NSString *)encodeEMVDataWithAuthCode:(WPYResponseCode)responseCode;
@end
