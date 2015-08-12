//
//  PHDynamicCellView.m
//  LHTravel
//
//  Created by leihui on 15/6/10.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PHDynamicCellView.h"

static const CGFloat headerViewHeight = 50.f;
static const CGFloat imageShowViewHeight = 150.f;

@interface PHDynamicCellView ()

@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *imageShowView;

@end

@implementation PHDynamicCellView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Init
		
		[self addSubview:self.containerView];
	}
	
	return self;
}

#pragma mark - Private

- (void)payAttentionAction:(id)sender
{
	if (_delegate && [_delegate respondsToSelector:@selector(selectedPayAttention:)]) {
		[_delegate selectedPayAttention:sender];
	}
}

#pragma mark - Views

- (UIView *)containerView
{
	CGRect containerViewFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-5.f);
	
	UIView *containerView = [[[UIView alloc] initWithFrame:containerViewFrame] autorelease];
	containerView.backgroundColor = [UIColor whiteColor];
	
	[containerView addSubview:self.headerView];
	[containerView addSubview:self.imageShowView];
	
	return containerView;
}

- (UIView *)headerView
{
	CGRect frame = CGRectMake(0, 0, self.frame.size.width, headerViewHeight);
	
	UIView *headerView = [[[UIView alloc] initWithFrame:frame] autorelease];
	
	CGFloat leftMargin = 10.f;
	CGFloat xInterval = 10.f;
	CGFloat headerSize = 40.f;
	frame = CGRectMake(leftMargin, (frame.size.height-headerSize)/2, headerSize, headerSize);
	
	// 头像
	UIButton *btnHeader = [UIButton buttonWithType:UIButtonTypeCustom];
	btnHeader.backgroundColor = [UIColor orangeColor];
	btnHeader.frame = frame;
	btnHeader.layer.cornerRadius = frame.size.height/2;
	[headerView addSubview:btnHeader];
	
	leftMargin = frame.origin.x + frame.size.width + xInterval;
	frame = CGRectMake(leftMargin, frame.origin.y, 100.f, 20.f);
	
	// Name
	UILabel *lbName = [UILabel labelWithName:@"墙角小狐狸" font:[UIFont systemFontOfSize:14.f] frame:frame color:[UIColor blackColor]];
	[headerView addSubview:lbName];
	
	frame = CGRectMake(leftMargin, frame.origin.y + frame.size.height, frame.size.width, 15.f);
	
	// Post时间
	UILabel *lbPostTime = [UILabel labelWithName:@"2分钟前" font:[UIFont systemFontOfSize:12.f] frame:frame color:RGB(128, 128, 128)];
	[headerView addSubview:lbPostTime];
	
	CGFloat width = 120.f;
	frame = CGRectMake(self.frame.size.width - width, 0, width, headerView.frame.size.height);
	
	// 关注
	UIButton *btnPayAttention = [UIButton buttonWithType:UIButtonTypeCustom];
	btnPayAttention.frame = frame;
	[btnPayAttention setTitle:@"+ 关注" forState:UIControlStateNormal];
	[btnPayAttention setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[headerView addSubview:btnPayAttention];
	[btnPayAttention addTarget:self action:@selector(payAttentionAction:) forControlEvents:UIControlEventTouchUpInside];
	
	return headerView;
}

- (UIView *)imageShowView
{
	CGRect frame = CGRectMake(0, headerViewHeight, self.frame.size.width, imageShowViewHeight);
	
	UIView *imageShowView = [[[UIView alloc] initWithFrame:frame] autorelease];
	imageShowView.backgroundColor = [UIColor purpleColor];
	
	// ImageView
	UIImageView *imageView = [[[UIImageView alloc] initWithFrame:frame] autorelease];
	[imageShowView addSubview:imageView];
	
	return imageShowView;
}

#pragma mark - dealloc

- (void)dealloc
{
	self.containerView = nil;
	self.headerView = nil;
	
	[super dealloc];
}

@end
