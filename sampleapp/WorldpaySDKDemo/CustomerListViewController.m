//
//  CustomerListViewController.m
//  WorldpaySDKDemo
//
//  Created by Jonas Whidden on 10/13/16.
//  Copyright © 2016 Worldpay. All rights reserved.
//

#import "CustomerListViewController.h"
#import "BillingAddressCell.h"
#import "CustomerPaymentViewController.h"

#define BILLINGADDRESSHEIGHT 288
#define DEFAULTCELLHEIGHT 50

@interface CustomerListViewController ()

@property (nonatomic, strong) NSArray * list;

@end

@implementation CustomerListViewController

- (instancetype) initWithList: (NSArray *) list
{
    if((self = [super initWithNibName:nil bundle:nil]))
    {
        self.list = list;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.list count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Main data cell + card holder address cell + payment header cell + 1 cell per payment method + UDF header cell + 1 cell per UDF
    return 1 + 1 + ([[(WPYCustomerResponseData *)self.list[section] paymentMethods] count] > 0 ? [[(WPYCustomerResponseData *)self.list[section] paymentMethods] count] + 1 : 0) + ([[(WPYCustomerResponseData *)self.list[section] userDefinedFields] count] > 0 ? [[(WPYCustomerResponseData *)self.list[section] userDefinedFields] count] + 1 : 0);
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isPaymentMethodCell:indexPath])
    {
        return YES;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isPaymentMethodCell:indexPath])
    {
        CustomerPaymentViewController * paymentVC = [[CustomerPaymentViewController alloc] initWithPaymentMethod:[(WPYCustomerResponseData *)self.list[indexPath.section] paymentMethods][indexPath.row-3]];
        
        [self.navigationController pushViewController:paymentVC animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if([self isMainDataCell:indexPath])
    {
        // TODO: Make a custom cell for this
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mainData"];
    }
    else if([self isCardHolderAddressCell:indexPath])
    {
        cell = [[BillingAddressCell alloc] init];
        [(BillingAddressCell *)cell assignValues:[(WPYCustomerResponseData *)self.list[indexPath.section] address]];
    }
    else if([self isPaymentHeaderCell:indexPath])
    {
        // TODO: Customize
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paymentHeader"];
        
        [cell.textLabel setText:@"Payment Methods"];
    }
    else if([self isPaymentMethodCell:indexPath])
    {
        // TODO: Customize
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"paymentCell"];
        
        NSArray * paymentMethods = [(WPYCustomerResponseData *)self.list[indexPath.section] paymentMethods];
        
        WPYPaymentMethod * paymentMethod = paymentMethods[indexPath.row - 3];
        
        NSString * identifer = [NSString stringWithFormat:@"Method %li", (long)indexPath.row - 2];
        
        if(paymentMethod.card)
        {
            identifer = [NSString stringWithFormat:@"Card ...%@", paymentMethod.card.lastFourDigits];
        }
        else if(paymentMethod.check)
        {
            identifer = [NSString stringWithFormat:@"Check ...%@", paymentMethod.check.lastFourDigits];
        }
        else if(paymentMethod.notes)
        {
            identifer = paymentMethod.notes;
        }
        
        [cell.textLabel setText:identifer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if([self isUdfHeaderCellIndex:indexPath])
    {
        // TODO: Customize
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"udfHeader"];
        
        [cell.textLabel setText:@"User Defined Fields"];
    }
    else if([self isUdfCell:indexPath])
    {
        // TODO: Customize
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"udfCell"];
        
        NSDictionary * udf = [(WPYCustomerResponseData *)self.list[indexPath.section] userDefinedFields];
        
        NSArray * sortedUdf = [[udf allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        
        NSString * key = sortedUdf[indexPath.row - 1 - [self udfHeaderCellIndex:indexPath]];
        NSString * value = udf[key];
        
        [cell.textLabel setText:key];
        [cell.detailTextLabel setText:value];
    }
    else
    {
        NSAssert(false, @"Cell type not found for section: %li row: %li", (long)indexPath.section, (long)indexPath.row);
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Customer %@", [(WPYCustomerResponseData *)self.list[section] identifier]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self isMainDataCell:indexPath])
    {
        return DEFAULTCELLHEIGHT;
    }
    else if([self isCardHolderAddressCell:indexPath])
    {
        return BILLINGADDRESSHEIGHT;
    }
    else if([self isPaymentHeaderCell:indexPath])
    {
        return DEFAULTCELLHEIGHT;
    }
    else if([self isPaymentMethodCell:indexPath])
    {
        return DEFAULTCELLHEIGHT;
    }
    else if([self isUdfHeaderCellIndex:indexPath])
    {
        return DEFAULTCELLHEIGHT;
    }
    else if([self isUdfCell:indexPath])
    {
        return DEFAULTCELLHEIGHT;
    }
    else
    {
        NSAssert(false, @"Cell type not found for section: %li row: %li", (long)indexPath.section, (long)indexPath.row);
    }
    
    return DEFAULTCELLHEIGHT;
}

- (NSUInteger) udfHeaderCellIndex:(NSIndexPath *) path
{
    return ([[(WPYCustomerResponseData *)self.list[path.section] userDefinedFields] count] > 0 ? ([[(WPYCustomerResponseData *)self.list[path.section] paymentMethods] count] > 0 ? [[(WPYCustomerResponseData *)self.list[path.section] paymentMethods] count] + 3 : 2) : -1);
}

- (BOOL) isMainDataCell:(NSIndexPath *) path
{
    return path.row == 0;
}

- (BOOL) isCardHolderAddressCell:(NSIndexPath *) path
{
    return path.row == 1;
}

- (BOOL) isPaymentHeaderCell:(NSIndexPath *) path
{
    return ([[(WPYCustomerResponseData *)self.list[path.section] paymentMethods] count] > 0 ? path.row == 2 : NO);
}

- (BOOL) isPaymentMethodCell:(NSIndexPath *) path
{
    return ([[(WPYCustomerResponseData *)self.list[path.section] paymentMethods] count] > 0 ? path.row > 2 && path.row < [[(WPYCustomerResponseData *)self.list[path.section] paymentMethods] count] + 3 : NO);
}

- (BOOL) isUdfHeaderCellIndex:(NSIndexPath *) path
{
    return ([[(WPYCustomerResponseData *)self.list[path.section] userDefinedFields] count] > 0 ? path.row == [self udfHeaderCellIndex:path] : NO);
}

- (BOOL) isUdfCell:(NSIndexPath *) path
{
    return ([[(WPYCustomerResponseData *)self.list[path.section] userDefinedFields] count] > 0 ? path.row > [self udfHeaderCellIndex:path] && path.row < [[(WPYCustomerResponseData *)self.list[path.section] userDefinedFields] count] + [self udfHeaderCellIndex:path] + 1 : NO);
}

@end
