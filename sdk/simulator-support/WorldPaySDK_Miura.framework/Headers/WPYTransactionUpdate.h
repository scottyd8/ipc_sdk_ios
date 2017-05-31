//
//  WPYTransactionUpdate.h
//  WorldPaySDK
//
//  Created by Rakesh Ravva on 3/13/17.
//  Copyright © 2017 WorldPay. All rights reserved.
//


#import "WPYDomainObject.h"
#import "WPYLevelTwoData.h"

/**
 * Request object used to update transaction
 */
@interface WPYTransactionUpdate : WPYDomainObject

/**
 * Self-explanatory
 */
@property (nonatomic, strong) NSString *transactionId;

/**
 * This parameter contains data that the merchant wishes to pass up to the payment gateway for that specific transaction
 */
@property (nonatomic, strong) WPYLevelTwoData *levelTwoData;




@end
