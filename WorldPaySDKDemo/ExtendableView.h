//
//  ExtendableView.h
//  WorldPaySDKDemo
//
//  Created by Jonas Whidden on 10/6/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtendableView : UIView

@property (weak, nonatomic) IBOutlet UIView *secondaryContainerView;

- (void) setTitle: (NSString *) title;
- (void) setSecondaryViewInContainer: (UIView *) view;
- (void) setHeightCallback: (void (^)(CGFloat)) callback;
- (void) setHeightConstraint: (NSLayoutConstraint *) constraint;
- (void) setSecondaryHeight: (CGFloat) secondaryHeight;

@end
