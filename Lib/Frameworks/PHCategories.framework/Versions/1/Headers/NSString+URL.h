//
//  NSString+URL.h
//  Test
//
//  Created by LinXiaoBin on 14/8/21.
//  Copyright (c) 2014年 Lin Xiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(URL)

- (NSString *)stringBySetURLValue:(NSString *)value forKey:(NSString *)key;
- (NSString *)stringByAppendingURLValue:(NSString *)value forKey:(NSString *)key;
- (NSString *)stringByDeleteURLValueForKey:(NSString *)key;

- (NSString *)URLValueWithKey:(NSString *)key;
- (NSString *)stringByTrimmingEqualCharactersInSet:(NSCharacterSet *)set;

@end
