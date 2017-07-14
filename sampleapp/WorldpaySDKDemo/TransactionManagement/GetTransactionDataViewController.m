//
//  GetTransactionDataViewController.m
//  WorldpaySDKDemo
//
//  Created by Rakesh Ravva on 3/30/17.
//  Copyright © 2017 Worldpay. All rights reserved.
//

#import "GetTransactionDataViewController.h"
#import "TransactionDetailViewController.h"
#import "LabeledTextField.h"
#import "Helper.h"

@interface GetTransactionDataViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet LabeledTextField *transactionIdTextField;
@property (weak, nonatomic) IBOutlet UIButton *getTransactionButton;
@property (weak, nonatomic) UITextField *activeTextField;
@end

@implementation GetTransactionDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_transactionIdTextField setLabelText:@"Transaction ID"];
    [self.transactionIdTextField setTextFieldDelegate:self];
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer1];
    
    [self.getTransactionButton.titleLabel setFont:[UIFont worldpayPrimaryWithSize: 15]];
    
    [Helper styleButtonPrimary:self.getTransactionButton];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)getTransactionButtonPressed:(id)sender{

    [self.view endEditing:YES];
    
    
    [[WorldPayAPI instance] getTransactionDetails:self.transactionIdTextField.text withCompletion:^(WPYTransactionResponse *response, NSError *error) {
        
        if(error)
        {
            NSLog(@"%@",error);
        }
        
         [self handleResponse:response withError:error];
        
        
    }];

}

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
    TransactionDetailViewController *transDetailVC = [[TransactionDetailViewController alloc]init];
    [transDetailVC setTransactionResponse:response];
    [self.navigationController pushViewController:transDetailVC animated:YES];
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
