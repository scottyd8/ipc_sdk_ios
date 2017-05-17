//
//  TransactionManagementViewController.h
//  WorldpaySDKDemo
//
//  Created by Rakesh Ravva on 3/28/17.
//  Copyright © 2017 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>


#ifdef ANYWHERE_NOMAD
#import <WorldPaySDK_AC/WorldPaySDK.h>
#else
#import <WorldPaySDK_Miura/WorldPaySDK.h>
#endif


@interface TransactionManagementViewController : UIViewController

@end
