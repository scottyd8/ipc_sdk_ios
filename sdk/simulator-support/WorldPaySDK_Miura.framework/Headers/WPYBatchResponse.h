//
//  WPYBatchResponse.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYResponseObject.h"

@class WPYTransaction;

/** 
 * An object that only contains the identifier for the current batch.  Note that the 'identifier' property is common to all
 * WPYDomainObjects and is therefore visible at the base class level
 */
@interface WPYBatchResponse : WPYResponseObject
/**
 * A convenience method to get the WPYBatchResponse.identifier associated with the transaction
 */
@property (nonatomic, readonly, getter=getBatchId) NSString *batchId;
/**
 * A list of transactions associated with the batch
 */
@property (nonatomic, readonly, strong) NSArray <WPYTransaction *> *transactions;
@end
