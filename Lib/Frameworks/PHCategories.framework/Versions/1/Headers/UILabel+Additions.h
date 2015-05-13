//
//  UILabel+Additions.h
//  Demo
//
//  Created by hui lei on 13-1-26.
//  Copyright (c) 2013年 113. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel(Additions)

- (CGSize)ajustFrame;
+ (UILabel *)labelWithName:(NSString *)name font:(UIFont *)font frame:(CGRect)frame;
+ (UILabel *)labelWithName:(NSString *)name font:(UIFont *)font frame:(CGRect)frame color:(UIColor *)color;

#ifdef __IPHONE_6_0
+ (UILabel *)labelWithName:(NSString *)name font:(UIFont *)font frame:(CGRect)frame color:(UIColor *)color alignment:(NSTextAlignment)alignment;
#else
+ (UILabel *)labelWithName:(NSString *)name font:(UIFont *)font frame:(CGRect)frame color:(UIColor *)color alignment:(UITextAlignment)alignment;
#endif

@end
