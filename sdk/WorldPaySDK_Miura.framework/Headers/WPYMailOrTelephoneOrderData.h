//
//  WPYMailOrTelephoneOrderData.h
//  WorldpaySDK
//
//  Created by Jonas Whidden on 12/28/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "WPYDomainObject.h"

/**
 * Model data for Mail Or Telephone Order Data
 */
@interface WPYMailOrTelephoneOrderData : WPYDomainObject

/**
 * Type of transaction. valid values are:
 *
 * SINGLE_PURCHASE
 * RECURRING
 * INSTALLMENT
 */
@property (nonatomic, strong) NSString * type;
/**
 * Total number of installments. Required if type is INSTALLMENT.
 */
@property (nonatomic, strong) NSString * totalNumberOfInstallments;
/**
 * Current installment number. Required if type is INSTALLMENT.
 */
@property (nonatomic, strong) NSString * currentInstallment;

@end
