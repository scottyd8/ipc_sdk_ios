//
//  DropDownTextField.h
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/4/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownTextField : UITextField <UITextFieldDelegate>

- (NSString *) selectedTitle;
- (NSUInteger) selectedIndex;
- (NSDictionary *) selectedValue;

- (BOOL) sharedInitWithOptionList: (NSArray *) optionList initialIndex: (NSUInteger) initialIndex parentViewController: (UIViewController *) parentViewController title: (NSString *) title;

- (void) setEditingCallback: (void (^) (void)) callback;
- (void) setSelectionCallback: (void (^) (NSUInteger)) callback;
- (void) setSelectedIndex: (NSUInteger) selectedIndex;
- (void) setDisplayMode;
- (void) setEditMode;

@end
