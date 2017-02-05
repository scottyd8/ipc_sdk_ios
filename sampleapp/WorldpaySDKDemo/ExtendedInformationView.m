//
//  ExtendedInformationView.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/7/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "ExtendedInformationView.h"

#define VIEWHEIGHTWITHGRATUITY 272
#define GRATUITYHIDDEN YES
#define GRATUITYHEIGHT 106

#if GRATUITYHIDDEN
#define VIEWHEIGHT VIEWHEIGHTWITHGRATUITY - GRATUITYHEIGHT
#else
#define VIEWHEIGHT VIEWHEIGHTWITHGRATUITY
#endif

@interface ExtendedInformationView ()

@property (nonatomic, strong) IBOutlet UIView * view;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *gratuityConstraints;
@property (assign, nonatomic) CGFloat gratuityConstraintTotal;

@end

@implementation ExtendedInformationView

- (void) sharedInit
{
    [[NSBundle mainBundle] loadNibNamed:@"ExtendedInformationView" owner:self options:nil];
    [self addSubview: self.view];
    
    if(GRATUITYHIDDEN)
    {
        [self hideGratuity];
    }
    
    [self setTerminalGratuity];
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        [self sharedInit];
    }
    
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    [self sharedInit];
}

- (void) setTerminalGratuity
{
    if(!GRATUITYHIDDEN)
    {
        [self.gratuityAmount setHidden:true];
        [self.gratuityAmount setEnabled:false];
        [self.gratuityAmount setText:nil];
        [self.terminalGratuity setHidden:false];
    }
}

- (void) setMobileGrautity
{
    if(!GRATUITYHIDDEN)
    {
        [self.terminalGratuity setHidden:true];
        [self.terminalGratuity setSelectedSegmentIndex:0];
        [self.gratuityAmount setEnabled:true];
        [self.gratuityAmount setHidden:false];
    }
}

- (void) hideGratuity
{
    for(NSLayoutConstraint * constraint in self.gratuityConstraints)
    {
        [(UIView *)constraint.firstItem setHidden:YES];
        self.gratuityConstraintTotal += constraint.constant;
        constraint.constant = 0;
    }
}

+ (CGFloat) expectedHeight
{
    return VIEWHEIGHT;
}

- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate
{
    for(UITextField * textField in self.textFields)
    {
        textField.delegate = textFieldDelegate;
    }
}

@end
