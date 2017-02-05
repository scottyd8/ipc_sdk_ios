//
//  ExtendedInformationView.h
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/7/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtendedInformationView : UIView

@property (weak, nonatomic) IBOutlet UITextField *orderDate;
@property (weak, nonatomic) IBOutlet UITextField *purchaseOrder;
@property (weak, nonatomic) IBOutlet UITextField *gratuityAmount;
@property (weak, nonatomic) IBOutlet UITextField *serverName;
@property (weak, nonatomic) IBOutlet UITextField *notes;
@property (weak, nonatomic) IBOutlet UISegmentedControl * terminalGratuity;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

+ (CGFloat) expectedHeight;
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate;
- (void) setTerminalGratuity;
- (void) setMobileGrautity;

@end
