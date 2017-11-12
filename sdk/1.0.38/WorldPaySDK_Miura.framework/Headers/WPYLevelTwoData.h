//
//  WPYLevelTwoData.h
//  WorldpaySDK
//
//  Copyright © 2015 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/**
 * This optional data gets passed up to the payment gateway with a payment request
 */
@interface WPYLevelTwoData : WPYDomainObject
/**
 * Date that the order was placed
 */
@property (nonatomic, strong) NSDate *orderDate;
/**
 * Amount of duty to be charged with the order
 */
@property (nonatomic, strong) NSDecimalNumber *dutyAmount;
/**
 * The cost of freight associated with the order
 */
@property (nonatomic, strong) NSDecimalNumber *freightAmount;
/**
 * The retail lane or register associated with the transaction
 */
@property (nonatomic, strong) NSNumber *retailLaneNumber;
/**
 * The amount of tax charged on the order
 */
@property (nonatomic, strong) NSDecimalNumber *taxAmount;
/**
 * Tax Status of the order
 * 
 * 0 - NotIncluded
 * 1 - Included
 * 2 - Exempt
 */
@property (nonatomic, strong) NSNumber *status;
/**
 * THe purchase order number associated with the order
 */
@property (nonatomic, strong) NSString *purchaseOrder;
@end
