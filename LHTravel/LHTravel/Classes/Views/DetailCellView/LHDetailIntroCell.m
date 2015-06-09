//
//  LHDetailIntroCell.m
//  LHTravel
//
//  Created by leihui on 15/6/1.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHDetailIntroCell.h"

static const NSInteger kDescLabelTag = 8000;
static const NSInteger kCallButtonTag = 8010;

@implementation LHDetailIntroCell

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
        
        // 农庄介绍
        NSString *strText = @"农庄介绍";
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
        
        // 详细描述
        rect = CGRectMake(leftMargin, rect.origin.y + rect.size.height, frame.size.width-leftMargin*2, height);
        UILabel *lbDesc = [UILabel labelWithName:@"" font:nil frame:rect];
        lbDesc.tag = kDescLabelTag;
        [containerView addSubview:lbDesc];
        
        // 咨询电话
        rect = CGRectMake(leftMargin, rect.origin.y + rect.size.height, 180.f, 35.f);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = kCallButtonTag;
        button.frame = rect;
        button.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        button.layer.borderColor = [UIColor greenColor].CGColor;
        button.layer.borderWidth = 1.f;
        button.layer.cornerRadius = rect.size.height/2;
        [containerView addSubview:button];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)btnAction:(id)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(phoneCallDidSelected)]) {
        [_delegate phoneCallDidSelected];
    }
}

- (void)updateIntoWithText:(NSString *)strText
{
    // Adjust frame
    CGFloat fontSize = 9.f;
    CGFloat height = 14.f;
    CGFloat leftMargin = 10.f;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    CGSize size = [strText sizeWithFont:font
                      constrainedToSize:CGSizeMake(SCREEN_WIDTH-leftMargin*2, 1000)
                          lineBreakMode:UILineBreakModeWordWrap];
    
    NSInteger numberOfLines = size.height/9.f;
    
    UILabel *lbDesc = (UILabel *)[self viewWithTag:kDescLabelTag];
    if (lbDesc) {
        lbDesc.text = strText;
        lbDesc.font = font;
        lbDesc.numberOfLines = numberOfLines;
        
        CGRect frame = lbDesc.frame;
        frame.size.height = numberOfLines*height;
        lbDesc.frame = frame;
    }
    
    UIButton *button = (UIButton *)[self viewWithTag:kCallButtonTag];
    if (button) {
        CGRect frame = button.frame;
        frame.origin.y = lbDesc.frame.origin.y + lbDesc.frame.size.height;
        button.frame = frame;
    }
}

- (void)updateCallWithText:(NSString *)strText
{
    UIButton *button = (UIButton *)[self viewWithTag:kCallButtonTag];
    if (button) {
        NSString *title = [NSString stringWithFormat:@"咨询 %@", strText];
        [button setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark - dealloc

- (void)dealloc
{
	[super dealloc];
}

@end
