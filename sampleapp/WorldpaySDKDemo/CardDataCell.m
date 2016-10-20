//
//  CardDataCell.m
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/6/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "CardDataCell.h"
#import "UIFont+Worldpay.h"


#define LABELTEXTSIZE 17

@interface CardDataCell()


@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *formLabels;

@property (weak, nonatomic) IBOutlet UILabel *cardNumberValue;
@property (weak, nonatomic) IBOutlet UILabel *firstNameValue;
@property (weak, nonatomic) IBOutlet UILabel *lastNameValue;
@property (weak, nonatomic) IBOutlet UILabel *expirationMonthValue;
@property (weak, nonatomic) IBOutlet UILabel *expirationYearValue;

@end


@implementation CardDataCell

-(instancetype)init
{
    NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"CardDataCell" owner:self options:nil];
    
    if((self = (CardDataCell *)[nib objectAtIndex:0]))
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
    self.cardNumberValue.text = response.card.number;
    self.firstNameValue.text = response.card.firstName;
    self.lastNameValue.text = response.card.lastName;
    self.expirationMonthValue.text = [NSString stringWithFormat:@"%ld", (long)response.card.expirationMonth];
    self.expirationYearValue.text = [NSString stringWithFormat:@"%ld", (long)response.card.expirationYear];

}

@end
