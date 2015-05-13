//
//  EOCAutoDictionary.h
//  LHDemo
//
//  Created by leihui on 15/4/21.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	动态方法解析
 */
@interface EOCAutoDictionary : NSObject

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id opaqueObject;
@property (nonatomic, strong) NSMutableDictionary *backingStore;

@property (nonatomic, strong) NSString *test;

@end
