//
//  WorldpayAPI.h
//  WorldpaySDK
//
//  Copyright (c) 2015 Worldpay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WPYSwiper.h"
#import "WPYTransactionUpdate.h"

@protocol WPYSwiperDelegate;
@class WPYAuthTokenRequest;
@class WPYAuthTokenResponse;
@class WPYTender;
@class WPYCustomerRequestData;
@class WPYCustomerResponseData;
@class WPYPaymentMethod;
@class WPYPaymentMethodRequest;

@class WPYPaymentAuthorize;
@class WPYPaymentCapture;
@class WPYPaymentCharge;
@class WPYPaymentVerify;
@class WPYPaymentVoid;
@class WPYPaymentRefund;
@class WPYPaymentCredit;
@class WPYTransactionResponse;
@class WPYBatchResponse;
@class WPYGiftCardResponse;
@class WPYPaymentResponse;
@class WPYTransactionSearch;
@class WPYTransactionSearchResponse;

extern NSString *const WorldpaySDKErrorDomain;

@protocol WPYDebugDelegate;

/**
 * This is the error code returned when an NSError is generated due to a missing authentication token.
 * No web service calls can complete (except for the token request) without a valid authorization token
 */
typedef NS_ENUM(NSInteger, WorldpaySDKError)
{
    /// No auth token provided
    WorldpaySDKErrorNoAuthToken = 10001,
    /// Returned if you try to run an auth on a manually entered check, for instance
    WorldpaySDKErrorInvalidRequestTypeForTender = 100002,
    /// self-explanatory
    WorldpaySDKErrorTerminalConnectionLost = 100003,
    // Encryption Keys missing on device
    WorldpaySDKErrorNoEncryptionKeys
};

/**
 * Enum for environments
 */
typedef NS_ENUM(NSInteger, WPYEnvironment)
{
    /// self-explanatory
    WPYEnvironmentDemo = 0,
    /// self-explanatory
    WPYEnvironmentProd = 1,
};


/**
 * This is a singleton object that contains the base of the Worldpay Total calling methods.
 */
@interface WorldPayAPI : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

/**
 * Tells the WorldpayAPI object to send messages to the test host configured at compile time
 */
@property (nonatomic, readonly) BOOL enableTestHost;

/**
 * When enabled, and TestHost is enabled, the debugDelegate will be sent HTTP request and response bodies for logging purposes.
 * These bodies may contain PCI or PII data and may only be used with test cards on a test environment
 */
@property (nonatomic) BOOL enableTestHostDebug;

/**
 * The delegate that would like to receive debug messages containing HTTP request and response bodies
 */
@property (nonatomic, weak) id<WPYDebugDelegate> debugDelegate;
/**
 *  The terminal ID set when the auth token request was made
 */
@property (nonatomic, readonly) NSString *terminalId;

/**
 * Returns shared instance pointer of the WorldpayAPI entry point
 *
 * @return instance pointer to singleton class
 */
+ (WorldPayAPI *)instance;

/**
 WorldpayServerErrorDomain is the error domain used when the server attempted to process the response, but could not
 */
extern NSString *const WorldpayServerErrorDomain;

/**
 * Class instance init unavailable.  Use WorldpayAPI instance to get class instance
 *
 * @return instance of class
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 * Returns a pointer to a credit card swiper object
 *
 * @param delegate Delegate that will listen to swiper events
 *
 * @return WPYSwiper object
 */
- (WPYSwiper *)swiperWithDelegate:(id<WPYSwiperDelegate>)delegate;

#pragma mark authentication

/**
 * Authenticates user credentials against the World Pay server. The token
 * will automatically be saved in the application keychain by the SDK and
 * can be removed by calling: - clearSDKKeychain.
 *
 * @param authTokenRequest Auth Token Request object containing user credentials
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)generateAuthToken:(WPYAuthTokenRequest *)authTokenRequest withCompletion:(void(^)(WPYAuthTokenResponse *, NSError *))completion;

/**
 * This will choose the environment to be used to run API calls in. It can only be called once
 * per application run, subsequent calls attempting to change it will be ignored. This method must be called
 * before running any API calls and ideally should be called in AppDelegate.
 *
 * @param environment enumerated value for environment (e.g. demo, prod)
 */
- (void)registerEnvironment: (WPYEnvironment)environment;

/**
 * Clears the keychain data out of the application. Completely resets the auth token information
 * and removes it from the application keychain.  A new auth token must be generated in order
 * to make calls to the web APIs after this is executed
 */
- (void)clearSDKKeychain;
- (NSString *)getSdkVersion;
#pragma mark batch handling

/**
 * Gets the current batch identifier
 *
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)getCurrentBatchWithCompletion:(void(^)(WPYBatchResponse *, NSError *))completion;

/**
 * Closes the current batch
 *
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)closeCurrentBatchWithCompletion:(void(^)(WPYBatchResponse *, NSError *))completion;

#pragma mark Stored Customer Info

/**
 * Gets customer data from the server
 *
 * @param customerId Customer ID that reqpresents the desired customer
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)getCustomerDataForCustomerId:(NSString *)customerId withCompletion:(void(^)(WPYCustomerResponseData *, NSError *))completion;

/**
 * Creates a new customer object to be stored on the server
 *
 * @param customerData The customer data that should be saved on the server
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)createCustomer:(WPYCustomerRequestData *)customerData withCompletion:(void(^)(WPYCustomerResponseData *, NSError *))completion;

/**
 * Updates an existing customer on the server
 *
 * @param customerId Customer id corresponding to the customer being updated
 * @param customerData The customer data that should be updated
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)updateCustomer:(NSString *)customerId withData:(WPYCustomerRequestData *)customerData andCompletion:(void(^)(WPYCustomerResponseData *, NSError *))completion;

#pragma mark Gift Card
/**
 * Get Gift Card from server
 *
 * @param identifier Gift card id
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)getGiftCard:(NSString *)identifier withCompletion:(void(^)(WPYGiftCardResponse *, NSError *))completion;

/**
 * Update gift card stored on the server
 *
 * @param identifier Identifier for the card to be updated
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)updateGiftCard:(NSString *)identifier withCompletion:(void(^)(WPYGiftCardResponse *, NSError *))completion;

/**
 * Create a new gift card to be stored on the serfver
 *
 * @param identifier Identifier of the card to be stored on the server
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)createGiftCard:(NSString *)identifier withCompletion:(void(^)(WPYGiftCardResponse *, NSError *))completion;

#pragma mark customer stored payment methods
/**
 * Delete a payment method being stored on the server
 *
 * @param paymentMethod Payment method to be deleted on the server
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)deletePaymentMethod:(WPYPaymentMethod *)paymentMethod withCompletion:(void(^)(NSError *))completion;

/**
 * Get payment method from the server
 *
 * @param methodId Identifier of the payment method stored on the server
 * @param customerId Identifier of the customer associated with the payment method
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)getPaymentMethod:(NSString *)methodId withCustomerId:(NSString *)customerId completion:(void(^)(WPYPaymentMethod *, NSError *))completion;

/**
 * Update an existing payment method on the server
 *
 * @param paymentMethod The updated payment method
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)updatePaymentMethod:(WPYPaymentMethod *)paymentMethod withCompletion:(void(^)(WPYPaymentMethod *, NSError *))completion;

/**
 * Create a new payment method on the server
 *
 * @param request Request object containing the payment method information
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)createPaymentMethod:(WPYPaymentMethodRequest *)request withCompletion:(void(^)(WPYPaymentMethod *, NSError *))completion;

#pragma mark payment processing
/**
 * Request Authorization of a payment
 *
 * @param request Payment authorize request object with the appropriate payment information
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)paymentAuthorize:(WPYPaymentAuthorize *)request withCompletion:(void(^)(WPYPaymentResponse *, NSError *))completion;

/**
 * Capture an authorized payment
 *
 * @param request Payment capture request object with the information about the authorized request
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)paymentCapture:(WPYPaymentCapture *)request withCompletion:(void(^)(WPYPaymentResponse *, NSError *))completion;

/**
 * Immediately charge payment using the requested payment type
 *
 * @param request Payment charge request object containing all of the information needed to charge a payment
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)paymentCharge:(WPYPaymentCharge *)request withCompletion:(void(^)(WPYPaymentResponse *, NSError *))completion;

/**
 * Card verification allows merchants to verify the cardholder account number, address, or security code.
 *
 * @param request Payment verify request object containing all of the information needed to verify the payment card
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)paymentVerify:(WPYPaymentVerify *)request withCompletion:(void(^)(WPYPaymentResponse *, NSError *))completion;
/**
 * Void an authorized payment
 *
 * @param request Payment Void request object that contains the needed information to void an authorized transaction
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)paymentVoid:(WPYPaymentVoid *)request withCompletion:(void(^)(WPYPaymentResponse *, NSError *))completion;

/**
 * Refund a payment that has been captured
 *
 * @param request PaymentRefund request object needed to refund a captured payment
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)paymentRefund:(WPYPaymentRefund *)request withCompletion:(void(^)(WPYPaymentResponse *, NSError *))completion;

/**
 * Request a credit to the tender in the request object
 *
 * @param request Payment Credit request object containing the tender info needed to apply a credit
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)paymentCredit:(WPYPaymentCredit *)request withCompletion:(void(^)(WPYPaymentResponse *, NSError *))completion;

#pragma mark transactions
/**
 * Get details for a transaction by identifier
 *
 * @param transactionId transaction identifier
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)getTransactionDetails:(NSString *)transactionId withCompletion:(void(^)(WPYTransactionResponse *, NSError *))completion;

/**
 * Search transactions
 *
 * @param searchParams Search parameters include the start and end date for the search
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)searchTransactions:(WPYTransactionSearch *)searchParams withCompletion:(void(^)(WPYTransactionSearchResponse *, NSError *))completion;

/**
 * Update transactions
 *
 * @param request request object which contains info of the transaction which needs to be updated
 * @param completion Completion handler used to notify the caller of any server results or errors
 */


- (void)updateTransaction:(WPYTransactionUpdate *)request withCompletion:(void(^)(WPYTransactionResponse *, NSError *))completion;

/**
 * Get transactions in the current batch
 *
 * @param batchId Batch identifier for transactions
 * @param completion Completion handler used to notify the caller of any server results or errors
 */
- (void)getTransactionsInBatch:(NSString *)batchId withCompletion:(void(^)(WPYBatchResponse *, NSError *))completion;




@end

/**
 * Delegate protocol for use with debugging request and response logs
*/
@protocol WPYDebugDelegate <NSObject>

/**
 * This method is used to convey the request headers and body to be sent to the server
 *
 * @param request Request string containing the pertinent information
 */
- (void)willSendRequest:(NSString *)request;

/**
 * This method is used to convey the response body that was sent from the server
 *
 * @param response Response string containing the pertinent response info
 */
- (void)didReceiveResponse:(NSString *)response;

@end

/**
 * This class is used to write to the log
 * @param message Message to write to the file
 *
 * @param response Response string containing the pertinent response info
 */
@interface WPYLogger : NSObject
+ (void)logMessage:(NSString *)message, ...;
@end
