//
//  LHDetailCommentCell.m
//  LHTravel
//
//  Created by leihui on 15/6/1.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHDetailCommentCell.h"

@implementation LHDetailCommentCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(196, 196, 196);
        
        CGFloat topMargin = 5.f;
        CGRect rect = CGRectMake(0.f, 5.f, frame.size.width, frame.size.height - topMargin);
        
        UIView *containerView = [[[UIView alloc] initWithFrame:rect] autorelease];
        containerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:containerView];
        
        CGFloat leftMargin = 10.f;
        CGFloat height = 20.f;
        
        // 点评
        NSString *strText = @"点评";
        rect = CGRectMake(leftMargin, 0.f, frame.size.width, height);
        
        UILabel *lbTitle = [UILabel labelWithName:strText
                                             font:[UIFont boldSystemFontOfSize:14.f]
                                            frame:rect
                                            color:[UIColor blackColor]];
        [containerView addSubview:lbTitle];
        
        // 分割线
        rect = CGRectMake(leftMargin, rect.size.height, frame.size.width-10*2, 1);
        UIView *separator = [[[UIView alloc] initWithFrame:rect] autorelease];
        separator.backgroundColor = RGB(224, 224, 224);
        [containerView addSubview:separator];
    }
	
	return self;
}

#pragma mark - dealloc

- (void)dealloc
{
	[super dealloc];
}

@end
