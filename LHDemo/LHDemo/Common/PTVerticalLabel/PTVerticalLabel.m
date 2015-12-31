//
//  PTVerticalLabel.m
//  LHDemo
//
//  Created by leihui on 15/12/22.
//  Copyright © 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PTVerticalLabel.h"

#define kVerticalLabelTag		20151222

@interface PTVerticalLabel ()

@property (nonatomic, assign) CGSize oneWordSize;

@end

@implementation PTVerticalLabel

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Init
		self.font = [UIFont systemFontOfSize:14.f];
		_textAlignment = PTVerticalTextAlignmentLeft;
	}
	return self;
}

- (void)setText:(NSString *)text
{
	_text = text;
	
	NSString *oneWord = @"测";
	_oneWordSize = [oneWord sizeWithFont:_font constrainedToSize:CGSizeMake(100, 100)];
	
	UILabel *label = (UILabel *)[self viewWithTag:kVerticalLabelTag];
	if (!label) {
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _oneWordSize.width, self.frame.size.height)];
		label.backgroundColor = [UIColor clearColor];
		label.tag = kVerticalLabelTag;
		label.numberOfLines = 0;
		label.font = _font;
		[self addSubview:label];
	}
	label.text = text;
	
	[self textAlignmentWith:_textAlignment];
}

- (void)setTextAlignment:(PTVerticalTextAlignment)textAlignment
{
	_textAlignment = textAlignment;
	
	[self textAlignmentWith:textAlignment];
}

- (void)textAlignmentWith:(PTVerticalTextAlignment)textAlignment
{
	UILabel *label = (UILabel *)[self viewWithTag:kVerticalLabelTag];
	if (label) {
		if (textAlignment == PTVerticalTextAlignmentLeft) {
			CGRect labelFrame = label.frame;
			labelFrame.origin.x = 0.f;
			label.frame = labelFrame;
		}
		else if (textAlignment == PTVerticalTextAlignmentCenter) {
			CGRect labelFrame = label.frame;
			labelFrame.origin.x = (self.bounds.size.width-_oneWordSize.width)/2;
			label.frame = labelFrame;
		}
		else if (textAlignment == PTVerticalTextAlignmentRight) {
			CGRect labelFrame = label.frame;
			labelFrame.origin.x = self.bounds.size.width-_oneWordSize.width;
			label.frame = labelFrame;
		}
	}
}

@end
