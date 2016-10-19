//
//  ExtendedInformationView.h
//  WorldPaySDKDemo
//
//  Created by Jonas Whidden on 10/7/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtendedInformationView : UIView

@property (weak, nonatomic) IBOutlet UITextField *orderDate;
@property (weak, nonatomic) IBOutlet UITextField *purchaseOrder;
@property (weak, nonatomic) IBOutlet UITextField *gratuityAmount;
@property (weak, nonatomic) IBOutlet UITextField *serverName;
@property (weak, nonatomic) IBOutlet UITextField *notes;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

+ (CGFloat) expectedHeight;
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate;

@end
