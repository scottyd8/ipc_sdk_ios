//
//  LabeledTextField.h
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/1/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabeledTextField : UIView
@property (nonatomic, weak) IBOutlet UITextField * textField;
- (void) setTextFieldDelegate: (id <UITextFieldDelegate>) delegate;
- (void) setLabelText: (NSString *) string;
- (NSString *) text;
- (void) setFieldText: (NSString *) string;
- (void) setKeyboardTypeDecimal;
- (void) setEnabled: (BOOL) enabled;
- (void) setDisplayMode;
- (void) setEditMode;

@end
