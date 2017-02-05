//
//  TransactionDetailCell.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/5/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "TransactionDetailCell.h"

#define LABELTEXTSIZE 17

@interface TransactionDetailCell()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *formLabels;
@property (weak, nonatomic) IBOutlet UILabel *transactionIdValue;
@property (weak, nonatomic) IBOutlet UILabel *amountValue;
@property (weak, nonatomic) IBOutlet UILabel *paymentTypeValue;
@property (weak, nonatomic) IBOutlet UILabel *responseTextValue;
@property (weak, nonatomic) IBOutlet UILabel *responseMessageValue;
@property (weak, nonatomic) IBOutlet UILabel *gratuityValue;
@property (weak, nonatomic) IBOutlet UILabel *cashbackValue;

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

-(void)assignValues: (WPYTransaction *)response
{
    self.transactionIdValue.text = response.transactionIdentifier;
    self.amountValue.text = [NSString stringWithFormat:@"%@", response.amount ?: @""];
    self.paymentTypeValue.text = [Helper getPaymentType:response.paymentType];
    self.responseTextValue.text = response.responseText;
    self.responseMessageValue.text = response.responseText;
    self.gratuityValue.text = [NSString stringWithFormat:@"%@", response.gratuity ?: @""];
    self.cashbackValue.text = [NSString stringWithFormat:@"%@", response.cashbackAmount ?: @""];
}

@end
