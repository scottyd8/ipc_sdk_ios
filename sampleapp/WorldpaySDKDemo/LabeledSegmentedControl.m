//
//  LabeledSegmentedControl.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/21/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "LabeledSegmentedControl.h"

@interface LabeledSegmentedControl()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) NSArray * _optionList;
@property (weak, nonatomic) UIViewController * _parentViewController;
@property (copy, nonatomic, nullable) void (^segmentedTouched)(void);
@property (strong, nonatomic) IBOutlet UIView * view;

@end

@implementation LabeledSegmentedControl

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:@"LabeledSegmentedControl" owner:self options:nil];
    
    [Helper constrainView:self toSecondView:self.view];
}

- (BOOL)sharedInitWithOptionList:(NSArray *)optionList initialIndex:(NSUInteger)initialIndex parentViewController:(UIViewController *)parentViewController title:(NSString *)title
{
    if(!(optionList.count > 0))
    {
        return NO; // Must have atleast one option
    }
    
    if(initialIndex > optionList.count - 1)
    {
        return NO; // Initial index must be in option list bounds
    }
    
    if(parentViewController == nil)
    {
        return NO; // parentViewController cannot be nil
    }
    
    for (id option in optionList)
    {
        if(![option isKindOfClass:[NSString class]])
        {
            return NO;
        }
    }
    
    self._optionList = optionList;
    [self.segmentedControl removeAllSegments];
    
    for(NSString * option in self._optionList)
    {
        [self.segmentedControl insertSegmentWithTitle:option atIndex:self.segmentedControl.numberOfSegments animated:false];
    }
    
    [self setLabelText:title];
    [self setSelectedIndex:initialIndex];
    self._parentViewController = parentViewController;
    
    return YES;
}

- (void) setLabelText:(NSString *) text
{
    self.title.text = text;
}

- (void) setSelectedIndex:(NSUInteger) index
{
    [self.segmentedControl setSelectedSegmentIndex:index];
}

- (NSInteger) getSelectedIndex
{
    return self.segmentedControl.selectedSegmentIndex;
}

- (NSString *) getSelectedValue
{
    return [self.segmentedControl titleForSegmentAtIndex:[self getSelectedIndex]];
}

- (void) setSegmentedTouchedBlock:(void (^)(void))segmentedTouched
{
    self.segmentedTouched = segmentedTouched;
}

- (IBAction)segmentedTouched:(id)sender
{
    if(self.segmentedTouched)
    {
        self.segmentedTouched();
    }
}

- (void) setEnabled:(BOOL)enabled
{
    self.segmentedControl.enabled = enabled;
}

- (void) setDisplayMode
{
    [self setEnabled:false];
}

- (void) setEditMode
{
    [self setEnabled:true];
}

@end
