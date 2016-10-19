//
//  VoidRefundViewController.m
//  WorldPaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/11/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "VoidRefundViewController.h"
#import "DropDownTextField.h"
#import "UIColor+WorldPay.h"
#import "TransactionDetailViewController.h"

#define VOIDINDEX 0
#define REFUNDINDEX 1

@interface VoidRefundViewController ()

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (weak, nonatomic) IBOutlet DropDownTextField *transactionTypeDropDown;
@property (weak, nonatomic) IBOutlet UITextField *transactionIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) UITextField *activeTextField;

@end

@implementation VoidRefundViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = @"Void/Refund";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(![self.transactionTypeDropDown sharedInitWithOptionList:@[@"Void", @"Refund"] initialIndex:0 parentViewController:self title:@"Transaction Type"])
    {
        NSAssert(FALSE, @"%@", @"Drop down failed to initialized properly");
    }
    
    for(UITextField * textField in self.textFields)
    {
        textField.delegate = self;
    }
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer1];
    
    [self.transactionTypeDropDown setSelectionCallback:^(NSUInteger __unused index)
    {
        [self removeFocusFromTextField:nil];
    }];
    
    self.startButton.backgroundColor = [UIColor worldpayEmerald];
    [self.startButton setTitleColor:[UIColor worldpayWhite] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTransaction:(id)sender
{
    BOOL includeAmount = false;
    
    if([self.transactionIdTextField.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Transaction Id is required." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        return;
    }
    
    if(![self.amountTextField.text isEqualToString:@""] && !(self.amountTextField.text.doubleValue > 0))
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Amount must be a positive number." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        return;
    }
    else if(![self.amountTextField.text isEqualToString:@""])
    {
        includeAmount = true;
    }
    
    WPYDomainObject * request;
    
    if([self.transactionTypeDropDown selectedIndex] == VOIDINDEX)
    {
        request = [WPYPaymentVoid new];
        
        if(includeAmount)
        {
            ((WPYPaymentVoid *)request).amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
        }
        
        ((WPYPaymentVoid *)request).transactionId = self.transactionIdTextField.text;
        
        [[WorldpayAPI instance] paymentVoid:(WPYPaymentVoid *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
        {
            [self handleResponse:response withError:error];
        }];
    }
    else
    {
        request = [WPYPaymentRefund new];
        
        if(includeAmount)
        {
            ((WPYPaymentRefund *)request).amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
        }
        
        ((WPYPaymentRefund *)request).transactionId = self.transactionIdTextField.text;
        
        [[WorldpayAPI instance] paymentRefund:(WPYPaymentRefund *)request withCompletion:^(WPYPaymentResponse * response, NSError * error)
        {
            [self handleResponse:response withError:error];
        }];
    }
}

- (void) handleResponse: (WPYPaymentResponse *) response withError: (NSError *) error
{
    if(error != nil)
    {
        NSLog(@"%@", error);
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"An error occurred." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
    else
    {
        NSString *transactionStatus;
        NSString * responseMessage;
        UIAlertAction * secondaryAction;
        
        NSLog(@"Response: %@", [response jsonDictionary]);
        
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
        
        if(response.transaction != nil)
        {
            secondaryAction = [UIAlertAction actionWithTitle:@"View Details" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                [self showTransactionDetails:response.transaction];
            }];
            
            responseMessage = response.transaction.responseText;
        }

        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Response" message:[NSString stringWithFormat:@"Status: %@\r\nResponse:%@\r\n", transactionStatus, responseMessage ?: @"No Message"] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        if(secondaryAction)
        {
            [alert addAction:secondaryAction];
        }
        
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void) showTransactionDetails:(WPYTransactionResponse *) response
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
