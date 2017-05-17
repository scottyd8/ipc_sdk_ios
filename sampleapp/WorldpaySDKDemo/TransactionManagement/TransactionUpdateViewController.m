//
//  TransactionUpdateViewController.m
//  WorldpaySDKDemo
//
//  Created by Rakesh Ravva on 3/31/17.
//  Copyright © 2017 Worldpay. All rights reserved.
//

#import "TransactionUpdateViewController.h"
#import "LabeledTextField.h"
#import "Helper.h"
#import <WorldPaySDK_Miura/WPYTransactionUpdate.h>
#import "BatchDetailTableViewController.h"
#import "TransactionDetailViewController.h"


@interface TransactionUpdateViewController ()<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet LabeledTextField *transactionIdTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *orderDateTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *dutyAmountTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *freightAmountTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *retailLaneNumberTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *taxAmountTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *taxStatusTextField;
@property (weak, nonatomic) IBOutlet LabeledTextField *purchaseOrderNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *updateTransactionButton;
@property (weak, nonatomic) UITextField *activeTextField;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *taxStatusPicker;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (strong , nonatomic) NSDate *orderDate;
@property (nonatomic, strong) NSNumber *taxStatusValue;
@property (strong, nonatomic) NSArray *nonScrollableTextFields;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation TransactionUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [Helper styleButtonPrimary:_updateTransactionButton];
    
    [_transactionIdTextField setLabelText:@"Transaction Id"];
    [self.transactionIdTextField setTextFieldDelegate:self];
    _transactionIdTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    [_orderDateTextField setLabelText:@"Order Date"];
    [self.orderDateTextField setTextFieldDelegate:self];
    
    [_dutyAmountTextField setLabelText:@"Duty Amount"];
    [self.dutyAmountTextField setTextFieldDelegate:self];
    _dutyAmountTextField.textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    [_freightAmountTextField setLabelText:@"Freight Amount"];
    [self.freightAmountTextField setTextFieldDelegate:self];
    _freightAmountTextField.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [_retailLaneNumberTextField setLabelText:@"Retail Lane Number"];
    [self.retailLaneNumberTextField setTextFieldDelegate:self];
    _retailLaneNumberTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    [_taxAmountTextField setLabelText:@"Tax Amount"];
    [self.taxAmountTextField setTextFieldDelegate:self];
    _taxAmountTextField.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [_taxStatusTextField setLabelText:@"Tax Status"];
    [self.taxStatusTextField setTextFieldDelegate:self];
    
    [_purchaseOrderNumberTextField setLabelText:@"Purchase Order Number"];
    [self.purchaseOrderNumberTextField setTextFieldDelegate:self];
    _purchaseOrderNumberTextField.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    CGSize scrollContentSize = CGSizeMake(620, 645);
    self.scrollView.contentSize = scrollContentSize;
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer1];

    self.taxStatusPicker = [[UIPickerView alloc] init];
    self.taxStatusPicker.delegate = self;
    self.taxStatusPicker.dataSource = self;
  
    _taxStatusTextField.textField.inputView = self.taxStatusPicker;
     _taxStatusTextField.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.nonScrollableTextFields = @[_transactionIdTextField.textField,_orderDateTextField.textField,_dutyAmountTextField.textField];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(donePressed:)];
    toolBar.items = @[flexibleSpace, barButtonDone];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"MM/dd/yyyy";
    
    self.datePicker = [[UIDatePicker alloc] init];
    
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.maximumDate = [NSDate date];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
    
    [self.datePicker addTarget:self action:@selector(onDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    _orderDateTextField.textField.inputView = self.datePicker;
    self.orderDateTextField.textField.delegate = self;
    self.orderDateTextField.textField.inputAccessoryView = toolBar;
    self.transactionIdTextField.textField.inputAccessoryView = toolBar;
    self.dutyAmountTextField.textField.inputAccessoryView = toolBar;
    self.freightAmountTextField.textField.inputAccessoryView = toolBar;
    self.retailLaneNumberTextField.textField.inputAccessoryView = toolBar;
    self.taxAmountTextField.textField.inputAccessoryView = toolBar;
    self.taxStatusTextField.textField.inputAccessoryView = toolBar;
    self.purchaseOrderNumberTextField.textField.inputAccessoryView = toolBar;

}
- (void)donePressed:(id)sender
{
    [self.view endEditing:YES];
}
- (void)onDatePickerValueChanged:(UIDatePicker *)datePicker
{
    self.orderDate = datePicker.date;
    self.orderDateTextField.textField.text = [self.dateFormatter stringFromDate:self.orderDate];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView == self.taxStatusPicker)
    {
        return 1;
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == self.taxStatusPicker)
    {
        return 3;
    }
    
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == self.taxStatusPicker)
    {
        switch (row)
        {
            case 0:
                return @"NOT_INCLUDED";
                break;
            case 1:
                return @"INCLUDED";
                break;
            case 2:
                return @"EXEMPT";
                break;
            default:
                break;
        }
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView == self.taxStatusPicker)
    {
        switch (row)
        {
            case 0:
                self.taxStatusTextField.textField.text = @"NOT_INCLUDED";
                break;
            case 1:
                self.taxStatusTextField.textField.text = @"INCLUDED";
                break;
            case 2:
                self.taxStatusTextField.textField.text = @"EXEMPT";
                break;
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateTransactionPressed:(id)sender {

    
    WPYTransactionUpdate *updateTransaction = [[WPYTransactionUpdate alloc] init];
    updateTransaction.levelTwoData = [[WPYLevelTwoData alloc]init];
    

    updateTransaction.transactionId = (self.transactionIdTextField.textField.text.length > 0 ? self.transactionIdTextField.textField.text : nil);
    updateTransaction.levelTwoData.orderDate = self.orderDate;
    if(![_dutyAmountTextField.textField.text isEqualToString:@""])
    {
        updateTransaction.levelTwoData.dutyAmount = [NSDecimalNumber decimalNumberWithString:self.dutyAmountTextField.textField.text];
    }
    if(![_freightAmountTextField.textField.text isEqualToString:@""])
    {
        updateTransaction.levelTwoData.freightAmount = [NSDecimalNumber decimalNumberWithString:self.freightAmountTextField.textField.text];
    }
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    if(![_retailLaneNumberTextField.textField.text isEqualToString:@""])
    {
        updateTransaction.levelTwoData.retailLaneNumber = [numberFormatter numberFromString:_retailLaneNumberTextField.textField.text];
    }
    if(![_taxAmountTextField.textField.text isEqualToString:@""])
    {
        updateTransaction.levelTwoData.taxAmount = [NSDecimalNumber decimalNumberWithString:self.taxAmountTextField.textField.text];
    }
    if(![_purchaseOrderNumberTextField.textField.text isEqualToString:@""])
    {
        updateTransaction.levelTwoData.purchaseOrder = self.purchaseOrderNumberTextField.textField.text;
    }
    
    updateTransaction.levelTwoData.status = _taxStatusValue;
    
    [[WorldpayAPI instance] updateTransaction:updateTransaction withCompletion:^(WPYTransactionResponse *transactionResponse, NSError *error) {
        
        if(error)
        {
            NSLog(@"%@",error);
        }
      
        [self handleResponse:transactionResponse withError:error];
    }];
}

//  Update transaction does not currently return updated response data, but data will update successfully. It is only necessary to provide data for fields you wish to change. These updates can be viewed in Virtual Terminal.

- (void) handleResponse: (WPYTransactionResponse *) response withError: (NSError *) error
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
        
        if(response.transaction != nil)
        {
            secondaryAction = [UIAlertAction actionWithTitle:@"View Details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                               {
                                   [self showTransactionDetails:response.transaction];
                               }];
            
            responseMessage = response.transaction.responseText;
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

- (void) showTransactionDetails:(WPYTransaction *) response
{
    TransactionDetailViewController * detailController = [[TransactionDetailViewController alloc] initWithNibName:nil bundle:nil];
    
    [detailController setTransactionResponse:response];
    
    [self.navigationController pushViewController:detailController animated:YES];
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
    if([textField.text isEqualToString:@"NOT_INCLUDED"])
    {
        _taxStatusValue = @(0);
    }
    else if([textField.text isEqualToString:@"INCLUDED"])
    {
        _taxStatusValue = @(1);
    }
    else if([textField.text isEqualToString:@"EXEMPT"])
    {
        _taxStatusValue = @(2);
    }
    
    if (textField == _orderDateTextField.textField)
    {
    [self onDatePickerValueChanged:self.datePicker];
    }
    if (textField == _taxStatusTextField.textField)
    {
        self.taxStatusTextField.textField.text = @"NOT_INCLUDED";
    }

    if(![_nonScrollableTextFields containsObject:textField])
    {
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y + _scrollView.contentInset.top);
    [_scrollView setContentOffset:scrollPoint animated:YES];
    
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self removeFocusFromTextField:textField];
    
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@"NOT_INCLUDED"])
    {
        _taxStatusValue = @(0);
    }
    else if([textField.text isEqualToString:@"INCLUDED"])
    {
        _taxStatusValue = @(1);
    }
    else if([textField.text isEqualToString:@"EXEMPT"])
    {
        _taxStatusValue = @(2);
    }
    
    if(![_nonScrollableTextFields containsObject:textField])
    {
        [self.scrollView setContentOffset:
         CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    }

[self removeFocusFromTextField:textField];

}



@end
