//
//  LHDetailAddressCell.m
//  LHTravel
//
//  Created by leihui on 15/6/1.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHDetailAddressCell.h"

@implementation LHDetailAddressCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		CGFloat height = frame.size.height/2;
		
		// Address
		NSString *strText = @"地址：福州市鼓楼区铜盘路软件大道89号";
		NSMutableAttributedString *strAttributedText = [[[NSMutableAttributedString alloc] initWithString:strText] autorelease];
		CGRect rect = CGRectMake(10.f, 0.f, 250.f, height);
		
		NSDictionary *dictTitle = @{NSForegroundColorAttributeName: [UIColor blackColor],
									NSFontAttributeName: [UIFont boldSystemFontOfSize:14.f]};
		NSDictionary *dictValue = @{NSForegroundColorAttributeName: RGB(96, 96, 96),
									NSFontAttributeName: [UIFont systemFontOfSize:14.f]};
		if (strText.length >= 3) {
			[strAttributedText addAttributes:dictTitle range:NSMakeRange(0, 3)];
		}
		if (strText.length-3 > 0) {
			[strAttributedText addAttributes:dictValue range:NSMakeRange(3, strText.length-3)];
		}
		
		UILabel *lbAddress = [[[UILabel alloc] initWithFrame:rect] autorelease];
		lbAddress.attributedText = strAttributedText;
		[self addSubview:lbAddress];
		
		// Open time
		strText = @"开放时间：8:00~22:00";
		strAttributedText = [[[NSMutableAttributedString alloc] initWithString:strText] autorelease];
		rect = CGRectMake(10.f, height, 250.f, height);
		
		if (strText.length >= 5) {
			[strAttributedText addAttributes:dictTitle range:NSMakeRange(0, 5)];
		}
		if (strText.length-5 > 0) {
			[strAttributedText addAttributes:dictValue range:NSMakeRange(5, strText.length-5)];
		}
		
		UILabel *lbTime = [[[UILabel alloc] initWithFrame:rect] autorelease];
		lbTime.attributedText = strAttributedText;
		[self addSubview:lbTime];
		
		// Button
		CGFloat btnSize = 30.f;
		rect = CGRectMake(SCREEN_WIDTH - 40.f, (frame.size.height-btnSize)/2, btnSize, btnSize);
		
		UIButton *btnGo = [UIButton buttonWithType:UIButtonTypeCustom];
		btnGo.backgroundColor = [UIColor grayColor];
		btnGo.frame = rect;
		btnGo.layer.cornerRadius = btnSize/2;
		[self addSubview:btnGo];
		[btnGo addTarget:self action:@selector(btnGoAction:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	return self;
}

- (void)btnGoAction:(id)sender
{
	if (_delegate && [_delegate respondsToSelector:@selector(gotoThePlace)]) {
		[_delegate gotoThePlace];
	}
}

#pragma mark - dealloc

- (void)dealloc
{
	[super dealloc];
}

@end
