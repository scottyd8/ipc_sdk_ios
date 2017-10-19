//
//  TransactionViewController.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/4/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "TransactionViewController.h"
#import "DropDownTextField.h"
#import "ExtendableView.h"
#import "ExtendedInformationView.h"
#import "TransactionDetailViewController.h"
#import "SignatureViewController.h"
#import "LandscapeNavigationController.h"
#import "LabeledTextField.h"
#import "LabeledDropDownTextField.h"


#define YESINDEX 0
#define NOINDEX 1
#define VAULTINDEX 2

#define AUTHORIZEINDEX 0
#define CHARGEINDEX 1
#define CREDITINDEX 2

#define LABELTEXTSIZE 17
#define TEXTFIELDSIZE 14
#define BUTTONTEXTSIZE 15

#define MAGICMARGIN 48
#define VAULTHEIGHT 98
#define VAULTTOPMARGIN 8

@interface TransactionViewController ()

@property (weak, nonatomic) IBOutlet LabeledDropDownTextField *transactionTypeDropDown;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardPresentSegmented;
@property (weak, nonatomic) IBOutlet UISegmentedControl *addToVaultSegmented;
@property (weak, nonatomic) IBOutlet LabeledTextField *amountTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *customerIdTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *paymentMethodTextField;
@property (strong, nonatomic) WPYSwiper * swiper;
@property (weak, nonatomic) IBOutlet ExtendableView *extendableInfoView;
@property (weak, nonatomic) ExtendedInformationView * extendedInfoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *extendableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vaultHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vaultTopMarginConstraint;
@property (weak, nonatomic) IBOutlet UIView * vaultView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *formLabels;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *clearCardDataButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, atomic) UIAlertController * swiperAlert;
@property (weak, nonatomic) UITextField * activeTextField;
@property (strong, nonatomic) WPYTransaction * lastResponse;
@property (assign, atomic) BOOL transition;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *addToVaultConstraints;
@property (assign, atomic) BOOL transactionInProgress;
@property (assign, atomic) BOOL gratuityOnPed;
@property (strong, nonatomic) WPYPaymentRequest * currRequest;

@end

@implementation TransactionViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = @"Credit/Debit";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self toggleVaultInfo:false];
    
    if(![self.transactionTypeDropDown sharedInitWithOptionList:@[@"Authorize", @"Charge", @"Credit"] initialIndex:CHARGEINDEX parentViewController:self title:@"Transaction Type"])
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
    self.swiper = [[WorldPayAPI instance] swiperWithDelegate:self];
    
    [self.amountTextField setTextFieldDelegate:self];
    [self.amountTextField setKeyboardTypeDecimal];
    [self.amountTextField setLabelText:@"Amount"];
    [self.amountTextField setFieldText:@"10.00"];
    
    [self.paymentMethodTextField setTextFieldDelegate:self];
    [self.paymentMethodTextField setLabelText:@"Payment Id"];
    
    [self.customerIdTextField setTextFieldDelegate:self];
    [self.customerIdTextField setLabelText:@"Customer Id"];
    
    [self.transactionTypeDropDown setLabelText:@"Transaction Type"];
    
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
        else
        {
        
            self.extendedInfoView.gratuityAmount.text = @"0.00";
        
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
    
    [self.startButton.titleLabel setFont:[UIFont worldpayPrimaryWithSize: BUTTONTEXTSIZE]];
    
    for(UILabel * label in self.formLabels)
    {
        [label setFont:[UIFont worldpayPrimaryWithSize: LABELTEXTSIZE]];
    }
    
    [self.transactionTypeDropDown setEditingCallback:^
    {
        [self removeFocusFromTextField:nil];
    }];
    
    [Helper styleButtonPrimary:self.startButton];
    [Helper styleButtonPrimary:self.clearCardDataButton];
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
    self.currRequest = nil;
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
        self.vaultTopMarginConstraint.constant = 0;
        
        [self.vaultView layoutIfNeeded];
        [self.paymentMethodTextField setFieldText: @""];
        [self.customerIdTextField setFieldText: @""];
    }
}

- (IBAction)segmentedTouched:(id)sender
{
    [self removeFocusFromTextField:nil];

    if([self.cardPresentSegmented selectedSegmentIndex] == VAULTINDEX)
    {
        [self toggleVaultInfo:true];
        [self.extendedInfoView setMobileGrautity];
        
    }
    else if([self.cardPresentSegmented selectedSegmentIndex] == NOINDEX)
    {
        [self toggleVaultInfo:false];
        [self.extendedInfoView setMobileGrautity];
    }
    else if([self.cardPresentSegmented selectedSegmentIndex] == YESINDEX)
    {
        [self toggleVaultInfo:false];
        [self.extendedInfoView setTerminalGratuity];
    }
}
- (IBAction)clearCardDataButtonPressed:(id)sender {

    [self.swiper clearQuickChipTransaction];

}

- (IBAction) startTransaction
{
    [self removeFocusFromTextField: nil];
    
    CHECKAUTHTOKEN();
    
    // As we are using the terminal for manual card entry, we must check if the terminal is connected. Manual card entry through the mobile device does not require a connection to the terminal
    
    if(([self.cardPresentSegmented selectedSegmentIndex] == YESINDEX || [self.cardPresentSegmented selectedSegmentIndex] == NOINDEX) && [self.swiper connectionState] != WPYSwiperConnected)
    {
        [self.swiper connectSwiperWithInputType:WPYSwiperInputTypeBluetooth];
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"The swiper has not yet connected to your device, please connect device and try again." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSMutableCharacterSet* notDigits = [[[NSCharacterSet decimalDigitCharacterSet] invertedSet] mutableCopy];
    
    [notDigits removeCharactersInString:@"."];
    
    if(!([self.amountTextField.text rangeOfCharacterFromSet:notDigits].location == NSNotFound))
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter a numeric amount greater than 0." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if(self.extendedInfoView.gratuityAmount.text.length > 0 && !([self.extendedInfoView.gratuityAmount.text rangeOfCharacterFromSet:notDigits].location == NSNotFound))
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please enter a numeric gratuity amount greater than 0." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if([self.cardPresentSegmented selectedSegmentIndex] == VAULTINDEX)
    {
        NSString * message;
        
        if([self.customerIdTextField.text isEqualToString:@""])
        {
            message = @"Must enter Customer Id for Vault Payment.";
        }
        else if([self.paymentMethodTextField.text isEqualToString:@""])
        {
            message = @"Must enter Payment Id for Vault Payment.";
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
    
    self.currRequest = request;
    
    WPYEMVTransactionType transactionType;
    if ([self.extendedInfoView.cashbackSegmentedControl selectedSegmentIndex] == 0)
    {
        transactionType = WPYEMVTransactionTypeServices;
    }
    else
    {
        transactionType = WPYEMVTransactionTypeCashback;
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
        level2.purchaseOrder = self.extendedInfoView.purchaseOrder.text;
        
        extendedData.levelTwoData = level2;
    }
    
    if(self.extendedInfoView.gratuityAmount.text.doubleValue > 0 || ![self.extendedInfoView.serverName.text isEqualToString: @""])
    {
        WPYTenderServiceData * serviceData = [[WPYTenderServiceData alloc] init];
        
        if(self.extendedInfoView.gratuityAmount.text.doubleValue > 0)
        {
            serviceData.gratuityAmount = [NSDecimalNumber decimalNumberWithString:self.extendedInfoView.gratuityAmount.text];
        }
        
        serviceData.server = self.extendedInfoView.serverName.text;
        
        extendedData.serviceData = serviceData;
    }
    
    if(self.extendedInfoView.terminalGratuity.selectedSegmentIndex == 0)
    {
        self.gratuityOnPed = NO;
        request.extendedInformation.serviceData.gratuityAmount = [NSDecimalNumber decimalNumberWithString:self.extendedInfoView.gratuityAmount.text];
    }
    else
    {
        self.gratuityOnPed = YES;
    }
    
    request.extendedInformation = extendedData;
    
    if([self.cardPresentSegmented selectedSegmentIndex] == NOINDEX)
    {
//        // This method can be used if card data can not be entered over terminal
//        WPYManualTenderEntryViewController *tenderViewController = [[WPYManualTenderEntryViewController alloc] initWithDelegate:self tenderType:WPYManualTenderTypeCredit request:request];
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tenderViewController];
//        
//        navigationController.modalPresentationStyle = tenderViewController.modalPresentationStyle;
//        navigationController.navigationBar.translucent = NO;
//        navigationController.navigationBar.barStyle = UIBarStyleDefault;
//        [self presentViewController:navigationController animated:YES completion:nil];
        
        [self startTransactionProgress];
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"Enter card details on terminal" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self cleanAlertUserAction:YES];
        }]];
        
        [self displayAlert:alert];
        
        [self.swiper beginManualTransactionWithRequest:request];
    }
    else if([self.cardPresentSegmented selectedSegmentIndex] == YESINDEX)
    {
        // Swiper transaction started
        [self startTransactionProgress];
        [self.swiper beginEMVTransactionWithRequest:request transactionType:transactionType enableGratuityOnPed:self.gratuityOnPed commonDebitMode:USCommonDebitModePreferCommonDebit];
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
                [[WorldPayAPI instance] paymentAuthorize:(WPYPaymentAuthorize *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
                {
                    if(response.responseCode == WPYResponseCodeError || error)
                    {
                        NSLog(@"Error: %@",error);
                        
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"Transaction failed with an error.%@", (response.responseMessage.length > 0 ? [NSString stringWithFormat: @"\n\nMessage: %@", response.responseMessage] : @"")] preferredStyle:UIAlertControllerStyleAlert];
                        
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
                [[WorldPayAPI instance] paymentCharge:(WPYPaymentCharge *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
                {
                    if(response.responseCode == WPYResponseCodeError || error)
                    {
                        NSLog(@"Error: %@",error);
                        
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"Transaction failed with an error.%@", (response.responseMessage.length > 0 ? [NSString stringWithFormat: @"\n\nMessage: %@", response.responseMessage] : @"")] preferredStyle:UIAlertControllerStyleAlert];
                        
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
                [[WorldPayAPI instance] paymentCredit:(WPYPaymentCredit *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
                {
                    if(response.responseCode == WPYResponseCodeError || error)
                    {
                        NSLog(@"Error: %@",error);
                        
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"Transaction failed with an error.%@", (response.responseMessage.length > 0 ? [NSString stringWithFormat: @"\n\nMessage: %@", response.responseMessage] : @"")] preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                        
                        [self presentViewController:alert animated:true completion:nil];
                    }
                    {
                        [self swiper:self.swiper didFinishTransactionWithResponse:response];
                    }
                }];
                break;
            }
            default:
            {
                [[WorldPayAPI instance] paymentAuthorize:(WPYPaymentAuthorize *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
                {
                    if(response.responseCode == WPYResponseCodeError || error)
                    {
                        NSLog(@"Error: %@",error);
                        
                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"Transaction failed with an error.%@", (response.responseMessage.length > 0 ? [NSString stringWithFormat: @"\n\nMessage: %@", response.responseMessage] : @"")] preferredStyle:UIAlertControllerStyleAlert];
                        
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
    
    if(textField.keyboardType == UIKeyboardTypeDecimalPad)
    {
        textField.text = @"";
    }
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

- (void)swiper:(WPYSwiper *)swiper didReceiveCardEvent:(WPYCardEvent)eventType
{
    NSString * type;
    
    switch(eventType)
    {
        case WPYCardEventSwiped:
            type = @"swiped";
            break;
        case WPYCardEventInserted:
            type = @"inserted";
            break;
        case WPYCardEventRemoved:
            type = @"removed";
            break;
        case WPYCardEventNonICCInserted:
            type = @"non-icc inserted";
            break;
        case WPYCardEventBadSwipe:
            type = @"bad swipe";
            break;
        case WPYCardEventIccCardSwiped:
            type = @"icc swiped";
            break;
        default:
            break;
    }
    
    NSLog(@"Card event received: %@", type);
}

- (void)didConnectSwiper:(WPYSwiper *)swiper
{
    NSLog(@"%@", @"Swiper connected");
}

- (void)didDisconnectSwiper:(WPYSwiper *)swiper
{
    NSLog(@"%@", @"Swiper disconnected");
    
    if(self.transactionInProgress)
    {
        self.transactionInProgress = NO;
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Swiper device disconnected, transaction canceled." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self cleanAlertUserAction:YES];
        }]];
        
        [self displayAlert:alert];
    }
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
    
    BOOL approved = NO;
    
    NSString * signatureNeeded = @"";
    
    switch (response.responseCode)
    {
        case WPYResponseCodeApproved:
            transactionStatus = @"Approved";
            approved = YES;
            break;
        case WPYResponseCodeDeclined:
            transactionStatus = @"Declined";
            break;
        case WPYResponseCodeError:
            transactionStatus = @"Error";
            break;
        case WPYResponseCodeTransactionTerminated:
            transactionStatus = @"Terminated";
            break;
        case WPYResponseCodeReversal:
            transactionStatus = @"Decline - Reversal";
            break;
        default:
            transactionStatus = @"Other - see logs";
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
        
        if(response.responseCode == WPYResponseCodeReversal)
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
    
    alert = [UIAlertController alertControllerWithTitle:@"Response" message:[NSString stringWithFormat:@"Status: %@\r\n%@Message: %@\r\n%@", transactionStatus, (response.transaction.transactionIdentifier.integerValue > 0 ? [NSString stringWithFormat:@"Transaction Id: %@\r\n", response.transaction.transactionIdentifier]: @""),responseMessage ?: @"No Message", signatureNeeded] preferredStyle:UIAlertControllerStyleAlert];
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

- (void) swiper:(WPYSwiper *)swiper didRequestAccountTypeSelection:(NSArray<NSNumber *> *)accountTypes
{
    
}

- (void) swiper:(WPYSwiper *)swiper didRequestDevicePromptText:(WPYDevicePrompt)prompt defaultText:(NSString *) defaultText completion:(void (^)(NSString *))completion
{
    BOOL force = NO;
    
    UIAlertController * alert;
    
    NSString *defaultPrompt = nil;
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [self cleanAlertUserAction:YES];
    }];
    
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
            defaultPrompt = [NSString stringWithFormat:@"Confirm Total: %@", self.currRequest.amount.stringValue];
#else
        {
//            NSNumberFormatter *currencyFormatter = [NSNumberFormatter new];
//            currencyFormatter.numberStyle = NSNumberFormatterDecimalStyle;
//            NSNumber *number = [currencyFormatter numberFromString:self.currRequest.amount.stringValue];
//            currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
//            defaultPrompt = [NSString stringWithFormat:@"Confirm Total: \n%@", [currencyFormatter stringFromNumber:number]];
            defaultPrompt = nil;
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
            
            if([self.swiper cardInserted])
            {
                defaultPrompt = @"Transaction Canceled\nPlease Remove Card";
            }
            else
            {
                defaultPrompt = @"Transaction Canceled";
            }
            
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
            defaultPrompt = defaultText;
            break;
    }
    
    alert = [UIAlertController alertControllerWithTitle:@"Prompt" message:defaultPrompt preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction: action];
    
    if(completion != nil)
    {
        completion(defaultPrompt);
    }
    
    if(force || self.transactionInProgress)
    {
        [self displayAlert:alert];
    }
}

#pragma mark - WPYManualTenderEntryDelegate

- (void)manualTenderEntryControllerDidCancelRequest:(WPYManualTenderEntryViewController *)controller
{
    NSLog(@"%@", @"Manual entry canceled");
}

- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didFailWithError:(NSError *)error
{
    NSLog(@"%@: %@", @"Manual entry failed with error", error);
    
    // Delay necessary to ensure manual entry controller is off screen
    [self performSelector:@selector(manualErrorAlert:) withObject:error.localizedDescription afterDelay:.1];
}

- (void) manualErrorAlert: (NSString *) errorMessage
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"Manual entry failed with an error%@", (errorMessage.length > 0 ? [NSString stringWithFormat:@": %@", errorMessage] : @"")] preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
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

- (void)manualTenderEntryController:(WPYManualTenderEntryViewController *)controller didReceivePaymentMethod:(WPYPaymentMethod *)method withError:(NSError *)error
{
    NSLog(@"%@: %@", @"Manual entry received payment method", method.identifier);
    
    if(!method || error)
    {
    
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat: @"Manual entry failed to create payment method%@", (error ? [NSString stringWithFormat:@"with an error: %@", [error localizedDescription]] : @"")] preferredStyle:UIAlertControllerStyleAlert];
    
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            [self cleanAlertUserAction:YES];
        }]];
    
        [self displayAlert:alert];
    }
    else
    {
        // Do something with payment method
    }
}

@end
