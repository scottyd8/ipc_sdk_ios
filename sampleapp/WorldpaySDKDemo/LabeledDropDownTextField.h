//
//  LabeledDropDownTextField.h
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/1/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "LabeledDropDownTextField.h"

@interface LabeledDropDownTextField : UIView

- (BOOL) sharedInitWithOptionList: (NSArray *) optionList initialIndex: (NSUInteger) initialIndex parentViewController: (UIViewController *) parentViewController title: (NSString *) title;

- (NSString *) selectedTitle;
- (NSUInteger) selectedIndex;
- (NSDictionary *) selectedValue;
- (void) setEditingCallback: (void (^) (void)) callback;
- (void) setSelectionCallback: (void (^) (NSUInteger)) callback;
- (void) setLabelText: (NSString *) string;
- (void) setEnabled: (BOOL) enabled;
- (void) setSelectedIndex: (NSUInteger) selectedIndex;
- (void) setDisplayMode;
- (void) setEditMode;

@end
