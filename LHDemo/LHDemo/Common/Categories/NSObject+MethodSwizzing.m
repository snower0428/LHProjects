//
//  NSObject+MethodSwizzing.m
//  LHDemo
//
//  Created by leihui on 14-11-18.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import "NSObject+MethodSwizzing.h"

@implementation NSObject (MethodSwizzing)

+ (BOOL)swizzingMethod:(SEL)origSel withMethod:(SEL)altSel
{
	Method origMethod = class_getInstanceMethod(self, origSel);
	if (!origMethod) {
		NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origSel), [self class]);
		return NO;
	}
	
	Method altMethod = class_getInstanceMethod(self, altSel);
	if (!altMethod) {
		NSLog(@"original method %@ not found for class %@", NSStringFromSelector(altSel), [self class]);
		return NO;
	}
	
	class_addMethod(self, origSel, class_getMethodImplementation(self, origSel), method_getTypeEncoding(origMethod));
	class_addMethod(self, altSel, class_getMethodImplementation(self, altSel), method_getTypeEncoding(altMethod));
	
	method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
	
	return YES;
}

+ (BOOL)swizzingClassMethod:(SEL)origSel withClassMethod:(SEL)altSel
{
	Class cls = object_getClass((id)self);
	return [cls swizzingMethod:origSel withMethod:altSel];
}

@end
