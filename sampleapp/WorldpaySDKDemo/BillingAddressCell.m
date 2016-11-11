//
//  BillingAddressCell.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/6/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "BillingAddressCell.h"

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

-(void)assignValues: (WPYAddressInfo *)address
{
    self.line1Value.text = address.line1;
    self.cityValue.text = address.city;
    self.stateValue.text = address.state;
    self.zipValue.text = address.zip;
    self.companyValue.text = address.company;
    self.phoneValue.text = address.phone;
}

@end
