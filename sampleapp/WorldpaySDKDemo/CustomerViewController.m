//
//  CustomerViewController.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/13/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "CustomerViewController.h"

#import "LabeledTextField.h"
#import "LabeledSegmentedControl.h"
#import "LabeledTextView.h"
#import "CustomerPaymentDetailViewController.h"

#define YESINDEX 0
#define NOINDEX 1

@interface CustomerViewController ()

@property (nonatomic, assign) RESTMode mode;
@property (nonatomic, strong) WPYCustomerRequestData * customer;
@property (nonatomic, strong) WPYCustomerResponseData * editCustomer;
@property (weak, nonatomic) UITextField * activeTextField;
@property (weak, nonatomic) UITextView * activeTextView;
@property (weak, nonatomic) IBOutlet UIScrollView * scrollView;
@property (nonatomic, weak) IBOutlet UIButton * submitButton;
@property (nonatomic, weak) IBOutlet UIButton * cancelButton;
@property (nonatomic, weak) IBOutlet LabeledTextField * customerIdField;
@property (nonatomic, weak) IBOutlet LabeledTextField * firstNameField;
@property (nonatomic, weak) IBOutlet LabeledTextField * lastNameField;
@property (nonatomic, weak) IBOutlet LabeledTextField * phoneField;
@property (nonatomic, weak) IBOutlet LabeledTextField * emailIdField;
@property (nonatomic, weak) IBOutlet LabeledSegmentedControl * sendEmailReceiptsField;
@property (nonatomic, weak) IBOutlet LabeledTextView * notesField;
@property (nonatomic, weak) IBOutlet LabeledTextField * streetAddressField;
@property (nonatomic, weak) IBOutlet LabeledTextField * cityField;
@property (nonatomic, weak) IBOutlet LabeledTextField * stateField;
@property (nonatomic, weak) IBOutlet LabeledTextField * countryField;
@property (nonatomic, weak) IBOutlet LabeledTextField * zipField;
@property (nonatomic, weak) IBOutlet LabeledTextField * companyField;
@property (nonatomic, weak) IBOutlet LabeledTextField * udfValueField1;
@property (nonatomic, weak) IBOutlet LabeledTextField * udfValueField2;
@property (nonatomic, weak) IBOutlet LabeledTextField * udfValueField3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *detailsButtonsHeightConstraint;
@property (assign, nonatomic) CGFloat originalDetailsHeightConstant;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *detailButtonsView;

@end

@implementation CustomerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.customer = [[WPYCustomerRequestData alloc] init];
    
    [Helper styleButtonPrimary:self.submitButton];
    [Helper styleButtonPrimary:self.cancelButton];
    [Helper styleButtonPrimary:self.editButton];
    [Helper styleButtonPrimary:self.deleteButton];
    
    self.originalDetailsHeightConstant = self.detailsButtonsHeightConstraint.constant;

    if(self.mode == RESTModeCreate)
    {
        self.title = @"Create Customer";
        [self.submitButton setTitle:@"Create" forState:UIControlStateNormal];
        [self.submitButton addTarget:self action:@selector(createCustomer) forControlEvents:UIControlEventTouchUpInside];
        [self.customerIdField setEnabled:true];
        self.detailsButtonsHeightConstraint.constant = 0;
        [self.detailButtonsView layoutIfNeeded];
    }
    else if(self.mode == RESTModeEdit)
    {
        self.title = @"Edit Customer";
        [self syncUIToCustomer];
        [self.submitButton setTitle:@"Save" forState:UIControlStateNormal];
        [self.submitButton addTarget:self action:@selector(saveCustomer) forControlEvents:UIControlEventTouchUpInside];
        [self.customerIdField setEnabled:false];
        [self.udfValueField1 setEnabled:false];
        [self.udfValueField2 setEnabled:false];
        [self.udfValueField3 setEnabled:false];
        self.detailsButtonsHeightConstraint.constant = 0;
        [self.detailButtonsView layoutIfNeeded];
    }
    else if(self.mode == RESTModeGet)
    {
        self.title = @"Customer Details";
        [self syncUIToCustomer];
        [self.submitButton setTitle:@"Payment Methods" forState:UIControlStateNormal];
        [self.submitButton addTarget:self action:@selector(paymentMethods) forControlEvents:UIControlEventTouchUpInside];
        [self.customerIdField setDisplayMode];
        [self.firstNameField setDisplayMode];
        [self.lastNameField setDisplayMode];
        [self.phoneField setDisplayMode];
        [self.emailIdField setDisplayMode];
        [self.sendEmailReceiptsField setDisplayMode];
        [self.notesField setDisplayMode];
        [self.streetAddressField setDisplayMode];
        [self.cityField setDisplayMode];
        [self.stateField setDisplayMode];
        [self.zipField setDisplayMode];
        [self.countryField setDisplayMode];
        [self.companyField setDisplayMode];
        [self.udfValueField1 setDisplayMode];
        [self.udfValueField2 setDisplayMode];
        [self.udfValueField3 setDisplayMode];
    }
    
    [self.customerIdField setLabelText:@"Customer Id"];
    [self.customerIdField setTextFieldDelegate:self];
    
    [self.firstNameField setLabelText:@"First Name"];
    [self.firstNameField setTextFieldDelegate:self];
    
    [self.lastNameField setLabelText:@"Last Name"];
    [self.lastNameField setTextFieldDelegate:self];
    
    [self.phoneField setLabelText:@"Phone Number"];
    [self.phoneField setTextFieldDelegate:self];
    
    [self.emailIdField setLabelText:@"E-Mail Address"];
    [self.emailIdField setTextFieldDelegate:self];
    
    [self.sendEmailReceiptsField sharedInitWithOptionList:@[@"Yes", @"No"] initialIndex:0 parentViewController:self title:@"Send E-Mail Receipts"];
    [self.sendEmailReceiptsField setSegmentedTouchedBlock:^
    {
        [self removeFocusFromTextField:nil];
    }];
    
    [self.notesField setLabelText:@"Notes"];
    [self.notesField setTextViewDelegate:self];
    
    [self.streetAddressField setLabelText:@"Street Address"];
    [self.streetAddressField setTextFieldDelegate:self];
    
    [self.cityField setLabelText:@"City"];
    [self.cityField setTextFieldDelegate:self];
    
    [self.stateField setLabelText:@"State"];
    [self.stateField setTextFieldDelegate:self];
    
    [self.zipField setLabelText:@"Zip"];
    [self.zipField setTextFieldDelegate:self];
    
    [self.countryField setLabelText:@"Country"];
    [self.countryField setTextFieldDelegate:self];
    
    [self.companyField setLabelText:@"Company"];
    [self.companyField setTextFieldDelegate:self];
    
    [self.udfValueField1 setLabelText:@"User Defined Field #1"];
    [self.udfValueField1 setTextFieldDelegate:self];
    
    [self.udfValueField2 setLabelText:@"User Defined Field #2"];
    [self.udfValueField2 setTextFieldDelegate:self];
    
    [self.udfValueField3 setLabelText:@"User Defined Field #3"];
    [self.udfValueField3 setTextFieldDelegate:self];
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.scrollView addGestureRecognizer:recognizer1];
    
    UITapGestureRecognizer *recognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer2 setNumberOfTapsRequired:1];
    [recognizer2 setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer2];
    
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self enableButtons];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setRESTMode: (RESTMode) mode
{
    self.mode = mode;
}

- (BOOL) setEditableCustomer: (WPYCustomerResponseData *) customer
{
    if(self.mode == RESTModeEdit || self.mode == RESTModeGet)
    {
        self.editCustomer = customer;
        
        return true;
    }
    
    return false;
}

- (void) syncUIToCustomer
{
    // This is only called in get/edit mode
    
    [self.customerIdField setFieldText:self.editCustomer.identifier];
    [self.firstNameField setFieldText:self.editCustomer.firstName];
    [self.lastNameField setFieldText:self.editCustomer.lastName];
    [self.phoneField setFieldText:self.editCustomer.phoneNumber];
    [self.emailIdField setFieldText:self.editCustomer.email];
    [self.sendEmailReceiptsField setSelectedIndex:(self.editCustomer.sendEmailReceipts ? YESINDEX : NOINDEX)];
    [self.notesField setFieldText:self.editCustomer.notes];
    [self.streetAddressField setFieldText:self.editCustomer.address.line1];
    [self.cityField setFieldText:self.editCustomer.address.city];
    [self.stateField setFieldText:self.editCustomer.address.state];
    [self.zipField setFieldText:self.editCustomer.address.zip];
    [self.companyField setFieldText:self.editCustomer.company];
    self.customer.userDefinedFields = self.editCustomer.userDefinedFields;
    
    // Note that if user has more than 3 fields, the remaining will not be shown here
    NSUInteger udfCount = self.editCustomer.userDefinedFields.count;
    
    if(udfCount > 0)
    {
        [self.udfValueField1 setFieldText:self.editCustomer.userDefinedFields[@"UDF1"]];
    }
    
    if(udfCount > 1)
    {
        [self.udfValueField2 setFieldText:self.editCustomer.userDefinedFields[@"UDF2"]];
    }
    
    if(udfCount > 2)
    {
        [self.udfValueField3 setFieldText:self.editCustomer.userDefinedFields[@"UDF3"]];
    }
}

- (void) syncCustomerToUI
{
    if(self.mode == RESTModeCreate)
    {
        // TODO: Customer ID cannot be set for create because of SDK limitation
        // self.customer.identifier = self.customerIdField.text;
    }
    
    self.customer.firstName = self.firstNameField.text;
    self.customer.lastName = self.lastNameField.text;
    self.customer.phoneNumber = self.phoneField.text;
    self.customer.email = self.emailIdField.text;
    self.customer.sendEmailReceipts = ([self.sendEmailReceiptsField getSelectedIndex] == YESINDEX ? true : false);
    self.customer.notes = self.notesField.text;
    
    if(!self.customer.address)
    {
        self.customer.address = [[WPYAddressInfo alloc] init];
    }
    
    self.customer.address.line1 = self.streetAddressField.text;
    self.customer.address.city = self.cityField.text;
    self.customer.address.state = self.stateField.text;
    self.customer.address.zip = self.zipField.text;
    self.customer.address.phone = self.phoneField.text;
    self.customer.address.country = self.countryField.text;
    self.customer.address.company = self.companyField.text;
    self.customer.company = self.companyField.text;
        
    NSMutableDictionary * mutableUDF = [NSMutableDictionary dictionary];
    
    if(self.udfValueField1.text.length > 0)
    {
        mutableUDF[@"udf1"] = self.udfValueField1.text;
    }
    
    if(self.udfValueField2.text.length > 0)
    {
        mutableUDF[@"udf2"] = self.udfValueField2.text;
    }
    
    if(self.udfValueField3.text.length > 0)
    {
        mutableUDF[@"udf3"] = self.udfValueField3.text;
    }
    
    if(mutableUDF.count > 0)
    {
        self.customer.userDefinedFields = [NSDictionary dictionaryWithDictionary:mutableUDF];
    }
}

- (void) createCustomer
{
    [self removeFocusFromTextField:nil];
    
    CHECKAUTHTOKEN();
    
    [self disableButtons];
    
    [self syncCustomerToUI];
    
    [[WorldpayAPI instance] createCustomer:self.customer withCompletion:^(WPYCustomerResponseData * response, NSError * error)
    {
        [self handleResponse:response error:error];
    }];
}

- (void) saveCustomer
{
    [self removeFocusFromTextField:nil];
    
    CHECKAUTHTOKEN();
    
    [self disableButtons];
    
    [self syncCustomerToUI];
    
    [[WorldpayAPI instance] updateCustomer:self.editCustomer.identifier withData:self.customer andCompletion:^(WPYCustomerResponseData * response, NSError * error)
    {
        [self handleResponse:response error:error];
    }];
}

- (void) paymentMethods
{
    [self disableButtons];
    
    CustomerPaymentDetailViewController * paymentDetailVC = [[CustomerPaymentDetailViewController alloc] initWithPaymentMethods:self.editCustomer.paymentMethods];
    
    [self.navigationController pushViewController:paymentDetailVC animated:true];
}

- (void) switchToGet: (WPYCustomerResponseData *) customer
{
    self.mode = RESTModeGet;
    
    [self setEditableCustomer:customer];
    
    self.title = @"Customer Details";
    [self syncUIToCustomer];
    [self.submitButton setTitle:@"Payment Methods" forState:UIControlStateNormal];
    [self.submitButton removeTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    [self.submitButton addTarget:self action:@selector(paymentMethods) forControlEvents:UIControlEventTouchUpInside];
    [self.customerIdField setDisplayMode];
    [self.firstNameField setDisplayMode];
    [self.lastNameField setDisplayMode];
    [self.phoneField setDisplayMode];
    [self.emailIdField setDisplayMode];
    [self.sendEmailReceiptsField setDisplayMode];
    [self.notesField setDisplayMode];
    [self.streetAddressField setDisplayMode];
    [self.cityField setDisplayMode];
    [self.stateField setDisplayMode];
    [self.zipField setDisplayMode];
    [self.countryField setDisplayMode];
    [self.companyField setDisplayMode];
    [self.udfValueField1 setDisplayMode];
    [self.udfValueField2 setDisplayMode];
    [self.udfValueField3 setDisplayMode];
    
    self.detailsButtonsHeightConstraint.constant = self.originalDetailsHeightConstant;
    [self.detailButtonsView layoutIfNeeded];
}

- (IBAction) switchToEdit:(id)sender
{
    self.mode = RESTModeEdit;
    
    [self.customerIdField setEditMode];
    [self.firstNameField setEditMode];
    [self.lastNameField setEditMode];
    [self.phoneField setEditMode];
    [self.emailIdField setEditMode];
    [self.sendEmailReceiptsField setEditMode];
    [self.notesField setEditMode];
    [self.streetAddressField setEditMode];
    [self.cityField setEditMode];
    [self.stateField setEditMode];
    [self.zipField setEditMode];
    [self.countryField setEditMode];
    [self.companyField setEditMode];
    [self.udfValueField1 setEditMode];
    [self.udfValueField2 setEditMode];
    [self.udfValueField3 setEditMode];
    
    [self.customerIdField setEnabled:false];
    
    self.title = @"Edit Customer";
    [self.submitButton setTitle:@"Save" forState:UIControlStateNormal];
    [self.submitButton removeTarget:self action:nil forControlEvents:UIControlEventAllEvents];
    [self.submitButton addTarget:self action:@selector(saveCustomer) forControlEvents:UIControlEventTouchUpInside];
    self.detailsButtonsHeightConstraint.constant = 0;
    [self.detailButtonsView layoutIfNeeded];
}

- (IBAction) deleteCustomer:(id)sender
{
    // TODO: SDK does not yet have this functionality
    
//    CHECKAUTHTOKEN();
//    
//    [self disableButtons];
}

- (void) handleResponse: (WPYCustomerResponseData *) response error: (NSError *) error
{
    if(![self handleError:error response:response])
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Response" message:[NSString stringWithFormat:@"Customer '%@' was successfully %@", response.identifier, (self.mode == RESTModeCreate ? @"created" : @"saved")] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"View Details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            [self switchToGet:response];
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        
        [self enableButtons];
    }
}

- (BOOL) handleError: (NSError *) error response: (WPYCustomerResponseData *) response
{
    if(error || response.responseCode == WPYResponseCodeError || response.success == false)
    {
        [self enableButtons];
        
        NSLog(@"Error: %@",error);
        NSLog(@"Response: %@", [response jsonDictionary]);
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"%@ customer failed with an error.%@", (self.mode == RESTModeCreate ? @"Create" : @"Save"),(response.responseMessage.length > 0 ? [NSString stringWithFormat: @"\n\nMessage: %@", response.responseMessage] : @"")] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
        
        return true;
    }
    
    return false;
}

- (void) enableButtons
{
    [self.submitButton setEnabled:true];
    [self.cancelButton setEnabled:true];
    [self.editButton setEnabled:true];
    [self.deleteButton setEnabled:true];
}

- (void) disableButtons
{
    [self.submitButton setEnabled:false];
    [self.cancelButton setEnabled:false];
    [self.editButton setEnabled:false];
    [self.deleteButton setEnabled:false];
}

- (IBAction) cancel:(id)sender
{
    [self removeFocusFromTextField:nil];
    
    [self disableButtons];
    
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - UITextFieldDelegate

- (void) removeFocusFromTextField: (UITextField * __unused) textField
{
    if(self.activeTextField)
    {
        [self.activeTextField resignFirstResponder];
        self.activeTextField = nil;
    }
    else if(self.activeTextView)
    {
        [self.activeTextView resignFirstResponder];
        self.activeTextView = nil;
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.activeTextView = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self removeFocusFromTextField:nil];
}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    
    UIView * activeView = (self.activeTextField ?: self.activeTextView);
    
    if (activeView && !CGRectContainsPoint(aRect, activeView.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeView.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0, 0.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

@end
