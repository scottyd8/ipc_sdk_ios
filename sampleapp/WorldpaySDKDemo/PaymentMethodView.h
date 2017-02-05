//
//  PaymentMethodView.h
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/29/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LabeledTextField.h"
#import "LabeledDropDownTextField.h"
#import "LabeledSegmentedControl.h"

@interface PaymentMethodView : UIView

@property (weak, nonatomic) IBOutlet LabeledTextField *customerIdField;
@property (weak, nonatomic) IBOutlet LabeledTextField *paymentIdField;
@property (weak, nonatomic) IBOutlet LabeledSegmentedControl *paymentTypeField;
@property (weak, nonatomic) IBOutlet LabeledDropDownTextField *cardTypeField;
@property (weak, nonatomic) IBOutlet LabeledTextField *cardNumberField;
@property (weak, nonatomic) IBOutlet LabeledTextField *cvvField;
@property (weak, nonatomic) IBOutlet LabeledTextField *expMonthField;
@property (weak, nonatomic) IBOutlet LabeledTextField *expYearField;
@property (weak, nonatomic) IBOutlet LabeledTextField *pinBlockField;
@property (weak, nonatomic) IBOutlet LabeledSegmentedControl *accountTypeField;
@property (weak, nonatomic) IBOutlet LabeledTextField *checkTypeField;
@property (weak, nonatomic) IBOutlet LabeledTextField *accountNumberField;
@property (weak, nonatomic) IBOutlet LabeledTextField *routingNumberField;
@property (weak, nonatomic) IBOutlet LabeledTextField *checkNumberField;


- (instancetype) initWithFrame:(CGRect)frame;

- (void) setParentViewController: (UIViewController<UITextFieldDelegate> *) controller;
- (void) setEditBlockCompletion:(void (^)(WPYPaymentMethod * paymentMethod, void (^completion)(void)))editBlock;
- (void) setDeleteBlockCompletion:(void (^)(WPYPaymentMethod * paymentMethod, void (^completion)(void)))deleteBlock;
- (void) setTextFocusBlock: (void (^) (void))textFocusBlock;
- (void) setRESTMode: (RESTMode) mode;
- (WPYPaymentMethodRequest *) getPaymentMethod;
- (void) setPaymentMethod: (WPYPaymentMethod *) paymentMethod;
- (void) setAddPaymentCustomerId: (NSString *) customerId;

@end
