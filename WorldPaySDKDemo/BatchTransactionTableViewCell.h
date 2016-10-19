//
//  BatchTransactionTableViewCell.h
//  WorldPaySDKDemo
//
//  Created by Harsha Chennamchetty on 10/12/16.
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef ANYWHERE_NOMAD
#import <WorldPaySDK_AC/WorldPaySDK.h>
#else
#import <WorldPaySDK_Miura/WorldPaySDK.h>
#endif

@interface BatchTransactionTableViewCell : UITableViewCell

-(instancetype)initWithTransaction: (WPYTransactionResponse *) transaction;

@end