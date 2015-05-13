//
//  Foo.h
//  LHDemo
//
//  Created by leihui on 14-11-18.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// Foo
//
@interface Foo : NSObject

- (void)testMethod;
- (void)baseMethod;
- (void)recursionMethod;

@end

//
// Bar
//
@interface Bar : Foo

- (void)testMethod;

@end

//
// Bar (BarCategory)
//
@interface Bar (BarCategory)

- (void)altTestMethod;
- (void)altBaseMethod;
- (void)altRecursionMethod;

@end
