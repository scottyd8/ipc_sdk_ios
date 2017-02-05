//
//  LabeledTextField.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/1/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "LabeledTextField.h"

@interface LabeledTextField ()

@property (nonatomic, weak) IBOutlet UITextField * textField;
@property (nonatomic, weak) IBOutlet UILabel * label;
@property (nonatomic, strong) IBOutlet UIView * view;

@end

@implementation LabeledTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:@"LabeledTextField" owner:self options:nil];
    
    [Helper constrainView:self toSecondView:self.view];
}

-(void)setTextFieldDelegate:(id<UITextFieldDelegate>)delegate
{
    self.textField.delegate = delegate;
}

- (void)setLabelText:(NSString *)string
{
    self.label.text = string;
}

- (NSString *)text
{
    return self.textField.text;
}

- (void)setFieldText:(NSString *)string
{
    self.textField.text = string;
}

- (void) setKeyboardTypeDecimal
{
    self.textField.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void) setEnabled:(BOOL)enabled
{
    self.textField.enabled = enabled;
}

- (void) setDisplayMode
{
    self.textField.borderStyle = UITextBorderStyleNone;
    [self setEnabled:false];
}

- (void) setEditMode
{
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self setEnabled:true];
}

@end
