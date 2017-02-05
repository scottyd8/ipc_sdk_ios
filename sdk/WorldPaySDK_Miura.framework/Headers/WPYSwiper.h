//
//  WPYSwiper.h
//  WorldpaySDK
//
//  Copyright (c) 2015 Worldpay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WPYTenderedCard;
@class WPYPaymentRequest;
@class WPYPaymentResponse;
@class WPYPaymentMethod;
@class WPYPaymentMethodRequest;

/**
 * Data type used for payment response object returns.
 */

typedef void (^PaymentCompletion)(WPYPaymentResponse *, NSError *);

/**
 * This is an indication of the type of transactions that a specific card application can support
 * On devices where the terminal is capable of handling application support, it will automatically
 * prompt for credit or debit when appropriate.  On non-capable devices, the application will
 * be notified when the user must choose credit or debit
 */
typedef NS_ENUM(NSUInteger, WPYCardAccountType)
{
    /// self-explanatory
    WPYCardAccountTypeCredit,
    /// self-explanatory
    WPYCardAccountTypeDebit,
    /// self-explanatory
    WPYCardAccountTypeCreditOrDebit,
    /// self-explanatory
    WPYCardAccountTypeUnknown
};

/**
 * This notifies the application developer when certain types of events have occurred.  Some of the events may not be
 * supported on all hardware.  For instance, not all terminals notify the SDK when a card has been remved from the chip
 * reader
 */
typedef NS_ENUM(NSUInteger, WPYCardEvent)
{
    /// self-explanatory
    WPYCardEventSwiped,
    /// self-explanatory
    WPYCardEventInserted,
    /// self-explanatory
    WPYCardEventRemoved,
    /// Card inserted backwards or a non-chip card was inserted
    WPYCardEventNonICCInserted,
    /// Partial or no track data received
    WPYCardEventBadSwipe,
    /// self-explanatory
    WPYCardEventIccCardSwiped
};

/**
 * When certain text needs to be displayed to the user, these prompts will be sent to the application developer to indicate
 * what kind of text should be displayed.  For terminals that canDisplayText, you can choose not to handle device prompt text
 * if you'd like to use the default text.  For terminals that cannot display text, all of these prompts must be handled and
 * properly presented to the card holder
 */
typedef NS_ENUM(uint8_t, WPYDevicePrompt)
{
    /// self-explanatory
    WPYDevicePromptInsertCard = 0x00,
    /// self-explanatory
    WPYDevicePromptInsertOrSwipe,
    /// self-explanatory
    WPYDevicePromptChipCardSwiped,
    /// self-explanatory
    WPYDevicePromptSwipeError,
    /// self-explanatory
    WPYDevicePromptConfirmAmount,
    /// self-explanatory
    WPYDevicePromptNonICCard,
    /// self-explanatory
    WPYDevicePromptEMVEmptyAidList,
    /// self-explanatory
    WPYDevicePromptEMVEmptyAidListNoFallback,
    /// self-explanatory
    WPYDevicePromptApproved,
    /// self-explanatory
    WPYDevicePromptDeclined,
    /// self-explanatory
    WPYDevicePromptCanceled,
    /// self-explanatory
    WPYDevicePromptRetry,
    /// self-explanatory
    WPYDevicePromptTransactionTimedOut,
    /// self-explanatory
    WPYDevicePromptNfcErrorCardInserted,
    /// self-explanatory
    WPYDevicePromptNfcErrorCardSwiped,
    /// self-explanatory
    WPYDevicePromptNfcErrorUseICCard,
    /// self-explanatory
    WPYDevicePromptNfcErrorUseICCOrMSR,
    /// self-explanatory
    WPYDevicePromptNfcHardwareError,
    /// self-explanatory
    WPYDevicePromptEmvReaderError,
    /// self-explanatory
    WPYDevicePromptEmvMSRFallback,
    /// self-explanatory
    WPYDevicePromptEmvInvalidCard,
    /// self-explanatory
    WPYDevicePromptProcessing,
    /// self-explanatory
    WPYDevicePromptEmvRemoveCard,
    /// self-explanatory
    WPYDevicePromptTapCardAgain,
    /// self-explanatory
    WPYDevicePromptReversal,
    /// self-explanatory
    WPYDevicePromptCallBank,
    /// self-explanatory
    WPYDevicePromptNotAccepted,
    /// self-explanatory
    WPYDevicePromptRemoveCard,
    /// self-explanatory
    WPYDevicePromptMultipleCardsDetected,
    /// self-explanatory
    WPYDevicePromptTapCard
};

/**
 * Hardware interface used to connect to the terminal.  You can query the WPYSwiper to see if it supports
 * bluetooth or audio jack capabilities.  For instance, the Anywhere Commerce version of the SDK supports
 * both types of connections.
 */
typedef NS_ENUM(NSInteger, WPYSwiperInputType)
{
    /// self-explanatory
    WPYSwiperInputTypeUnknown,
    /// self-explanatory
    WPYSwiperInputTypeAudio,
    /// self-explanatory
    WPYSwiperInputTypeBluetooth
};

/** 
 * The current connection state of the card terminal
 */
typedef NS_ENUM(NSInteger, WPYSwiperState)
{
    /// self-explanatory
    WPYSwiperDisconnected,
    /// self-explanatory
    WPYSwiperConnecting,
    /// self-explanatory
    WPYSwiperConnected
};

/**
 * Indication of when the terminal is reporting low battery status
 */
typedef NS_ENUM(NSInteger, WPYSwiperBatteryStatus)
{
    /// self-explanatory
    WPYSwiperBatteryStatusCriticallyLow,
    /// self-explanatory
    WPYSwiperBatteryStatusLow
};

/**
 * The type of encryption used to secure the SRED data for a card read from a terminal
 */
typedef NS_ENUM(NSInteger, WPYSwiperType)
{
    /// self-explanatory
    WPYSwiperTypeNotSet = -1,
    /// self-explanatory
    WPYSwiperTypeNone = 0,
    /// self-explanatory
    WPYSwiperTypeIDTech = 1,
    /// self-explanatory
    WPYSwiperTypeMagTek = 2,
    /// self-explanatory
    WPYSwiperTypeMiura = 3
};

/** 
 * Type of transaction that the merchant would like to perform.
 * A transaction with type Goods is debit/credit only with no gratuity or cash back allowed
 * A transaction with type Cashback is a sale w/ cash back allowed if supported by the card type
 * A transaction with type Services is a sale w/ inline tip adjustment allowed
 */
typedef NS_ENUM(NSInteger, WPYEMVTransactionType)
{
    /// Debit/credit only with no gratuity or cash back allowed
    WPYEMVTransactionTypeGoods,
    /// A sale w/ cash back allowed if supported by the card type
    WPYEMVTransactionTypeCashback,
    /// A sale w/ inline tip adjustment allowed
    WPYEMVTransactionTypeServices,
    /// A refund transaction
    WPYEMVTransactionTypeRefund
};

@protocol WPYSwiperDelegate;

/**
 * This is the core object used to represent the swiper. This object becomes a base class
 * for specific swiper objects designed for the given peripheral
 */
@interface WPYSwiper : NSObject
/**
 * This is used internally to note the type of encryption used on the SRED data
 */
@property (nonatomic, readonly) WPYSwiperType swiperType;
/**
 * The delegate responsible for handling events from the card terminal
 */
@property (nonatomic, weak) id<WPYSwiperDelegate> delegate;
/**
 * The current connection status of the device
 */
@property WPYSwiperState connectionState;
/**
 * Query to see if bluetooth is supported by the current swiper class
 */
@property (readonly, getter=isBluetoothSupported) BOOL bluetoothSupported;
/**
 * Query to see if audiojack is supported by the current swiper class.  Note that 
 * you must specify the correct input type for the hardware being used at the time of connection
 */
@property (readonly, getter=isAudioJackSupported) BOOL audioJackSupported;
/**
 * Indication of whether or not the card terminal supports NFC
 */
@property (readonly, getter =isNFCSupported) BOOL nfcSupported;
/**
 * Indication of whether or not the card terminal allows manual card entry on the terminal
 */
@property (readonly, getter =isManualEntrySupported) BOOL manualEntrySupported;
/**
 * The current hardware interface used by the connected device, if any
 */
@property (nonatomic, readonly) WPYSwiperInputType deviceInputType;

/**
 * Creates an instance of a swiper, with a delegate assigned at instantiation
 *
 * @param delegate The initial delegate that the swiper will call with events.  This can be changed at any time after instantiation.
 * @return An instance of a swiper
 */
- (instancetype)initWithDelegate:(id<WPYSwiperDelegate>)delegate;

/**
 * Unavailable default initializer
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 * This will connect the current Swiper object to whatever hardware interface is selected at the time of the call
 *
 * @param inputType The type of hardware interface used to communicate with the device - Audio or Bluetooth
 *
 */
- (void) connectSwiperWithInputType:(WPYSwiperInputType)inputType;

/**
 * Disconnects the current hardware and closes communication between the mobile device and the card terminal
 */
- (void) disconnectSwiper;

/**x
 * Check continuously for card events - dips or swipes.  Does not return NFC tap events
 */
- (void) checkForCard;

/**
 * Stop checking continuously for card events
 */
- (void) cancelCheckForCard;

/**
 * Cancels the current transaction
 *
 * @param customMessage This will be displayed instead of default prompt (but message will be lost if request is pending)
 *
 */
- (void) cancelTransaction:(NSString *)customMessage;

/**
 * Stat a transaction by requesting that the merchant manually enter the card data into the terminal.  This will only handle manual card events.  Any attempt
 * to swipe, tap, or insert a card will do nothing.
 *
 * @param request A pointer to the request object used to complete the payment request.  This must be populated with all required info as the transaction will begin
 *        immediately if the card entry is successful.  If the card entry is canceled then a fail message will be sent to the delegate
 */
- (void) beginManualTransactionWithRequest:(WPYPaymentRequest *)request;

/**
 * Start a contact EMV transaction.  If no EMV card is inserted, the swiper will request that a card be inserted or swiped. This handles swipe events.
 *
 * @param request A pointer to the request object used to complete the EMV Request.  This must be populated with all required info as any request for online
 *        processing will happen automatically if the terminal requests it.
 * @param transactionType The transaction type to set in the Application Cryptogram - Such as a goods sale, refund, or cashback transaction. Some devices handle
 *        cashback on the terminal and will process cashback transactions as sale and will then allow the terminal user to set a cashback amount.
 *        AnywhereCommerce devices must have the cashback amount / type set at the start of the transaction.  Miura devices will enable cashback
 *        only if this is set to type Cashback but will process as a sale if the user declines to enter a cashback amount
 */
- (void) beginEMVTransactionWithRequest:(WPYPaymentRequest *)request transactionType:(WPYEMVTransactionType)transactionType;

/**
 * Start a contactless EMV or MSD transaction.  Some hardware allows card swipes in NFC mode, others do not.  Does nothing if NFC is not supported on
 * the current terminal hardware - be sure to check if NFC is available
 *
 * @param request A pointer to the request object used to complete the EMV Request.  This must be populated with all required info as any request for online
 *        processing will happen automatically if the terminal requests it.
 * @param transactionType The transaction type to set in the Application Cryptogram - Such as a goods sale, refund, or cashback transaction. Some devices handle
 *        cashback on the terminal and will process cashback transactions as sale and will then allow the terminal user to set a cashback amount.
 *        AnywhereCommerce devices must have the cashback amount / type set at the start of the transaction
 */
- (void) beginNFCTransactionWithRequest:(WPYPaymentRequest *)request transactionType:(WPYEMVTransactionType)transactionType;

/**
 * Generate Payment Method using card information captured from the card terminal
 *
 * @param request A request object that will be populated with the information captured by the terminal
 */
- (void) createPaymentMethod:(WPYPaymentMethodRequest *)request;

/**
 * If the terminal is configured to pass application selection onto the application layer, this function must be called to select the card application,
 * when requested.
 * @param application Application to select
 */
- (void) selectEMVCardApplication:(NSInteger)application;

/**
 * If the terminal is configured to pass final transaction confirmation requests onto the application layer, this function must be called to confirm the
 * transaction total prior to online authorization
 *
 * @param confirmed A boolean indicating whether the card holder has accepted the final total
 */
- (void) confirmTransaction:(BOOL)confirmed;

/**
 * This function will indicate whether or not the application developer can request to have custom text displayed onto the terminal screen
 *
 * @return A boolean indicating whether or not the swiper's display can show custom text
 */
- (BOOL) swiperCanDisplayText;

/**
 * This function will clear the display on terminals that allow you to display custom text
 */
- (void) swiperClearDisplay;
/**
 * If supported by the terminal hardware, this will request that the custom text be displayed on the screen.  The text should be line formatted
 * by the developer based on the character width of the display in question.
 *
 * @param text A string of text that will be displayed on the terminal
 */
- (void) displayText:(NSString *)text;

/**
 * If an Application can be run as credit or debit, and the terminal hardware does not support account type selection, then the UI application will
 * be asked to select credit or debit.  If the developer does not implement the appropriate delegate function, then the default of CREDIT will be
 * selected
 *
 * @param type The account type that the user has selected.  This must be 'credit' OR 'debit', any other input will default to credit.
 */
- (void)selectAccountType:(WPYCardAccountType)type;

/**
 * This function will return the serial number of the credit card terminal.
 *
 * @return A credit card terminal serial number
 */
- (NSString *)getSerialNumber;

/**
 * This function will return the software version number of the credit card terminal.
 *
 * @return The software version of the terminal's OS
 */
- (NSString *)getFirmwareVersion;

/**
 * This function returns an account type of 'Credit' 'Debit' or 'CreditOrDebit' based on the application selected
 *
 * @param aid The AID that has been selected by the card holder / terminal
 *
 * @return An enumeration indacting what type of transactions can be run against that AID.
 */
+ (WPYCardAccountType)accountTypeForAID:(NSString *)aid;

/**
 * This method is called to determine card insertion status for prompt messages, must override
 *
 * @return self-explanatory
 */
- (BOOL) cardInserted;

/**
 * This method is called to determine default device prompt text
 *
 * @param prompt self-explanatory
 * @param parameters An optional array of strings to be used in prompt construction
 *
 * @return self-explanatory
 */
- (NSString *) defaultDevicePromptText: (WPYDevicePrompt) prompt parameters:(NSArray<NSString *> *)parameters;

@end

/**
 * Delegate protocol for handling events from the swiper.  Note that not all of these events are used by every hardware device type
 */
@protocol WPYSwiperDelegate <NSObject>
@required
/**
 * This delegate function is called when a communication channel has been opened with the credit card terminal
 *
 * @param swiper A reference to the object communicating with the credit card terminal
 */
- (void) didConnectSwiper:(WPYSwiper *)swiper;

/**
 * This delegate function is called when the communication channel to the credit card terminal has been closed.
 *
 * @param swiper A reference to the swiper that is reporting the end of communication
 */
- (void) didDisconnectSwiper:(WPYSwiper *)swiper;

/**
 * This delegate function is called when the connection to the swiper hardware fails to be created
 *
 * @param swiper A reference to the object that could not open the hardware communication
 */
- (void) didFailToConnectSwiper:(WPYSwiper *)swiper;

/**
 * This delegate function is called when the communication channel to the credit card terminal could not be opened,
 * but will be reattempted
 *
 * @param swiper A reference to the object that is continuing to attempt communication with the credit card terminal
 */
- (void) willConnectSwiper:(WPYSwiper *)swiper;

/**
 * This delegate function is called when an error has been detected when performing a requested task
 *
 * @param swiper A reference to the object that experienced the error
 * @param error An error object with information on the error that occurred
 */
- (void) swiper:(WPYSwiper *)swiper didFailWithError:(NSString *)error;

/**
 * This delegate function is called after the terminal has generated the Transaction Certificate or Application Authentication Cryptogram
 * and no more online requests are pending.
 *
 * @param swiper A reference to the object that generated and processed the EMV request
 * @param response The authorization response from the online processor, if any.  If there was a reversal, this will be the result of the payment reversal
 */
- (void) swiper:(WPYSwiper *)swiper didFinishTransactionWithResponse:(WPYPaymentResponse *)response;
/**
 * This delegate function is called when an attempt to make a payment failed with a non-authorization related error.
 *
 * @param swiper A reference to the object that attempted to perform the request
 * @param request A reference to the failed request so that it may be retried
 * @param error A reference to the error that caused the failure so that it can be properly handled
 */
- (void) swiper:(WPYSwiper *)swiper didFailRequest:(WPYPaymentRequest *)request withError:(NSError *)error;

@optional
/**
 * This delegate method is called when the terminal is incapable of presenting the account type selection to the card holder.
 * If this method is implemented then the delegate must call back the referencing object or the transaction will timeout
 *
 * @param swiper A reference to the object making the request
 * @param accountTypes An array of account types that the user must pick from (NSNumber -> WPYCardAccountType enumeration)
 */
- (void) swiper:(WPYSwiper *)swiper didRequestAccountTypeSelection:(NSArray<NSNumber *> *)accountTypes;

/**
 * This delegate method is called by some devices when the user confirms/rejects the transaction amount on the terminal hardware
 * Miura devices do not call this method
 *
 * @param swiper A reference to the object making the request
 * @param confirmed A boolean indicating whether or not the user accepted the transaction amount
 */
- (void) swiper:(WPYSwiper *)swiper didReturnAmountConfirmation:(BOOL)confirmed;

/**
 * This delegate method is called when the user keys in an amount when requested by the device
 * This method is only called by certain devices that can display text and have a keypad
 *
 * @param swiper A reference to the object making the request
 * @param amount A decimal number representing the amount the user keyed in
 * @param currencyCode The currency code of the keyed in amount
 */
- (void) swiper:(WPYSwiper *)swiper didKeyInAmount:(NSDecimalNumber *)amount currencyCode:(NSString *)currencyCode;

/**
 * This delegate method is called when the terminal sends a low battery status message
 *
 * @param swiper A reference to the object making the request
 * @param batteryStatus Indicates the battery status of the device
 */
- (void) swiper:(WPYSwiper *)swiper onBatteryLow:(WPYSwiperBatteryStatus)batteryStatus;

/**
 * This delegate method is called when the terminal is not configured to present the application options to the card holder directly
 * When the hardware supports it, the terminal will manage application selection automatically (Miura for instance)
 *
 * @param swiper A reference to the object making the request
 * @param applications A list of the Application Labels for each application in the candidate list
 */
- (void) swiper:(WPYSwiper *)swiper didRequestSelectEMVApplication:(NSArray *)applications;

/**
 * This delegate method is called when the terminal is not configured to request final transaction amount confirmation from the card holder directly
 * This is typical on audiojack devices or other devices that have no keypad
 *
 * @param swiper A reference to the object making the request
 */
- (void) swiperDidRequestFinalConfirmation:(WPYSwiper *)swiper;

/**
 * This delegate method is called when the terminal would like text displayed by the user.  If the terminal is capable of displaying text (swiperCanDisplayText)
 * and this method is implemented, then the terminal should be sent a text string to display to the user.  This can be done via the completion handler, with a NIL
 * string to have the terminal display default text.
 *
 * @param swiper A reference to the object making the request
 * @param prompt An enumeration representing the type of information that should be presented to the card holder
 * @param defaultText The default text prompt the SDK will display
 * @param completion A completion handler to call if the terminal is capable of displaying text. If not supported, a nil handler will be sent
 */
- (void) swiper:(WPYSwiper *)swiper didRequestDevicePromptText:(WPYDevicePrompt)prompt defaultText:(NSString *) defaultText completion:(void(^)(NSString *))completion;


/**
 * This delegate method is called when the terminal receives a card event.  It does not return the card data and therefore is called in the event that
 * the card data is not going to be returned for whatever reason.  For instance, a card swipe does not return data if the card is IC capable and was swiped
 *
 * @param swiper A reference to the object making the request
 * @param eventType An enumeration representing the type of card event
 */
- (void) swiper:(WPYSwiper *)swiper didReceiveCardEvent:(WPYCardEvent)eventType;

/**
 * This delegate method is called when the terminal receives card data and sends it to the secure vault to create a payment method.
 *
 * @param swiper A reference to the object that handled the request
 * @param method A reference to the payment method object returned by the server
 * @param error A reference to any error objects returned in the request
 */
- (void) swiper:(WPYSwiper *)swiper didReceivePaymentMethod:(WPYPaymentMethod *)method withError:(NSError *)error;

/**
 * This method is called when a bluetooth connection attempt is made and there may be one or more devices that are available to be paired with
 * For Anywhere Commerce bluetooth devices this may return all devices within range
 *
 * @param devices A list of the names of all the devices visible
 * @param swiper A reference to the object making the request
 * @param completion A completion handler that must be called with the index of the device that was selected by the user
 */
- (void) selectDevice:(NSArray <NSString *> *)devices forSwiper:(WPYSwiper *)swiper completion:(void(^)(int))completion;

/**
 * This method is called when a key is pressed on a supported device (Miura).  For EMV / PIN security, the key press will not be relayed to the
 * delegate and therefore this message is only useful if the application cares about keypad presses for whatever reason.
 *
 * @param swiper A reference to the card terminal that is receiving the key press
 */

- (void)swiperDidReceiveKeypadInput:(WPYSwiper *)swiper;

@end
