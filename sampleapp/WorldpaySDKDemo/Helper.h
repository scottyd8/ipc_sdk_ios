//
//  NSObject_Helper.h
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/7/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef ANYWHERE_NOMAD
#import <WorldPaySDK_AC/WorldPaySDK.h>
#else
#import <WorldPaySDK_Miura/WorldPaySDK.h>
#endif

#define CHECKAUTHTOKEN() \
if(![(AppDelegate *)[[UIApplication sharedApplication] delegate] authTokenAvailable]) \
{ \
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Auth token has not yet been received from server, please try again in a few moments." preferredStyle:UIAlertControllerStyleAlert]; \
    \
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]]; \
    \
    [self presentViewController:alertController animated:true completion:nil]; \
    \
    return; \
}

typedef NS_ENUM(NSUInteger, RESTMode) {
    RESTModeCreate,
    RESTModeEdit,
    RESTModeGet
};

@interface Helper: NSObject

+ (NSString *) getPaymentType: (WPYPaymentType) paymentType;
+ (void) constrainView: (UIView *) view toSecondView: (UIView *) secondView;
+ (void) styleButtonPrimary: (UIButton *) button;
+ (NSString *)getAppVersionInfo;
+ (NSString *)getSDKVersionInfo;

@end



