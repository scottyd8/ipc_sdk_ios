//
//  LabeledDropDownTextField.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/1/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "LabeledDropDownTextField.h"
#import "DropDownTextField.h"

@interface LabeledDropDownTextField ()

@property (nonatomic, weak) IBOutlet DropDownTextField * textField;
@property (nonatomic, weak) IBOutlet UILabel * label;
@property (nonatomic, strong) IBOutlet UIView * view;

@end

@implementation LabeledDropDownTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:@"LabeledDropDownTextField" owner:self options:nil];
    
    [Helper constrainView:self toSecondView:self.view];
}

- (void)setLabelText:(NSString *)string
{
    self.label.text = string;
}

- (BOOL) sharedInitWithOptionList: (NSArray *) optionList initialIndex: (NSUInteger) initialIndex parentViewController: (UIViewController *) parentViewController title: (NSString *) title
{
    return [self.textField sharedInitWithOptionList:optionList initialIndex:initialIndex parentViewController:parentViewController title:title];
}

- (void)setEditingCallback:(void (^)(void))callback
{
    [self.textField setEditingCallback:callback];
}

- (void)setSelectionCallback:(void (^)(NSUInteger))callback
{
    [self.textField setSelectionCallback:callback];
}

- (void) setSelectedIndex: (NSUInteger) selectedIndex
{
    [self.textField setSelectedIndex:selectedIndex];
}

- (NSString *)selectedTitle
{
    return [self.textField selectedTitle];
}

- (NSUInteger)selectedIndex
{
    return [self.textField selectedIndex];
}

- (NSDictionary *)selectedValue
{
    return [self.textField selectedValue];
}

- (void) setEnabled: (BOOL) enabled
{
    [self.textField setEnabled:enabled];
}

- (void) setDisplayMode
{
    [self.textField setDisplayMode];
}

- (void) setEditMode
{
    [self.textField setEditMode];
}

@end
