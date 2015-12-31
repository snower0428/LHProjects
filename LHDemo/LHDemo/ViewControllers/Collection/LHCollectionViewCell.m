//
//  LHCollectionViewCell.m
//  LHDemo
//
//  Created by leihui on 15/8/17.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHCollectionViewCell.h"

@implementation LHCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		CGFloat hue = ( arc4random() % 256 / 256.0 );
		CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
		CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
		UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
		self.contentView.backgroundColor = color;
		
		CGFloat labelWidth = SCREEN_WIDTH;
		
		self.titleLabel = [[UILabel alloc] init];
		self.titleLabel.frame = CGRectMake(0, 150.f, labelWidth, 22.f);
		self.titleLabel.font = [UIFont boldSystemFontOfSize:22.f];
		self.titleLabel.textAlignment = NSTextAlignmentCenter;
		self.titleLabel.numberOfLines = 0;
		self.titleLabel.textColor = [UIColor whiteColor];
		self.titleLabel.backgroundColor = [UIColor clearColor];
		self.titleLabel.shadowColor = [UIColor colorWithWhite:0.f alpha:0.8f];
		self.titleLabel.shadowOffset = CGSizeMake(0, 1);
		[self.contentView addSubview:self.titleLabel];
	}
	
	return self;
}

#pragma mark - dealloc

- (void)dealloc
{
	self.titleLabel = nil;
}

@end
