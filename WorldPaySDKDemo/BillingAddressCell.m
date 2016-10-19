//
//  BillingAddressCell.m
//  WorldPaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/6/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "BillingAddressCell.h"
#import "UIFont+Worldpay.h"

#define LABELTEXTSIZE 17

@interface BillingAddressCell()

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *formLabels;
@property (weak, nonatomic) IBOutlet UILabel *line1Value;
@property (weak, nonatomic) IBOutlet UILabel *cityValue;
@property (weak, nonatomic) IBOutlet UILabel *stateValue;
@property (weak, nonatomic) IBOutlet UILabel *zipValue;
@property (weak, nonatomic) IBOutlet UILabel *companyValue;
@property (weak, nonatomic) IBOutlet UILabel *phoneValue;

@end

@implementation BillingAddressCell

-(instancetype)init
{
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"BillingAddressCell" owner:self options:nil];
    
    if((self = (BillingAddressCell *)[nib objectAtIndex:0]))
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
    self.line1Value.text = response.billAddress.line1;
    self.cityValue.text = response.billAddress.city;
    self.stateValue.text = response.billAddress.state;
    self.zipValue.text = response.billAddress.zip;
    self.companyValue.text = response.billAddress.company;
    self.phoneValue.text = response.billAddress.phone;
}

@end
