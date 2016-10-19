//
//  CustomerViewController.h
//  WorldPaySDKDemo
//
//  Created by Jonas Whidden on 10/13/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef ANYWHERE_NOMAD
#import <WorldPaySDK_AC/WorldPaySDK.h>
#else
#import <WorldPaySDK_Miura/WorldPaySDK.h>
#endif

@interface CustomerViewController : UIViewController

@end
