//
//  TransactionDetailCell.h
//  WorldpaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/5/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef ANYWHERE_NOMAD
#import <WorldPaySDK_AC/WorldPaySDK.h>
#else
#import <WorldPaySDK_Miura/WorldPaySDK.h>
#endif

@interface TransactionDetailCell : UITableViewCell

-(void)assignValues: (WPYTransaction *)response;

@end
