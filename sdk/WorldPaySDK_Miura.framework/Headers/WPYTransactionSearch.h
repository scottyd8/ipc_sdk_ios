//
//  WPYTransactionSearch.h
//  WorldPaySDK
//
//  Copyright © 2016 WorldPay. All rights reserved.
//

#import "WPYDomainObject.h"

@interface WPYTransactionSearch : WPYDomainObject
/**
 * This corresponds to the start date of the requested search
 */
@property (nonatomic, strong) NSDate *startDate;
/**
 * This corresponds to the end date of the requested search
 */
@property (nonatomic, strong) NSDate *endDate;
@end
