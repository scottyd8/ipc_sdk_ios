//
//  WPYManualTenderEntryViewController.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPYTender;
@class WPYPaymentMethodRequest;
@class WPYPaymentMethod;

@protocol WPYManualTenderEntryDelegate;

/// Types of manual entry payment methods accepted
typedef NS_ENUM(NSInteger, WPYManualTenderType)
{
    /// self-explanatory
    WPYManualTenderTypeCredit,
    /// self-explanatory
    WPYManualTenderTypeCheck
};

/**
 * The Manual Entry View Controller is used to  to accept card or ACH information and then send the request
 * for processing.  When the event is complete, the delegate will be notified of with the payment response
 */
@interface WPYManualTenderEntryViewController : UIViewController
/**
 * Creates a Manual Entry View Controller that can be presented by the host application to accept card or ACH information and then send the request
 * for processing.  When the event is complete, the delegate will be notified of with the payment response 
 *
 * @param delegate The delegate that will be responding to the WPYManualTenderEntryDelegate protocol
 * @param tenderType The type of tender that is going to be entered (check or credit card)
 * @param request The prepopulated payment request object that will be used to process the tender. You must set things such as gratuity data, and other fields not associated with the tender itself
 */
- (instancetype) initWithDelegate:(id <WPYManualTenderEntryDelegate>)delegate tenderType:(WPYManualTenderType)tenderType request:(WPYPaymentRequest *)request;

/**
 * Creates a Manual Entry View Controller that can be presented by the host application to accept card or ACH information and then send the request
 * for processing.  When the event is complete, the delegate will be notified of with the payment response
 *
 * @param delegate The delegate that will be responding to the WPYManualTenderEntryDelegate protocol
 * @param tenderType The type of tender that is going to be entered (check or credit card)
 * @param request The prepopulated payment method request object that will be used to create the payment method. You must set all fields not associated directly with the tender itself
 */
- (instancetype)initWithDelegate:(id<WPYManualTenderEntryDelegate>)delegate tenderType:(WPYManualTenderType)tenderType paymentMethodRequest:(WPYPaymentMethodRequest *)request;
@end
/**
 * This protocol is used to establish the delegate for applications that allow the hand entering of transactions.
 */
@protocol WPYManualTenderEntryDelegate <NSObject>
/**
 * This method is called by the Manual Tender View Controller to notify the host application when a create payment method request
 * has been completed
 *
 * @param controller Reference to the Manual Entry View Controller that is notifying the application
 * @param method The payment method response sent from the Worldpay server
 * @param error Reference to any error that may have been returned during the request
 */
- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didReceivePaymentMethod:(WPYPaymentMethod *)method withError:(NSError *)error;
/**
 * This method is called by the Manual Tender View Controller to notify the host application when a request has been completed
 *
 * @param controller Reference to the Manual Entry View Controller that is notifying the application
 * @param tender The payment response sent from the Worldpay server with the authroization information
 */
- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didFinishWithResponse:(WPYPaymentResponse *)tender;
/**
 * This method is called by the Manual Tender View Controller to notify the host application when a request has failed due to an error
 *
 * @param controller Reference to the Manual Entry View Controller that experienced the error
 * @param error The error that prevented the request from being processed
 */
- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didFailWithError:(NSError *)error;

/**
 * This method is called by the Manual Tender View Controller to notify the host application that it is attempting to process a payment request
 * with the supplied tender.
 *
 * @param controller Reference to the Manual Entry View Controller that is proessing the request
 */
- (void)manualTenderEntryControllerIsProcessingRequest:(WPYManualTenderEntryViewController *)controller;
/**
 * This method is called by the Manual Tender View Controller to notify the host application that it is has been dismissed
 * with a request to cancel entry
 *
 * @param controller Reference to the Manual Entry View Controller that is proessing the request
 */
- (void)manualTenderEntryControllerDidCancelRequest:(WPYManualTenderEntryViewController *)controller;
@end
