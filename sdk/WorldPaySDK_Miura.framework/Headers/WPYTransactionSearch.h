//
//  WPYTransactionSearch.h
//  WorldPaySDK
//
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "WPYDomainObject.h"

/// Request object used to search for transactions
@interface WPYTransactionSearch : WPYDomainObject

/**
 * This corresponds to the start date of the requested search
 */
@property (nonatomic, strong) NSDate *startDate;
/**
 * This corresponds to the end date of the requested search
 */
@property (nonatomic, strong) NSDate *endDate;
/**
 * Self-explanatory
 */
@property (nonatomic, strong) NSString *transactionId;
/**
 * Self-explanatory
 */
@property (nonatomic, strong) NSString *orderId;
/**
 * Self-explanatory
 */
@property (nonatomic, strong) NSDecimalNumber *amount;
/**
 * Self-explanatory
 */
@property (nonatomic, strong) NSString *customerId;

@end
