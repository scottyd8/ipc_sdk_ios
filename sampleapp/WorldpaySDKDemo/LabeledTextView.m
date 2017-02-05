//
//  LabeledTextView.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/21/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "LabeledTextView.h"

@interface LabeledTextView()

@property (strong, nonatomic) IBOutlet UIView * view;
@property (weak, nonatomic) IBOutlet UILabel * title;
@property (weak, nonatomic) IBOutlet UITextView * textView;

@end

@implementation LabeledTextView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:@"LabeledTextView" owner:self options:nil];
    
    [self setEditMode];
    
    [Helper constrainView:self toSecondView:self.view];
}

- (void) setTextViewDelegate: (id<UITextViewDelegate>) delegate
{
    self.textView.delegate = delegate;
}

- (void)setLabelText:(NSString *)string
{
    self.title.text = string;
}

- (NSString *) text
{
    return self.textView.text;
}

- (void) setFieldText:(NSString *)string
{
    self.textView.text = string;
}

- (void) setEnabled:(BOOL)enabled
{
    self.textView.editable = enabled;
}

- (void) setDisplayMode
{
    self.textView.layer.cornerRadius = 0;
    self.textView.layer.borderWidth = 0;
    [self setEnabled:false];
}

- (void) setEditMode
{
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.borderColor = [[UIColor worldpaySmoke] CGColor];
    self.textView.layer.borderWidth = .5;
    [self setEnabled:true];
}

@end
