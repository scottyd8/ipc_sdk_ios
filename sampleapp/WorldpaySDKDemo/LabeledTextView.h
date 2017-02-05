//
//  LabeledTextView.h
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 11/21/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabeledTextView : UIView

- (void) setTextViewDelegate: (id <UITextViewDelegate>) delegate;
- (void) setLabelText: (NSString *) string;
- (NSString *) text;
- (void) setFieldText: (NSString *) string;
- (void) setEnabled: (BOOL) enabled;
- (void) setDisplayMode;
- (void) setEditMode;

@end
