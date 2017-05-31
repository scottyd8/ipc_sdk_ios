//
//  WPYMiuraPrivate.h
//  WorldPaySDK
//
//  Created by Jonas Whidden on 3/7/17.
//  Copyright © 2017 WorldPay. All rights reserved.
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
    InitialState,
    ApplicationSelectionState,
    DebitCreditState,
    TipState,
    ConfirmAmountState,
    CashbackState,
    PinState,
    FinalState
} TransactionFlowState;



@interface WPYMiura () <MiuraDeviceControllerDelegate>

@property (strong, nonatomic) NSDateFormatter *expirationDateFormatter;
@property (strong, nonatomic) NSDateFormatter *terminalTimeFormatter;
@property (strong, nonatomic) NSNumberFormatter *currencyFormatter;
@property (strong, nonatomic) NSNumberFormatter *decimalFormatter;
@property (nonatomic) WPYCardInputType cardInputType;
@property (nonatomic, strong) WPYTenderedCard *pendingCard;
@property (nonatomic, strong) WPYPaymentRequest *currRequest;
@property (nonatomic, strong) WPYPaymentResponse *currentResponse;
@property (nonatomic, strong) TransactionData *currTransactionData;
@property (nonatomic) BOOL enableCashback;
@property (nonatomic) BOOL enableGratuity;
@property (nonatomic) NSUInteger iccRetryCount;
@property (nonatomic) BOOL cardNotSupported;
@property (nonatomic) BOOL requireEMVFallback;
@property (nonatomic) BOOL cancelPendingRequest;
@property (nonatomic, strong) NSString *firmwareVersion;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic) CardStatus cardStatus;
@property (nonatomic) NSInteger connectRetryAttempts;
@property (nonatomic, strong) WPYPaymentMethodRequest *createMethodRequest;
@property (nonatomic) BOOL allowDebit;
@property (nonatomic) BOOL allowCredit;
@property (nonatomic) BOOL allowCashback;
@property (nonatomic) BOOL allowDebitOriginal;
@property (nonatomic) BOOL allowCreditOriginal;
@property (nonatomic) BOOL allowCashbackOriginal;
@property (nonatomic, strong) NSMutableDictionary *manualCardDict;
@property (nonatomic, weak) MiuraDeviceController * deviceController;
@property (nonatomic, assign) TransactionFlowState transactionFlowState;
@property (nonatomic, assign) BOOL applicationSelectionRequired;
@property (nonatomic, strong) NSArray * applications;

- (void) promptGratuityIfNecessary;
- (void) promptCashbackIfNecessary;
- (void) handleCardPaymentEvent;

@end