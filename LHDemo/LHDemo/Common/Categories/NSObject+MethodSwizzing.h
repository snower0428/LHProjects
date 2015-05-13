//
//  NSObject+MethodSwizzing.h
//  LHDemo
//
//  Created by leihui on 14-11-18.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzing)

+ (BOOL)swizzingMethod:(SEL)origSel withMethod:(SEL)altSel;
+ (BOOL)swizzingClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

@end
