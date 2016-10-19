//
//  TransactionViewController.m
//  WorldPaySDKDemo
//
//  Created by Jonas Whidden on 10/4/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "TransactionViewController.h"
#import "DropDownTextField.h"
#import "ExtendableView.h"
#import "UIFont+Worldpay.h"
#import "UIColor+Worldpay.h"
#import "ExtendedInformationView.h"
#import "TransactionDetailViewController.h"
#import "SignatureViewController.h"
#import "LandscapeNavigationController.h"

#define YESINDEX 0
#define NOINDEX 1
#define VAULTINDEX 2

#define AUTHORIZEINDEX 0
#define CHARGEINDEX 1
#define CREDITINDEX 2

#define LABELTEXTSIZE 17
#define TEXTFIELDSIZE 14
#define BUTTONTEXTSIZE 15

#define MAGICMARGIN 28
#define VAULTHEIGHT 65
#define VAULTTOPMARGIN 8

@interface TransactionViewController ()

@property (weak, nonatomic) IBOutlet DropDownTextField *transactionTypeDropDown;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardPresentSegmented;
@property (weak, nonatomic) IBOutlet UISegmentedControl *addToVaultSegmented;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *cashbackTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *paymentMethodTextField;
@property (strong, nonatomic) WPYSwiper * swiper;
@property (weak, nonatomic) IBOutlet ExtendableView *extendableInfoView;
@property (weak, nonatomic) ExtendedInformationView * extendedInfoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *extendableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vaultHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vaultTopMarginConstraint;
@property (weak, nonatomic) IBOutlet UIView * vaultView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *formLabels;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, atomic) UIAlertController * swiperAlert;
@property (weak, nonatomic) UITextField * activeTextField;
@property (strong, nonatomic) WPYTransactionResponse * lastResponse;
@property (assign, atomic) BOOL transition;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *addToVaultConstraints;
@property (assign, atomic) BOOL transactionInProgress;

@end

@implementation TransactionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = @"Transactions";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self toggleVaultInfo:false];
    
    if(![self.transactionTypeDropDown sharedInitWithOptionList:@[@"Authorize", @"Charge", @"Credit"] initialIndex:0 parentViewController:self title:@"Transaction Type"])
    {
        NSAssert(FALSE, @"%@", @"Drop down failed to initialized properly");
    }
    
    // Comment this to show add to vault
    //----
    [self.addToVaultSegmented setSelectedSegmentIndex:NOINDEX];
    [self.addToVaultSegmented setHidden:true];
    
    for(NSLayoutConstraint * constraint in self.addToVaultConstraints)
    {
        constraint.constant = 0;
        [self.addToVaultSegmented setSelectedSegmentIndex:NOINDEX];
    }
    //----
    
    // Grab swiper from API
    self.swiper = [[WorldpayAPI instance] swiperWithDelegate:self];
    
    self.amountTextField.delegate = self;
    self.cashbackTextField.delegate = self;
    self.paymentMethodTextField.delegate = self;
    self.customerIdTextField.delegate = self;
    
    [self.extendableInfoView setTitle:@"Extended Information"];

    ExtendedInformationView * infoView = [[ExtendedInformationView alloc] initWithFrame:CGRectMake(0, 0, self.extendableInfoView.frame.size.width+MAGICMARGIN, [ExtendedInformationView expectedHeight])];
    
    self.extendedInfoView = infoView;
    
    [infoView setTextFieldDelegate:self];
    
    [self.extendableInfoView setSecondaryViewInContainer:infoView];
    [self.extendableInfoView setSecondaryHeight: [ExtendedInformationView expectedHeight]];
    [self.extendableInfoView setHeightConstraint:self.extendableViewHeightConstraint];
    [self.extendableInfoView setHeightCallback:^(CGFloat height)
    {
        [self removeFocusFromTextField:nil];
        
        if(height < 0)
        {
            for(UITextField * textField in self.extendedInfoView.textFields)
            {
                textField.text = @"";
            }
        }
    }];
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.scrollView addGestureRecognizer:recognizer1];
    
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer2 setNumberOfTapsRequired:1];
    [recognizer2 setNumberOfTouchesRequired:1];
    [self.extendedInfoView addGestureRecognizer:recognizer2];
    
    [self.amountTextField setFont:[UIFont worldpayPrimaryWithSize: TEXTFIELDSIZE]];
    [self.cashbackTextField setFont:[UIFont worldpayPrimaryWithSize: TEXTFIELDSIZE]];
    [self.cardPresentSegmented setTitleTextAttributes:[UIFont worldpayPrimaryAttributesWithSize: TEXTFIELDSIZE] forState:UIControlStateNormal];
    [self.addToVaultSegmented setTitleTextAttributes:[UIFont worldpayPrimaryAttributesWithSize: TEXTFIELDSIZE] forState:UIControlStateNormal];
    [self.startButton.titleLabel setFont:[UIFont worldpayPrimaryWithSize: BUTTONTEXTSIZE]];
    
    for(UILabel * label in self.formLabels)
    {
        [label setFont:[UIFont worldpayPrimaryWithSize: LABELTEXTSIZE]];
    }
    
    [self validateCashbackAllowed];
    
    [self.transactionTypeDropDown setSelectionCallback:^(NSUInteger __unused index)
    {
        [self removeFocusFromTextField:nil];
        [self validateCashbackAllowed];
    }];
    
    self.startButton.backgroundColor = [UIColor worldpayEmerald];
    [self.startButton setTitleColor:[UIColor worldpayWhite] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.swiper connectSwiperWithInputType:WPYSwiperInputTypeBluetooth];
    self.transition = NO;
    self.swiperAlert = nil;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.swiper disconnectSwiper];
    self.transition = NO;
    self.swiperAlert = nil;
}

- (void) validateCashbackAllowed
{
    [self.cashbackTextField setEnabled: [self cashbackAllowed]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) startTransactionProgress
{
    self.transactionInProgress = true;
}

- (void) stopTransactionProgress
{
    self.transactionInProgress = false;
}

- (void) toggleVaultInfo: (BOOL) visible
{
    if(visible && self.vaultHeightConstraint.constant == 0)
    {
        self.vaultHeightConstraint.constant = VAULTHEIGHT;
        self.vaultTopMarginConstraint.constant = VAULTTOPMARGIN;
        
        [self.vaultView layoutIfNeeded];
    }
    else if(!visible && self.vaultHeightConstraint.constant == VAULTHEIGHT)
    {
        self.vaultHeightConstraint.constant = 0;
        self.vaultTopMarginConstraint.constant = VAULTTOPMARGIN/2;
        
        [self.vaultView layoutIfNeeded];
        self.paymentMethodTextField.text = @"";
        self.customerIdTextField.text = @"";
    }
}

- (IBAction)segmentedTouched:(id)sender
{
    [self removeFocusFromTextField:nil];
    
    if([self.cardPresentSegmented selectedSegmentIndex] == VAULTINDEX)
    {
        [self toggleVaultInfo:true];
    }
    else
    {
        [self toggleVaultInfo:false];
    }
}

- (IBAction) startTransaction
{
    [self removeFocusFromTextField: nil];
    
    if([self.cardPresentSegmented selectedSegmentIndex] == YESINDEX && [self.swiper connectionState] != WPYSwiperConnected)
    {
        [self.swiper connectSwiperWithInputType:WPYSwiperInputTypeBluetooth];
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"The swiper has not yet connected to your device, please connect device and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if(!(self.amountTextField.text.doubleValue > 0))
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter a numeric amount greater than 0." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if([self.cardPresentSegmented selectedSegmentIndex] == VAULTINDEX)
    {
        NSString * message;
        
        if([self.customerIdTextField.text isEqualToString:@""])
        {
            message = @"Must enter customer id for vault payment.";
        }
        else if([self.paymentMethodTextField.text isEqualToString:@""])
        {
            message = @"Must enter payment id for vault payment.";
        }
        
        if(message != nil)
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alert animated:true completion:nil];
            
            return;
        }
    }
    
    WPYPaymentRequest * request;
    WPYEMVTransactionType transactionType = WPYEMVTransactionTypeGoods;
    
    switch([self.transactionTypeDropDown selectedIndex])
    {
        case AUTHORIZEINDEX:
            request = [WPYPaymentAuthorize new];
            break;
        case CHARGEINDEX:
            request = [WPYPaymentCharge new];
            break;
        case CREDITINDEX:
            request = [WPYPaymentCredit new];
            break;
        default:
            request = [WPYPaymentAuthorize new];
    }
    
    request.amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
    
    WPYExtendedCardData * extendedData = [[WPYExtendedCardData alloc] init];
    
    extendedData.addToVault = self.addToVaultSegmented.selectedSegmentIndex == YESINDEX;
    
    extendedData.notes = self.extendedInfoView.notes.text;
    
    if(![self.extendedInfoView.orderDate.text isEqualToString:@""] || ![self.extendedInfoView.purchaseOrder.text isEqualToString:@""])
    {
        WPYLevelTwoData * level2 = [[WPYLevelTwoData alloc] init];
        
        NSDate * date = nil;
        
        if(![self.extendedInfoView.orderDate.text isEqualToString:@""])
        {
            NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate error:nil];
            NSTextCheckingResult *result = [detector firstMatchInString:self.extendedInfoView.orderDate.text options:0 range:NSMakeRange(0, [self.extendedInfoView.orderDate.text length])];
            if (result != nil && [result resultType] == NSTextCheckingTypeDate) {
                date = [result date];
            }
            else
            {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"The order date entered could not be parsed, please use mm/dd/yyyy format." preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
                return;
            }
        
            level2.orderDate = date;
        }
        level2.purchaseOrderNumber = self.extendedInfoView.purchaseOrder.text;
        
        extendedData.levelTwoData = level2;
    }
    
    if(self.extendedInfoView.gratuityAmount.text.doubleValue > 0 || ![self.extendedInfoView.serverName.text  isEqualToString: @""])
    {
        WPYTenderServiceData * serviceData = [[WPYTenderServiceData alloc] init];
        
        serviceData.gratuityAmount = [NSDecimalNumber decimalNumberWithString:self.extendedInfoView.gratuityAmount.text];
        request.amount = [request.amount decimalNumberByAdding:serviceData.gratuityAmount];
        serviceData.server = self.extendedInfoView.serverName.text;
        
        extendedData.serviceData = serviceData;
    }
    
    request.extendedData = extendedData;
    
    if([self cashbackAllowed] && self.cashbackTextField.text.doubleValue > 0)
    {
        request.amountOther = [NSDecimalNumber decimalNumberWithString:self.cashbackTextField.text];
        transactionType = WPYEMVTransactionTypeCashback;
    }
    
    if([self.cardPresentSegmented selectedSegmentIndex] == NOINDEX)
    {
        WPYManualTenderEntryViewController *tenderViewController = [[WPYManualTenderEntryViewController alloc] initWithDelegate:self tenderType:WPYManualTenderTypeCredit request:request];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tenderViewController];
        
        navigationController.modalPresentationStyle = tenderViewController.modalPresentationStyle;
        navigationController.navigationBar.translucent = NO;
        navigationController.navigationBar.barStyle = UIBarStyleDefault;
        [self presentViewController:navigationController animated:YES completion:nil];
    }
    else if([self.cardPresentSegmented selectedSegmentIndex] == YESINDEX)
    {
        // Swiper transaction started
        [self startTransactionProgress];
        
        [self.swiper beginEMVTransactionWithRequest:request transactionType:WPYEMVTransactionTypeGoods];
    }
    else if([self.cardPresentSegmented selectedSegmentIndex] == VAULTINDEX)
    {
        WPYPaymentToken * token = [WPYPaymentToken new];
        
        token.customerId = self.customerIdTextField.text;
        token.token = self.paymentMethodTextField.text;
        
        request.token = token;
        
        switch([self.transactionTypeDropDown selectedIndex])
        {
            case AUTHORIZEINDEX:
            {
                [[WorldpayAPI instance] paymentAuthorize:(WPYPaymentAuthorize *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
                {
                    if(error)
                    {
                        NSLog(@"Error: %@",error);
                        
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Transaction failed with an error." preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                        
                        [self presentViewController:alert animated:true completion:nil];
                    }
                    else
                    {
                        [self swiper:self.swiper didFinishTransactionWithResponse:response];
                    }
                }];
                break;
            }
            case CHARGEINDEX:
            {
                [[WorldpayAPI instance] paymentCharge:(WPYPaymentCharge *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
                {
                    if(error)
                    {
                        NSLog(@"Error: %@",error);
                         
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Transaction failed with an error." preferredStyle:UIAlertControllerStyleAlert];
                         
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                         
                        [self presentViewController:alert animated:true completion:nil];
                    }
                    else
                    {
                        [self swiper:self.swiper didFinishTransactionWithResponse:response];
                    }
                }];
                break;
            }
            case CREDITINDEX:
            {
                [[WorldpayAPI instance] paymentCredit:(WPYPaymentCredit *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
                {
                    if(error)
                    {
                        NSLog(@"Error: %@",error);
                         
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Transaction failed with an error." preferredStyle:UIAlertControllerStyleAlert];
                         
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                         
                        [self presentViewController:alert animated:true completion:nil];
                    }
                    else
                    {
                        [self swiper:self.swiper didFinishTransactionWithResponse:response];
                    }
                }];
                break;
            }
            default:
            {
                [[WorldpayAPI instance] paymentAuthorize:(WPYPaymentAuthorize *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
                {
                    if(error)
                    {
                        NSLog(@"Error: %@",error);
                         
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Transaction failed with an error." preferredStyle:UIAlertControllerStyleAlert];
                         
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                         
                        [self presentViewController:alert animated:true completion:nil];
                    }
                    else
                    {
                        [self swiper:self.swiper didFinishTransactionWithResponse:response];
                    }
                }];
            }
        }
    }
}

- (BOOL) cashbackAllowed
{
#ifdef ANYWHERE_NOMAD
    switch([self.transactionTypeDropDown selectedIndex])
    {
        case AUTHORIZEINDEX:
        case CHARGEINDEX:
            return YES;
        case CREDITINDEX:
            return NO;
        default:
            return YES;
    }
#else
    return NO;
#endif
}

- (void) forceDisplayAlert: (UIAlertController *) alert
{
    if(self.swiperAlert.viewIfLoaded != nil)
    {
        [self dismissViewControllerAnimated:true completion:^
        {
            self.transition = YES;
            self.swiperAlert = alert;
            
            [self presentViewController:alert animated:true completion:^
            {
                [self cleanAlertUserAction:YES];
            }];
        }];
    }
    else
    {
        self.transition = YES;
        self.swiperAlert = alert;
        
        [self presentViewController:alert animated:true completion:^
        {
            [self cleanAlertUserAction:YES];
        }];
    }
}

- (void) displayAlert: (UIAlertController *) alert
{
    if(!self.transactionInProgress)
    {
        [self performSelector:@selector(forceDisplayAlert:) withObject:alert afterDelay:1];
        return;
    }
    
    if(self.transition)
    {
        [self performSelector:@selector(displayAlert:) withObject:alert afterDelay:.1];
    }
    else
    {
        if(self.swiperAlert.viewIfLoaded != nil)
        {
            [self dismissViewControllerAnimated:true completion:^
            {
                self.transition = YES;
                self.swiperAlert = alert;
                
                [self presentViewController:alert animated:true completion:^
                {
                    [self cleanAlertUserAction:NO];
                }];
            }];
        }
        else
        {
            self.transition = YES;
            self.swiperAlert = alert;
            
            [self presentViewController:alert animated:true completion:^
            {
                [self cleanAlertUserAction:NO];
            }];
        }
    }
}

- (void) cleanAlertUserAction: (BOOL) userAction
{
    self.transition = NO;
    
    if(userAction)
    {
        self.swiperAlert = nil;
    }
}

- (void) dismissSignature
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) captureSignature
{
    // TODO: Actually capture signature
    
    [self dismissViewControllerAnimated:YES completion:^
    {
        [self showTransactionDetails];
    }];
}

- (void) showTransactionDetails
{
    TransactionDetailViewController * detailController = [[TransactionDetailViewController alloc] initWithNibName:nil bundle:nil];
    
    detailController.transactionResponse = self.lastResponse;
    
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)  showSignatureScreen
{
    SignatureViewController * signatureVC = [[SignatureViewController alloc] initWithNibName:nil bundle:nil];
    
    UIBarButtonItem * cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(dismissSignature)];
    
    UIBarButtonItem * reset = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStyleDone target:signatureVC action:@selector(reset)];
    
    [signatureVC.navigationItem setLeftBarButtonItems:@[cancel,reset]];
    
    UIBarButtonItem * done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(captureSignature)];
    
    [signatureVC.navigationItem setRightBarButtonItem: done];
    
    LandscapeNavigationController * nav = [[LandscapeNavigationController alloc] initWithRootViewController:signatureVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (void) removeFocusFromTextField: (UITextField * __unused) textField
{
    if(self.activeTextField)
    {
        [self.activeTextField resignFirstResponder];
        self.activeTextField = nil;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self removeFocusFromTextField:textField];
    
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self removeFocusFromTextField:textField];
}

#pragma mark - WPYSwiperDelegate

- (void)didConnectSwiper:(WPYSwiper *)swiper
{
    NSLog(@"%@", @"Swiper connected");
}

- (void)didDisconnectSwiper:(WPYSwiper *)swiper
{
    NSLog(@"%@", @"Swiper disconnected");
}

- (void)didFailToConnectSwiper:(WPYSwiper *)swiper
{
    NSLog(@"%@", @"Swiper failed to connect");
}

- (void)willConnectSwiper:(WPYSwiper *)swiper
{
    NSLog(@"%@", @"Swiper will connect");
}

- (void)swiper:(WPYSwiper *)swiper didFailWithError:(NSString *)error
{
    NSLog(@"%@: %@", @"Swiper did fail with error", error);
    
    [self stopTransactionProgress];
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Swiper device failed with an error." preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cleanAlertUserAction:YES];
    }]];
    
    [self displayAlert:alert];
}

- (void)swiper:(WPYSwiper *)swiper didFinishTransactionWithResponse:(WPYPaymentResponse *)response
{
    NSLog(@"%@: %@", @"Swiper finished transaction with response", [response jsonDictionary]);
    
    [self stopTransactionProgress];
    
    UIAlertController * alert;
    
    NSString * responseMessage;
    
    UIAlertAction * secondaryAction;
    
    NSString *transactionStatus;
    
    BOOL approved = response.result == WPYTransactionResultApproved;
    
    NSString * signatureNeeded = @"";
    
    switch (response.resultCode)
    {
        case WPYTransactionResultApproved:
            transactionStatus = @"Approved";
            break;
        case WPYTransactionResultDeclined:
            transactionStatus = @"Declined";
            break;
        case WPYTransactionResultTerminated:
            transactionStatus = @"Terminated";
            break;
        case WPYTransactionResultCardBlocked:
            transactionStatus = @"Card Blocked";
            break;
        default:
            transactionStatus = @"Other - see logs";
            break;
    }
    
    if(response == nil)
    {
        responseMessage = [NSString stringWithFormat:@"Transaction Terminated: %ld", (long)response.result];
    }
    else
    {
        if(response.transaction != nil)
        {
            self.lastResponse = response.transaction;
            
            secondaryAction = [UIAlertAction actionWithTitle:@"View Details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                [self cleanAlertUserAction:YES];
                [self showTransactionDetails];
            }];
            
            responseMessage = response.transaction.responseText;
        }
        
        if(response.resultCode == WPYTransactionResultReversal)
        {
            // TODO: In demo, this result had its own message, wondering if response.transaction.responseText is fine?
            
            if([self.swiper swiperCanDisplayText])
            {
                [self.swiper displayText:@"Decline - Reversal"];
            }
        }
        
        if(approved && response.receiptData.cardHolderVerificationMethod == WPYCVMethodSignature)
        {
            signatureNeeded = @"This card requires a signature.";
            
            secondaryAction = [UIAlertAction actionWithTitle:@"Sign" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                [self cleanAlertUserAction:YES];
                [self showSignatureScreen];
            }];
        }
    }
    
    alert = [UIAlertController alertControllerWithTitle:@"Response" message:[NSString stringWithFormat:@"Status: %@\r\nResponse:%@\r\n%@", transactionStatus, responseMessage ?: @"No Message", signatureNeeded] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cleanAlertUserAction:YES];
    }]];
    
    if(secondaryAction)
    {
        [alert addAction:secondaryAction];
    }
    
    [self forceDisplayAlert:alert];
}

- (void)swiper:(WPYSwiper *)swiper didFailRequest:(WPYPaymentRequest *)request withError:(NSError *)error
{
    NSLog(@"%@: %@", @"Swiper failed request with error", error);
}

- (void) swiper:(WPYSwiper *)swiper didRequestSignatureWithCompletion:(void(^)(NSString *))completion
{
    NSLog(@"%@", @"Swiper requested signature");
    
    // TODO: Actually get signature
    
    if(completion)
    {
        completion(nil);
    }
}

- (void)swiper:(WPYSwiper *)swiper didRequestDevicePromptText:(WPYDevicePrompt)prompt completion:(void (^)(NSString *))completion
{
    if(!self.transactionInProgress)
    {
        return;
    }
    
    BOOL force = NO;
    
    UIAlertController * alert;
    
    NSString *defaultPrompt = nil;
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cleanAlertUserAction:YES];
    }];;
    
    switch (prompt)
    {
        case WPYDevicePromptInsertCard:
            defaultPrompt = @"Insert Card";
            break;
        case WPYDevicePromptInsertOrSwipe:
            defaultPrompt = @"Insert or Swipe Card";
            break;
        case WPYDevicePromptChipCardSwiped:
            defaultPrompt = @"Chip Card Detected\nPlease Insert Card";
            break;
        case WPYDevicePromptSwipeError:
#ifdef ANYWHERE_NOMAD
            defaultPrompt = @"Card Swipe Error Please Try Again";
#else
            defaultPrompt = @"Card Swipe Error\nPlease Try Again";
#endif
            break;
        case WPYDevicePromptConfirmAmount:
#ifdef ANYWHERE_NOMAD
            defaultPrompt = [NSString stringWithFormat:@"Confirm Total: %@", self.amountTextField.text];
#else
        {
            NSNumberFormatter *currencyFormatter = [NSNumberFormatter new];
            currencyFormatter.numberStyle = NSNumberFormatterDecimalStyle;
            NSNumber *number = [currencyFormatter numberFromString:self.amountTextField.text];
            currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
            defaultPrompt = [NSString stringWithFormat:@"Confirm Total: \n%@", [currencyFormatter stringFromNumber:number]];
        }
#endif
            break;
        case WPYDevicePromptNonICCard:
            defaultPrompt = @"Non IC Card Inserted";
            break;
        case WPYDevicePromptApproved:
            // Handled in response
            return;
        case WPYDevicePromptDeclined:
            // Handled in response
            return;
        case WPYDevicePromptCanceled:
            [self stopTransactionProgress];
            force = YES;
            defaultPrompt = @"Transaction Canceled\nPlease Remove Card";
            break;
        case WPYDevicePromptRetry:
#ifdef ANYWHERE_NOMAD
            defaultPrompt = @"Please remove and reinsert card";
#else
            defaultPrompt = @"Please remove and \nreinsert card";
#endif
            break;
        case WPYDevicePromptTransactionTimedOut:
            [self stopTransactionProgress];
            force = YES;
            defaultPrompt = @"Transaction Timed Out";
            break;
        case WPYDevicePromptNfcErrorCardInserted:
            defaultPrompt = @"Error. Card Inserted";
            break;
        case WPYDevicePromptNfcErrorCardSwiped:
            defaultPrompt = @"Error. Card Swipe Detected";
            break;
        case WPYDevicePromptNfcErrorUseICCard:
            defaultPrompt = @"Please Insert Card Instead";
            break;
        case WPYDevicePromptNfcErrorUseICCOrMSR:
            defaultPrompt = @"Please Swipe or Insert Card";
            break;
        case WPYDevicePromptNfcHardwareError:
            defaultPrompt = @"Contactless Hardware Error";
            break;
        case WPYDevicePromptEmvReaderError:
            defaultPrompt = @"IC Card Reader Error";
            break;
        case WPYDevicePromptEmvMSRFallback:
#ifdef ANYWHERE_NOMAD
            defaultPrompt = @"Card Not Supported Please swipe instead";
#else
            defaultPrompt = @"Card Not Supported\nPlease swipe instead";
#endif
            break;
        case WPYDevicePromptEmvInvalidCard:
#ifdef ANYWHERE_NOMAD
            defaultPrompt = @"Card Blocked. Use another card.";
#else
            defaultPrompt = @"Card Blocked\nUse another card";
#endif
            break;
        case WPYDevicePromptProcessing:
#ifdef ANYWHERE_NOMAD
            defaultPrompt = @"Processing. Do Not Remove Card.";
#else
            defaultPrompt = @"Processing. \nDo Not Remove Card.";
#endif
            break;
        case WPYDevicePromptEmvRemoveCard:
            defaultPrompt = @"Please Remove Card";
            break;
        case WPYDevicePromptTapCardAgain:
            defaultPrompt = @"Please Tap Card Again";
            break;
        case WPYDevicePromptReversal:
            [self stopTransactionProgress];
            force = YES;
            defaultPrompt = @"Transaction Declined - Reversal";
            break;
        case WPYDevicePromptCallBank:
            [self stopTransactionProgress];
            force = YES;
            defaultPrompt = @"Declined - Please Call Bank";
            break;
        case WPYDevicePromptNotAccepted:
            [self stopTransactionProgress];
            force = YES;
            defaultPrompt = @"Not Accepted";
            break;
        case WPYDevicePromptRemoveCard:
            defaultPrompt = @"Remove Card";
            break;
        case WPYDevicePromptMultipleCardsDetected:
            defaultPrompt = @"Multiple Cards Detected";
            break;
        case WPYDevicePromptTapCard:
            defaultPrompt = @"Tap Card";
            break;
        default:
            defaultPrompt = nil;
            break;
    }
    
    alert = [UIAlertController alertControllerWithTitle:@"Prompt" message:defaultPrompt preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction: action];
    
    if(force || self.transactionInProgress)
    {
        [self displayAlert:alert];
    }

    if(completion != nil)
    {
        completion(defaultPrompt);
    }
}

#pragma mark - WPYManualTenderEntryDelegate

- (void)manualTenderEntryControllerDidCancelRequest:(WPYManualTenderEntryViewController *)controller
{
    NSLog(@"%@", @"Manual entry cancelled");
}

- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didFailWithError:(NSError *)error
{
    NSLog(@"%@: %@", @"Manual entry failed with error", error);
    
    // Delay necessary to ensure manual entry controller is off screen
    [self performSelector:@selector(manualErrorAlert) withObject:nil afterDelay:.1];
}

- (void) manualErrorAlert
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Manual entry failed with an error" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cleanAlertUserAction:YES];
    }]];
    
    [self displayAlert:alert];
}

- (void)manualTenderEntryControllerIsProcessingRequest:(WPYManualTenderEntryViewController *)controller
{
    NSLog(@"%@", @"Manual entry request is being processed");
}

- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didFinishWithResponse:(WPYPaymentResponse *)tender
{
    NSLog(@"%@: %@", @"Manual entry request finished", tender);
    
    // Delay necessary to ensure manual entry controller is off screen
    [self performSelector:@selector(manualResponseAlert:) withObject:tender afterDelay:.1];
}

- (void) manualResponseAlert: (WPYPaymentResponse *) tender
{
    [self swiper:nil didFinishTransactionWithResponse:tender];
}

@end
