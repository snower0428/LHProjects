//
//  LHDetailConsumeCell.m
//  LHTravel
//
//  Created by leihui on 15/6/1.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHDetailConsumeCell.h"

@implementation LHDetailConsumeCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		CGFloat height = frame.size.height/2;
		
		// 人均
		NSString *strText = @"人均\n45元";
		NSMutableAttributedString *strAttributedText = [[[NSMutableAttributedString alloc] initWithString:strText] autorelease];
		CGRect rect = CGRectMake(10.f, 0.f, 50.f, height);
		
		NSDictionary *dictTitle = @{NSForegroundColorAttributeName: [UIColor blackColor],
									NSFontAttributeName: [UIFont boldSystemFontOfSize:14.f]};
		NSDictionary *dictValue = @{NSForegroundColorAttributeName: RGB(96, 96, 96),
									NSFontAttributeName: [UIFont systemFontOfSize:14.f]};
		if (strText.length >= 2) {
			[strAttributedText addAttributes:dictTitle range:NSMakeRange(0, 2)];
		}
		if (strText.length-2 > 0) {
			[strAttributedText addAttributes:dictValue range:NSMakeRange(2, strText.length-2)];
		}
		
		UILabel *lbConsume = [[[UILabel alloc] initWithFrame:rect] autorelease];
		lbConsume.attributedText = strAttributedText;
		lbConsume.numberOfLines = 2;
		[self addSubview:lbConsume];
		
		// 特色项目
		rect = CGRectMake(rect.origin.x+rect.size.width+10.f, 0, 100.f, rect.size.height);
		
		UILabel *lbProject = [UILabel labelWithName:@"特色项目" font:[UIFont boldSystemFontOfSize:14.f] frame:rect color:[UIColor blackColor]];
		[self addSubview:lbProject];
		
		CGFloat btnSize = 30.f;
		CGFloat btnInterval = 5.f;
		for (NSInteger i = 0; i < 3; i++) {
			rect = CGRectMake(SCREEN_WIDTH/2 + (btnSize+btnInterval)*i, (frame.size.height-btnSize)/2, btnSize, btnSize);
			
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			button.backgroundColor = [UIColor grayColor];
			button.frame = rect;
			button.layer.cornerRadius = btnSize/2;
			[self addSubview:button];
			[button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
		}
	}
	
	return self;
}

- (void)btnAction:(id)sender
{
	
}

#pragma mark - dealloc

- (void)dealloc
{
	[super dealloc];
}

@end
