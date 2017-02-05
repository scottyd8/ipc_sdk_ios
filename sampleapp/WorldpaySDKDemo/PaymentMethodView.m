//
//  PaymentMethodView.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/29/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "PaymentMethodView.h"

#define CARDINDEX 0
#define CHECKINDEX 1

@interface PaymentMethodView ()

@property (nonatomic, strong) IBOutlet UIView * view;
@property (strong, nonatomic) WPYPaymentMethod * _paymentMethod;
@property (strong, nonatomic) WPYPaymentMethodRequest * _paymentRequest;
@property (assign, nonatomic) RESTMode mode;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIView *editDeleteButtonsView;
@property (weak, nonatomic) IBOutlet UIView *creditCardView;
@property (weak, nonatomic) IBOutlet UIView *checkView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editDeleteViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *creditCardViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *checkViewHeightConstraint;

@property (assign, nonatomic) CGFloat editDeleteButtonsViewOriginalWidth;
@property (assign, nonatomic) CGFloat creditCardViewOriginalHeight;
@property (assign, nonatomic) CGFloat checkViewOriginalHeight;

@property (copy, nonatomic) void (^editBlock) (WPYPaymentMethod * paymentMethod, void (^completion)(void));
@property (copy, nonatomic) void (^deleteBlock) (WPYPaymentMethod * paymentMethod, void (^completion)(void));
@property (copy, nonatomic) void (^textFieldFocusBlock) (void);

@end

@implementation PaymentMethodView

- (void) sharedInit
{
    [[NSBundle mainBundle] loadNibNamed:@"PaymentMethodView" owner:self options:nil];
    [self addSubview: self.view];
    
    [self.customerIdField setLabelText:@"Customer Id"];
    [self.paymentIdField setLabelText:@"Payment Id"];
    [self.cardTypeField setLabelText:@"Card Type"];
    [self.cardNumberField setLabelText:@"Card Number"];
    [self.cvvField setLabelText:@"CVV"];
    [self.expMonthField setLabelText:@"Expiration Date"];
    [self.pinBlockField setLabelText:@"Pin Block"];
    [self.checkTypeField setLabelText:@"Check Type"];
    [self.accountNumberField setLabelText:@"Account Number"];
    [self.routingNumberField setLabelText:@"Routing Number"];
    [self.checkNumberField setLabelText:@"Check Number"];
    
    [self.cardNumberField setKeyboardTypeDecimal];
    [self.cvvField setKeyboardTypeDecimal];
    [self.expMonthField setKeyboardTypeDecimal];
    [self.expYearField setKeyboardTypeDecimal];
    [self.pinBlockField setKeyboardTypeDecimal];
    
    [self.paymentTypeField setSegmentedTouchedBlock:^
    {
        [self removeFocusFromTextField:nil];
        
        [self togglePaymentType];
    }];
    
    [self.accountTypeField setSegmentedTouchedBlock:^
    {
        [self removeFocusFromTextField:nil];
    }];
    
    [self.cardTypeField setEditingCallback:^
    {
        [self removeFocusFromTextField:nil];
    }];
    
    [Helper styleButtonPrimary:self.editButton];
    [Helper styleButtonPrimary:self.deleteButton];
    
    self.editDeleteButtonsViewOriginalWidth = self.editDeleteViewWidthConstraint.constant;
    self.creditCardViewOriginalHeight = self.creditCardViewHeightConstraint.constant;
    self.checkViewOriginalHeight = self.checkViewHeightConstraint.constant;
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer1];
    
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.editDeleteButtonsView addGestureRecognizer:recognizer2];
    
    UITapGestureRecognizer *recognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.creditCardView addGestureRecognizer:recognizer3];
    
    UITapGestureRecognizer *recognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.checkView addGestureRecognizer:recognizer4];
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        [self sharedInit];
    }
    
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self sharedInit];
}

- (void) togglePaymentType
{
    if([self.paymentTypeField getSelectedIndex] == CARDINDEX)
    {
        [self setPaymentTypeCard];
    }
    else if([self.paymentTypeField getSelectedIndex] == CHECKINDEX)
    {
        [self setPaymentTypeCheck];
    }
}

- (void) setPaymentTypeCard
{
    self.checkViewHeightConstraint.constant = 0;
    self.creditCardViewHeightConstraint.constant = self.creditCardViewOriginalHeight;
    
    [self.view layoutIfNeeded];
}

- (void) setPaymentTypeCheck
{
    self.checkViewHeightConstraint.constant = self.checkViewOriginalHeight;
    self.creditCardViewHeightConstraint.constant = 0;
    
    [self.view layoutIfNeeded];
}

- (void) setEditDeleteViewVisible
{
    self.editDeleteViewWidthConstraint.constant = self.editDeleteButtonsViewOriginalWidth;
    
    [self.view layoutIfNeeded];
}

- (void) setEditDeleteViewHidden
{
    self.editDeleteViewWidthConstraint.constant = 0;
    
    [self.view layoutIfNeeded];
}

- (void) setParentViewController: (UIViewController<UITextFieldDelegate> *) controller
{
    // Must be called in viewDidLoad
    
    [self.paymentTypeField sharedInitWithOptionList:@[@"Card", @"Check"] initialIndex:0 parentViewController:controller title:@"Payment Type"];
    [self.cardTypeField sharedInitWithOptionList:@[@"Visa", @"Discover", @"MasterCard", @"American Express"] initialIndex:0 parentViewController:controller title:@"Card Type"];
    [self.accountTypeField sharedInitWithOptionList:@[@"Check", @"Savings"] initialIndex:0 parentViewController:controller title:@"Account Type"];
    
    [self.customerIdField setTextFieldDelegate:controller];
    [self.paymentIdField setTextFieldDelegate:controller];
    [self.cardNumberField setTextFieldDelegate:controller];
    [self.cvvField setTextFieldDelegate:controller];
    [self.expMonthField setTextFieldDelegate:controller];
    [self.expYearField setTextFieldDelegate:controller];
    [self.pinBlockField setTextFieldDelegate:controller];
    [self.checkTypeField setTextFieldDelegate:controller];
    [self.accountNumberField setTextFieldDelegate:controller];
    [self.routingNumberField setTextFieldDelegate:controller];
    [self.checkNumberField setTextFieldDelegate:controller];
}

- (void) setEditBlockCompletion:(void (^)(WPYPaymentMethod * paymentMethod, void (^completion)(void)))editBlock
{
    // Make sure completion is run in block when appropriate
    self.editBlock = editBlock;
}

- (void) setDeleteBlockCompletion:(void (^)(WPYPaymentMethod * paymentMethod, void (^completion)(void)))deleteBlock
{
    // Make sure completion is run in block when appropriate
    self.deleteBlock = deleteBlock;
}

- (void) setTextFocusBlock: (void (^) (void))textFocusBlock
{
    self.textFieldFocusBlock = textFocusBlock;
}

- (void) removeFocusFromTextField: (UITextField * __unused) textField
{
    if(self.textFieldFocusBlock)
    {
        self.textFieldFocusBlock();
    }
}

- (IBAction)edit:(id)sender
{
    [self removeFocusFromTextField:nil];
    
    [self disableButtons];
    
    if(self.editBlock)
    {
        self.editBlock(self._paymentMethod, ^
        {
            [self enableButtons];
        });
    }
}

- (IBAction)delete:(id)sender
{
    [self removeFocusFromTextField:nil];
    
    [self disableButtons];
    
    if(self.deleteBlock)
    {
        self.deleteBlock(self._paymentMethod, ^
        {
            [self enableButtons];
        });
    }
}

- (void) enableButtons
{
    [self.editButton setEnabled:true];
    [self.deleteButton setEnabled:true];
}

- (void) disableButtons
{
    [self.editButton setEnabled:false];
    [self.deleteButton setEnabled:false];
}

- (void) setRESTMode: (RESTMode) mode
{
    self.mode = mode;
    
    if(self.mode == RESTModeGet)
    {
        [self.customerIdField setDisplayMode];
        [self.paymentIdField setDisplayMode];
        [self.paymentTypeField setDisplayMode];
        [self.cardTypeField setDisplayMode];
        [self.cardNumberField setDisplayMode];
        [self.cvvField setDisplayMode];
        [self.expMonthField setDisplayMode];
        [self.expYearField setDisplayMode];
        [self.pinBlockField setDisplayMode];
        [self.accountTypeField setDisplayMode];
        [self.checkTypeField setDisplayMode];
        [self.accountNumberField setDisplayMode];
        [self.routingNumberField setDisplayMode];
        [self.checkNumberField setDisplayMode];
        
        [self setEditDeleteViewVisible];
    }
    else if(self.mode == RESTModeCreate)
    {
        [self.customerIdField setEditMode];
        [self.paymentIdField setEditMode];
        [self.paymentTypeField setEditMode];
        [self.cardTypeField setEditMode];
        [self.cardNumberField setEditMode];
        [self.cvvField setEditMode];
        [self.expMonthField setEditMode];
        [self.expYearField setEditMode];
        [self.pinBlockField setEditMode];
        [self.accountTypeField setEditMode];
        [self.checkTypeField setEditMode];
        [self.accountNumberField setEditMode];
        [self.routingNumberField setEditMode];
        [self.checkNumberField setEditMode];
        
        [self setEditDeleteViewHidden];
    }
    else if(self.mode == RESTModeEdit)
    {
        [self.customerIdField setDisplayMode];
        [self.paymentIdField setDisplayMode];
        [self.paymentTypeField setEditMode];
        [self.cardTypeField setEditMode];
        [self.cardNumberField setEditMode];
        [self.cvvField setEditMode];
        [self.expMonthField setEditMode];
        [self.expYearField setEditMode];
        [self.pinBlockField setEditMode];
        [self.accountTypeField setEditMode];
        [self.checkTypeField setEditMode];
        [self.accountNumberField setEditMode];
        [self.routingNumberField setEditMode];
        [self.checkNumberField setEditMode];
        
        [self setEditDeleteViewHidden];
    }
}

- (void)setAddPaymentCustomerId:(NSString *)customerId
{
    [self.customerIdField setFieldText:customerId];
    [self.customerIdField setDisplayMode];
}

- (WPYPaymentMethodRequest *) getPaymentMethodRequest
{
    [self syncPaymentMethodRequestToUI];
    
    return self._paymentRequest;
}

- (WPYPaymentMethod *) getPaymentMethod
{
    return self._paymentMethod;
}

- (void)setPaymentMethod:(WPYPaymentMethod *)paymentMethod
{
    if(self.mode == RESTModeEdit || self.mode == RESTModeCreate)
    {
        self._paymentMethod = paymentMethod;
        
        [self syncUIToPaymentMethod];
    }
}

- (void) syncUIToPaymentMethod
{
    // TODO: Fill in UI with payment method data
}

- (void) syncPaymentMethodRequestToUI
{
    // TODO: Fill in payment method request model with UI data
}

@end
