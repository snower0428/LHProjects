//
//  LHTravelItem.m
//  LHTravel
//
//  Created by leihui on 15/5/25.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHTravelItem.h"

@implementation LHTravelItem

#pragma mark - dealloc

- (void)dealloc
{
	self.name = nil;
	self.images = nil;
	
	[super dealloc];
}

@end
