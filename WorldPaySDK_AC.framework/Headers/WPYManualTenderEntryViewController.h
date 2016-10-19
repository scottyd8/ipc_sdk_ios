//
//  WPYManualTenderEntryViewController.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WPYTender;
@protocol WPYManualTenderEntryDelegate;

typedef NS_ENUM(NSInteger, WPYManualTenderType)
{
    WPYManualTenderTypeCredit,
    WPYManualTenderTypeCheck
};

@interface WPYManualTenderEntryViewController : UIViewController
/**
 * Creates a Manual Entry View Controller that can be presented by the host application to accept card or ACH information and then send the request
 * for processing.  When the event is complete, the delegate will be notified of with the payment response 
 *
 * @param The delegate that will be responding to the WPYManualTenderEntryDelegate protocol
 * @param The type of tender that is going to be entered (check or credit card)
 * @param The prepopulated payment request object that will be used to process the tender
 */
- (instancetype) initWithDelegate:(id <WPYManualTenderEntryDelegate>)delegate tenderType:(WPYManualTenderType)tenderType request:(WPYPaymentRequest *)request;
@end

@protocol WPYManualTenderEntryDelegate <NSObject>
/**
 * This method is called by the Manual Tender View Controller to notify the host application when a request has been completed
 *
 * @param Reference to the Manual Entry View Controller that is notifying the application
 * @param The payment response sent from the Worldpay server with the authroization information
 */
- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didFinishWithResponse:(WPYPaymentResponse *)tender;
/**
 * This method is called by the Manual Tender View Controller to notify the host application when a request has failed due to an error
 *
 * @param reference to the Manual Entry View Controller that experienced the error
 * @param The error that prevented the request from being processed
 */
- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didFailWithError:(NSError *)error;

/**
 * This method is called by the Manual Tender View Controller to notify the host application that it is attempting to process a payment request
 * with the supplied tender.
 *
 * @param reference to the Manual Entry View Controller that is proessing the request
 */
- (void)manualTenderEntryControllerIsProcessingRequest:(WPYManualTenderEntryViewController *)controller;

/**
 * This method is called by the Manual Tender View Controller to notify the host application that it is has been dismissed
 * with a request to cancel entry
 *
 * @param reference to the Manual Entry View Controller that is proessing the request
 */
- (void)manualTenderEntryControllerDidCancelRequest:(WPYManualTenderEntryViewController *)controller;
@end
