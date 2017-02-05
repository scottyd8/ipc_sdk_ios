//
//  LabeledSegmentedControl.h
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/21/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabeledSegmentedControl : UIView

- (BOOL) sharedInitWithOptionList: (NSArray *) optionList initialIndex: (NSUInteger) initialIndex parentViewController: (UIViewController *) parentViewController title: (NSString *) title;

- (NSInteger) getSelectedIndex;
- (NSString *) getSelectedValue;
- (void) setSegmentedTouchedBlock:(void (^)(void))segmentedTouched;
- (void) setSelectedIndex:(NSUInteger)index;
- (void) setLabelText:(NSString *)text;
- (void) setEnabled: (BOOL) enabled;
- (void) setDisplayMode;
- (void) setEditMode;

@end
