//
//  Foo.m
//  LHDemo
//
//  Created by leihui on 14-11-18.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import "Foo.h"

//
// Foo
//
@implementation Foo

- (void)testMethod
{
	NSLog(@">> Foo testMethod");
}

- (void)baseMethod
{
	NSLog(@">> Foo baseMethod");
}

- (void)recursionMethod
{
	NSLog(@">> Foo recursionMethod");
}

@end

//
// Bar
//
@implementation Bar

- (void)testMethod
{
	NSLog(@">> Bar testMethod");
}

@end

//
// Bar (BarCategory)
//

@implementation Bar (BarCategory)

- (void)altTestMethod
{
	NSLog(@">> Bar (BarCategory) altTestMethod");
}

- (void)altBaseMethod
{
	NSLog(@">> Bar (BarCategory) altBaseMethod");
}

- (void)altRecursionMethod
{
	NSLog(@">> Bar (BarCategory) altRecursionMethod");
	[self altRecursionMethod];
}

@end
