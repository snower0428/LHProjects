//
//  Test.m
//  LHDemo
//
//  Created by leihui on 14-12-1.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import "Test.h"

@implementation Test

- (int)addValue:(int)a toValue:(int)b
{
	int c = a + b;
	return c;
}

- (void)foo
{
	int add = [self addValue:12 toValue:34];
	NSLog(@"add = %i", add);
}

@end
