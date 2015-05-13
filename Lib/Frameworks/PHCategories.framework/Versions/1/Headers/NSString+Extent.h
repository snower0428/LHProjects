//
//  NSString+Extent.h
//  CityLife
//
//  Created by sie kensou on 11-12-3.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString(Extent)

- (char)charValue;
- (NSString *)stringWithDecapitalizedFirstCharacter;
- (NSString *)stringWithCapitalizedFirstCharacter;
- (NSNumber *)numberValue;
- (NSNumber *)numberOfCharacher;

- (NSString *)urlEncodedString;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isEmptyString:(NSString *)string;

- (NSString *)stringByTrimmingwhitespaceAndNewlineCharacterSet;
- (CGSize)sizeWithMaxSize:(CGSize)size andFont:(UIFont *)font;

// 把温度格式25C°~30C°转换为把30/25°
- (NSString *)convertFrameTempStr:(NSString *)tempStr;
// 把温度格式30C°~25C°转换为把25-30°C
- (NSString *)convertToTempStyle2:(NSString *)tempStr;

@end


