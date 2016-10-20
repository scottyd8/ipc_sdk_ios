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
@property (nonatomic, strong) NSDecimalNumber *freight;
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
 */
@property (nonatomic, strong) NSNumber *taxStatus;
/**
 * THe purchase order number associated with the order
 */
@property (nonatomic, strong) NSString *purchaseOrderNumber;
@end
