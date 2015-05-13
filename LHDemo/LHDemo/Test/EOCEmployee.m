//
//  EOCEmployee.m
//  PHWatch
//
//  Created by leihui on 15/4/21.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "EOCEmployee.h"

@interface EOCEmployeeDeveloper : EOCEmployee
@end

@implementation EOCEmployeeDeveloper

- (void)doADaysWork
{
	
}

@end

@interface EOCEmployeeDesigner : EOCEmployee
@end

@implementation EOCEmployeeDesigner

- (void)doADaysWork
{
	
}

@end

@interface EOCEmployeeFinance : EOCEmployee
@end

@implementation EOCEmployeeFinance

- (void)doADaysWork
{
	
}

@end

@implementation EOCEmployee

+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type
{
	switch (type) {
		case EOCEmployeeTypeDeveloper:
			return [EOCEmployeeDeveloper new];
			break;
		case EOCEmployeeTypeDesigner:
			return [EOCEmployeeDesigner new];
			break;
		case  EOCEmployeeTypeFinance:
			return [EOCEmployeeFinance new];
			break;
		default:
			break;
	}
	return nil;
}

- (void)doADaysWork
{
	NSString *reason = [NSString stringWithFormat:@"%@ must be overridden", NSStringFromSelector(_cmd)];
	@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:reason userInfo:nil];
}

@end





