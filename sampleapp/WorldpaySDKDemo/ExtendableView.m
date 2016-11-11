//
//  ExtendableView.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/6/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "ExtendableView.h"

#define TITLESIZE 17

@interface ExtendableView ()

@property (strong, nonatomic) IBOutlet UIView *view;
@property (assign, nonatomic) CGFloat secondaryViewHeightConstant;
@property (assign, nonatomic) CGFloat expectedSecondaryHeight;
@property (weak, nonatomic) UIView * secondaryView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) BOOL extended;
@property (copy, nonatomic) void (^callback)(CGFloat);

@property (weak, nonatomic) NSLayoutConstraint * parentHeightConstraint;

@end

@implementation ExtendableView

- (void) sharedInit
{
    self.extended = false;
    [[NSBundle mainBundle] loadNibNamed:@"ExtendableView" owner:self options:nil];
    [self addSubview: self.view];
    [self.titleLabel setFont:[UIFont worldpayPrimaryWithSize: TITLESIZE]];
    self.secondaryContainerView.hidden = true;
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

- (void) setTitle: (NSString *) title
{
    self.titleLabel.text = title;
}

- (void) setSecondaryViewInContainer: (UIView *) view
{
    for(UIView * view2 in self.secondaryContainerView.subviews)
    {
        [view2 removeFromSuperview];
    }
    
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    self.secondaryView = view;
    
    [Helper constrainView:self.secondaryContainerView toSecondView:self.secondaryView];
}

- (IBAction)toggleSecondaryView:(id)sender
{
    CGFloat __block height;
    
    if(self.extended)
    {
        height = -self.secondaryViewHeightConstant;
        
        self.secondaryViewHeightConstant = 0;
    }
    else
    {
        
        height = self.expectedSecondaryHeight;
        
        self.secondaryViewHeightConstant = height;
    }
    
    if(self.callback)
    {
        self.callback(height);
    }
    
    self.parentHeightConstraint.constant += height;
        
    [self.view layoutIfNeeded];
    
    self.extended = !self.extended;
    self.secondaryContainerView.hidden = !self.secondaryContainerView.hidden;
}

- (void)setHeightCallback:(void (^)(CGFloat))callback
{
    self.callback = callback;
}

- (void) setHeightConstraint: (NSLayoutConstraint *) constraint
{
    self.parentHeightConstraint = constraint;
}

- (void)setSecondaryHeight:(CGFloat)secondaryHeight
{
    self.expectedSecondaryHeight = secondaryHeight;
}

@end
