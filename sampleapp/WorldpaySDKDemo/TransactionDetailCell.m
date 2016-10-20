//
//  TransactionDetailCell.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/5/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "TransactionDetailCell.h"
#import "UIFont+Worldpay.h"
#import "Helper.h"

#define LABELTEXTSIZE 17

@interface TransactionDetailCell()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *formLabels;
@property (weak, nonatomic) IBOutlet UILabel *transactionIdValue;
@property (weak, nonatomic) IBOutlet UILabel *amountValue;
@property (weak, nonatomic) IBOutlet UILabel *paymentTypeValue;
@property (weak, nonatomic) IBOutlet UILabel *responseTextValue;
@property (weak, nonatomic) IBOutlet UILabel *responseMessageValue;
@property (weak, nonatomic) IBOutlet UILabel *gratuityValue;

@end

@implementation TransactionDetailCell

-(instancetype)init
{
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"TransactionDetailCell" owner:self options:nil];

    if((self = (TransactionDetailCell *)[nib objectAtIndex:0]))
    {
        
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    
    for(UILabel * label in self.formLabels)
    {
        [label setFont:[UIFont worldpayPrimaryWithSize: LABELTEXTSIZE]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)assignValues: (WPYTransactionResponse *)response
{
    self.transactionIdValue.text = response.transactionId;
    self.amountValue.text = [NSString stringWithFormat:@"%@", response.amount ?: @""];
    self.paymentTypeValue.text = [Helper getPaymentType:response.paymentType];
    self.responseTextValue.text = response.responseText;
    self.responseMessageValue.text = response.responseText;
    self.gratuityValue.text = [response.gratuityAmount stringValue];
}

@end
