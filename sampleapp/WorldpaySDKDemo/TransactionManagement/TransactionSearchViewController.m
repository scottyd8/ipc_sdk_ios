//
//  TransactionSearchViewController.m
//  WorldpaySDKDemo
//
//  Created by Rakesh Ravva on 3/30/17.
//  Copyright © 2017 Worldpay. All rights reserved.
//

#import "TransactionSearchViewController.h"
#import "TransactionDetailViewController.h"
#import "BatchDetailTableViewController.h"
#import "LabeledTextField.h"
#import "Helper.h"
#import <WorldPaySDK_Miura/WPYTransactionSearch.h>


@interface TransactionSearchViewController () <UITextFieldDelegate>

@property (weak,nonatomic) IBOutlet LabeledTextField *startDateTextField;
@property (weak,nonatomic) IBOutlet LabeledTextField *endDateTextField;
@property (weak,nonatomic) IBOutlet LabeledTextField *transactionIdTextField;
@property (weak,nonatomic) IBOutlet LabeledTextField *amountTextField;
@property (weak,nonatomic) IBOutlet LabeledTextField *customerIdTextField;
@property (weak,nonatomic) IBOutlet LabeledTextField *orderIdTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchTransactionsButton;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (nonatomic, strong) NSDateFormatter *iso8601Formatter;
@property (nonatomic, strong) UIDatePicker *startDatePicker;
@property (nonatomic, strong) UIDatePicker *endDatePicker;
@property (weak, nonatomic) UITextField *activeTextField;

@end

@implementation TransactionSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [Helper styleButtonPrimary:_searchTransactionsButton];
    
    [_startDateTextField setLabelText:@"Start Date"];
    [self.startDateTextField setTextFieldDelegate:self];
    
    
    [_endDateTextField setLabelText:@"End Date"];
    [self.endDateTextField setTextFieldDelegate:self];

    [_transactionIdTextField setLabelText:@"Transaction Id"];
    [self.transactionIdTextField setTextFieldDelegate:self];
    
    [_amountTextField setLabelText:@"Amount"];
    [self.amountTextField setTextFieldDelegate:self];
    
    [_customerIdTextField setLabelText:@"Customer Id"];
    [self.customerIdTextField setTextFieldDelegate:self];
    
    [_orderIdTextField setLabelText:@"Order Id"];
    [self.orderIdTextField setTextFieldDelegate:self];
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer1];
    
    self.iso8601Formatter = [[NSDateFormatter alloc] init];
    self.iso8601Formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    self.iso8601Formatter.locale = posix;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(donePressed:)];
    toolBar.items = @[flexibleSpace, barButtonDone];
    
    self.startDatePicker = [[UIDatePicker alloc] init];
    
    self.startDatePicker.datePickerMode = UIDatePickerModeDate;
    self.startDatePicker.maximumDate = self.endDate != nil ? self.endDate : [NSDate date];
    self.startDatePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
    
    [self.startDatePicker addTarget:self action:@selector(onDatePickerStartValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _startDateTextField.textField.inputView = self.startDatePicker;
    self.startDateTextField.textField.delegate = self;
    self.startDateTextField.textField.inputAccessoryView = toolBar;
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(donePressed:)];
    toolBar.items = @[flexibleSpace, barButtonDone];
    
    self.endDatePicker = [[UIDatePicker alloc] init];
    
    self.endDatePicker.datePickerMode = UIDatePickerModeDate;
    self.endDatePicker.maximumDate = [NSDate date];
    self.endDatePicker.minimumDate = self.startDate != nil ? self.startDate : [NSDate dateWithTimeIntervalSince1970:0];
    
    [self.endDatePicker addTarget:self action:@selector(onDatePickerEndValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.endDateTextField.textField.inputView = self.endDatePicker;
    self.endDateTextField.textField.delegate = self;
    self.endDateTextField.textField.inputAccessoryView = toolBar;
    self.transactionIdTextField.textField.inputAccessoryView = toolBar;
    self.amountTextField.textField.inputAccessoryView = toolBar;
    self.customerIdTextField.textField.inputAccessoryView = toolBar;
    self.orderIdTextField.textField.inputAccessoryView = toolBar;

}

- (void)donePressed:(id)sender
{
    [self.view endEditing:YES];
}

- (void)onDatePickerStartValueChanged:(UIDatePicker *)datePicker
{
    self.startDate = datePicker.date;
    self.startDateTextField.textField.text = [self.iso8601Formatter stringFromDate:self.startDate];
    
    self.endDatePicker.minimumDate = self.startDate;
}

- (void)onDatePickerEndValueChanged:(UIDatePicker *)datePicker
{
    self.endDate = datePicker.date;
    self.endDateTextField.textField.text = [self.iso8601Formatter stringFromDate:self.endDate];
    
    self.startDatePicker.maximumDate = self.endDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchTransactionPressed:(id)sender {

    WPYTransactionSearch *search = [[WPYTransactionSearch alloc] init];
    
    search.startDate = self.startDate;
    search.endDate = self.endDate;
    search.customerId = (self.customerIdTextField.textField.text.length > 0 ? self.customerIdTextField.textField.text : nil);
    search.transactionId = (self.transactionIdTextField.textField.text.length > 0 ? self.transactionIdTextField.textField.text : nil);
    search.amount = (self.amountTextField.textField.text.length > 0 ? [NSDecimalNumber decimalNumberWithString:self.amountTextField.textField.text] : nil);
    search.orderId = (self.orderIdTextField.textField.text.length > 0 ? self.orderIdTextField.textField.text : nil);
    
    [[WorldPayAPI instance] searchTransactions:search withCompletion:^(WPYTransactionSearchResponse *transactionResponse, NSError *error) {
       
        
    if(error)
    {
        NSLog(@"%@",error);
    }
    
    [self handleResponse:transactionResponse withError:error];
    
    }];

}

- (void) handleResponse: (WPYTransactionSearchResponse *) response withError: (NSError *) error
{
    if(response.responseCode == WPYResponseCodeError || error != nil)
    {
        NSLog(@"%@", error);
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:[NSString stringWithFormat:@"An error occurred.%@", (response.responseMessage.length > 0? [NSString stringWithFormat:@"\n\nMessage: %@", response.responseMessage]: @"")] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        NSString *transactionStatus;
        NSString * responseMessage;
        UIAlertAction * secondaryAction;
        
        NSLog(@"Response: %@", [response jsonDictionary]);
        
        switch (response.responseCode)
        {
            case WPYResponseCodeApproved:
                transactionStatus = @"Approved";
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
        
        if(response != nil)
        {
            secondaryAction = [UIAlertAction actionWithTitle:@"View Details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                               {
                                   [self showTransactionList:response];
                               }];
            
            responseMessage = response.responseMessage;
        }
        
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Response" message:[NSString stringWithFormat:@"Result: %@\r\n Response Code: %@\r\n Message:%@\r\n",response.result, transactionStatus, responseMessage ?: @"No Message"] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        if(secondaryAction)
        {
            [alert addAction:secondaryAction];
        }
        
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void) showTransactionList:(WPYTransactionSearchResponse *) response
{
   
    BatchDetailTableViewController * batchDetailTableVC = [[BatchDetailTableViewController alloc] initWithTransactions:response.transactions batchId:nil];
    
    [self.navigationController pushViewController:batchDetailTableVC animated:true];
    
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
    
    if(textField == self.startDateTextField.textField)
    {
        [self onDatePickerStartValueChanged:self.startDatePicker];
    }
    else if(textField == self.endDateTextField.textField)
    {
        [self onDatePickerEndValueChanged:self.endDatePicker];
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
@end
