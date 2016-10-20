//
//  SettlementViewController.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/12/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "SettlementViewController.h"
#import "UIColor+Worldpay.h"
#import "BatchDetailTableViewController.h"

@interface SettlementViewController ()

@property (weak, nonatomic) IBOutlet UIButton *getBatchButton;
@property (weak, nonatomic) IBOutlet UIButton *closeBatchButton;
@property (weak, nonatomic) UITextField * activeTextField;
@property (weak, nonatomic) IBOutlet UITextField *batchIdTextField;
@property (assign, atomic) BOOL transition;

@end

@implementation SettlementViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        self.title = @"Settlement";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.getBatchButton.backgroundColor = [UIColor worldpayEmerald];
    [self.getBatchButton setTitleColor:[UIColor worldpayWhite] forState:UIControlStateNormal];
    self.closeBatchButton.backgroundColor = [UIColor worldpayEmerald];
    [self.closeBatchButton setTitleColor:[UIColor worldpayWhite] forState:UIControlStateNormal];
    
    self.batchIdTextField.delegate = self;
    
    UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFocusFromTextField:)];
    [recognizer1 setNumberOfTapsRequired:1];
    [recognizer1 setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showTransactionsInBatch:(NSString *) batchId
{
    [[WorldpayAPI instance] getTransactionsInBatch:batchId withCompletion:^(NSArray<WPYTransactionResponse *> * transactions, NSError * error)
    {
        [self displayBatchAlertWithId:batchId transactions:transactions error:error];
    }];
}

- (void) showTransactionsInCurrentBatch
{
    [[WorldpayAPI instance] getCurrentBatchWithCompletion:^(WPYBatchResponse * response, NSError * error)
    {
        [self displayBatchAlertWithId:response.identifier transactions:response.transactions error:error];
    }];
}

- (void) displayBatchAlertWithId: (NSString *) batchId transactions: (NSArray<WPYTransactionResponse *> *) transactions error: (NSError *) error
{
    if(error != nil)
    {
        NSLog(@"%@",error);
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"An error occurred, batch not found." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
        self.transition = NO;
    }
    else if(batchId == nil)
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Response" message:@"No batch found." preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
        self.transition = NO;
    }
    else
    {
        BatchDetailTableViewController * batchDetailTableVC = [[BatchDetailTableViewController alloc] initWithTransactions:transactions batchId:batchId];
        
        [self.navigationController pushViewController:batchDetailTableVC animated:true];
        self.transition = NO;
    }
}

- (IBAction)getBatch:(id)sender
{
    [self removeFocusFromTextField:nil];
    
    if(self.transition)
    {
        return;
    }
    
    self.transition = YES;
    
    if(sender == nil || [self.batchIdTextField.text isEqualToString:@""])
    {
        [self showTransactionsInCurrentBatch];
    }
    else
    {
        [self showTransactionsInBatch:self.batchIdTextField.text];
    }
}

- (IBAction)closeBatch:(id)sender
{
    [self removeFocusFromTextField:nil];
    
    if(self.transition)
    {
        return;
    }
    
    [[WorldpayAPI instance] closeCurrentBatchWithCompletion:^(WPYBatchResponse * response, NSError * error)
    {
        if(error != nil)
        {
            NSLog(@"%@",error);
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"An error occurred." preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alert animated:true completion:nil];
        }
        else if([response.identifier isEqualToString:@"0"])
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Batch could not be successfully closed." preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alert animated:true completion:nil];
        }
        else
        {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Response" message:[NSString stringWithFormat:@"Batch %@ was successfully closed.", response.identifier] preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"View Transactions" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                [self getBatch:nil];
            }]];
            
            [self presentViewController:alert animated:true completion:nil];
            self.transition = NO;
        }
    }];
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
