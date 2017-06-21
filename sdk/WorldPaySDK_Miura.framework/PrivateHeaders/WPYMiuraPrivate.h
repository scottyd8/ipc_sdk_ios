//
//  WPYMiuraPrivate.h
//  WorldpaySDK
//
//  Created by Jonas Whidden on 3/7/17.
//  Copyright © 2017 Worldpay. All rights reserved.
//

#import "WPYSwiperPrivate.h"
#import "WPYPaymentResponse.h"
#import "WorldpaySDK.h"
#import "WPYPaymentRequest.h"
#import "WPYPaymentRequest.h"
#import "WPYReceiptObject.h"
#import "WPYTrackData.h"
#import "WPYTender.h"
#import "MiuraBluetooth.h"
#import "PINRequestData.h"
#import "WPYResponseObjectPrivate.h"
#import "WPYPaymentMethodRequest.h"
#import "WPYMiuraPrivate.h"


typedef enum : NSUInteger {
    IdleState,
    InitialState,
    ApplicationSelectionState,
    DebitCreditState,
    TipState,
    ConfirmAmountState,
    CashbackState,
    PinState,
    PinRetryState,
    FinalState
} TransactionFlowState;



@interface WPYMiura () <MiuraDeviceControllerDelegate>

@property (strong, nonatomic) NSDateFormatter * _Nullable expirationDateFormatter;
@property (strong, nonatomic) NSDateFormatter * _Nullable terminalTimeFormatter;
@property (strong, nonatomic) NSNumberFormatter * _Nullable currencyFormatter;
@property (strong, nonatomic) NSNumberFormatter * _Nullable decimalFormatter;
@property (nonatomic) WPYCardInputType cardInputType;
@property (nonatomic, strong) WPYTenderedCard * _Nullable pendingCard;
@property (nonatomic, strong) WPYPaymentRequest * _Nullable currRequest;
@property (nonatomic, strong) WPYPaymentResponse * _Nullable currentResponse;
@property (nonatomic, strong) TransactionData * _Nullable currTransactionData;
@property (nonatomic) BOOL enableCashback;
@property (nonatomic) BOOL enableGratuity;
@property (nonatomic) NSUInteger iccRetryCount;
@property (nonatomic) BOOL cardNotSupported;
@property (nonatomic) BOOL requireEMVFallback;
@property (nonatomic) BOOL cancelPendingRequest;
@property (nonatomic, strong) NSString * _Nullable firmwareVersion;
@property (nonatomic, strong) NSString * _Nullable serialNumber;
@property (nonatomic) CardStatus cardStatus;
@property (nonatomic) NSInteger connectRetryAttempts;
@property (nonatomic, strong) WPYPaymentMethodRequest * _Nullable createMethodRequest;
@property (nonatomic) BOOL allowDebit;
@property (nonatomic) BOOL allowCredit;
@property (nonatomic) BOOL allowCashback;
@property (nonatomic) BOOL allowDebitOriginal;
@property (nonatomic) BOOL allowCreditOriginal;
@property (nonatomic) BOOL allowCashbackOriginal;
@property (nonatomic, strong) NSMutableDictionary * _Nullable manualCardDict;
@property (nonatomic, weak) MiuraDeviceController * _Nullable deviceController;
@property (nonatomic, assign) TransactionFlowState transactionFlowState;
@property (nonatomic, assign) BOOL applicationSelectionRequired;
@property (nonatomic, strong) NSArray * _Nullable applications;
@property (nonatomic) BOOL delegateDidCheckCard;
@property (nonatomic, strong) TransactionSettings * _Nullable currSettings;
@property (nonatomic) BOOL pinRetryInProgress;

- (void) promptGratuityIfNecessary;
- (void) promptCashbackIfNecessary;
- (void) handleCardPaymentEvent;

@end
