//
//  PushPopCollectionViewCell.m
//  LHDemo
//
//  Created by leihui on 15/11/30.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PushPopCollectionViewCell.h"

@implementation PushPopCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Init
		self.backgroundColor = [UIColor purpleColor];
		
		// ImageView
		self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.f, 5.f, CGRectGetWidth(self.frame)-10.f, CGRectGetWidth(self.frame)-10.f)];
		self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
		[self addSubview:self.imageView];
		
		// Label
		self.label = [[UILabel alloc] initWithFrame:CGRectMake(5.f, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.frame)-10.f, 20.f)];
		self.label.backgroundColor = [UIColor brownColor];
		self.label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.label];
		
		// Button
		self.button = [UIButton buttonWithType:UIButtonTypeCustom];
		self.button.frame = CGRectMake(5.f, CGRectGetMaxY(self.label.frame), CGRectGetWidth(self.frame)-10.f, 30.f);
		[self.button setTitle:@"Button" forState:UIControlStateNormal];
		self.button.backgroundColor = [UIColor orangeColor];
		[self addSubview:self.button];
	}
	return self;
}

@end
