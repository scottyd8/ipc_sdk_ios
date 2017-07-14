//
//  WorldpaySDK.h
//  WorldpaySDK
//
//  Copyright (c) 2015 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorldPayAPI.h"
#import "WPYAuthTokenRequest.h"
#import "WPYAuthTokenResponse.h"
#import "WPYCustomerRequestData.h"
#import "WPYCustomerResponseData.h"
#import "WPYSwiper.h"
#import "WPYAddressInfo.h"
#import "WPYTender.h"
#import "WPYTenderedCard.h"
#import "WPYTenderedCheck.h"
#import "WPYPaymentMethodRequest.h"
#import "WPYPaymentAuthorize.h"
#import "WPYPaymentCapture.h"
#import "WPYPaymentVoid.h"
#import "WPYPaymentRefund.h"
#import "WPYPaymentCredit.h"
#import "WPYPaymentVerify.h"
#import "WPYGetPaymentToken.h"
#import "WPYBatchResponse.h"
#import "WPYExtendedCardData.h"
#import "WPYGiftCardResponse.h"
#import "WPYLevelTwoData.h"
#import "WPYPaymentCharge.h"
#import "WPYPaymentMethod.h"
#import "WPYPaymentToken.h"
#import "WPYTenderServiceData.h"
#import "WPYTerminalInfo.h"
#import "WPYTransactionResponse.h"
#import "WPYManualTenderEntryViewController.h"
#import "WPYStoredCheck.h"
#import "WPYStoredCard.h"
#import "WPYCheckTransactionData.h"
#import "WPYCardTransactionData.h"
#import "WPYPaymentResponse.h"
#import "WPYEMVData.h"
#import "WPYReceiptObject.h"
#import "WPYTransactionSearch.h"
#import "WPYTransactionSearchResponse.h"
#import "WPYTransaction.h"
#import "WPYMailOrTelephoneOrderData.h"

//! Project version number for WorldpaySDK.
FOUNDATION_EXPORT double WorldpaySDKVersionNumber;

//! Project version string for WorldpaySDK.
FOUNDATION_EXPORT const unsigned char WorldpaySDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WorldPaySDK/PublicHeader.h>


#define LocalizeString(key) \
[[NSBundle bundleForClass:[self class]] localizedStringForKey:(key) value:@"" table:nil]
