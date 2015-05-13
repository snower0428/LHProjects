//
//  EOCEmployee.h
//  PHWatch
//
//  Created by leihui on 15/4/21.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EOCEmployeeType) {
	EOCEmployeeTypeDeveloper,
	EOCEmployeeTypeDesigner,
	EOCEmployeeTypeFinance,
};

/**
 *	"类族"模式
 */
@interface EOCEmployee : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSUInteger salary;

+ (EOCEmployee *)employeeWithType:(EOCEmployeeType)type;
- (void)doADaysWork;

@end
