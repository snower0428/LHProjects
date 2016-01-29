//
//  PTImageButton.m
//  LHDemo
//
//  Created by leihui on 16/1/7.
//  Copyright © 2016年 ND WebSoft Inc. All rights reserved.
//

#import "PTImageButton.h"
#import "UIImage+Category.h"

@interface PTImageButton ()

@end

@implementation PTImageButton

+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title
{
	return [[self class] buttonWithImage:image title:title type:PTImageButtonImageLeft];
}

+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title type:(PTImageButtonType)type
{
	PTImageButton *imageButton = [[PTImageButton alloc] initWithFrame:CGRectZero];
	imageButton.buttonImage = image;
	imageButton.buttonTitle = title;
	imageButton.imageButtonType = type;
	
	return imageButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Init
	}
	return self;
}

- (void)setupButton
{
	if (_buttonImage) {
		[self setImage:_buttonImage forState:UIControlStateNormal];
	}
	if (_buttonTitle) {
		[self setTitle:_buttonTitle forState:UIControlStateNormal];
	}
	if (_titleFont) {
		[self.titleLabel setFont:_titleFont];
	}
	
	CGFloat imageWidth = _buttonImage.size.width;
	CGFloat imageHeight = _buttonImage.size.height;
	CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
	
	if (!CGSizeEqualToSize(_imageSize, CGSizeZero)) {
		imageWidth = _imageSize.width;
		imageHeight = _imageSize.height;
		
		[self setImage:[_buttonImage scaleImageToSize:_imageSize] forState:UIControlStateNormal];
	}
	
	switch (_imageButtonType) {
		case PTImageButtonImageLeft:
		{
			self.titleEdgeInsets = UIEdgeInsetsMake(0, _interval/2, 0, -_interval/2);
			self.imageEdgeInsets = UIEdgeInsetsMake(0, -_interval/2, 0, _interval/2);
			break;
		}
		case PTImageButtonImageRight:
		{
			self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth-_interval/2, 0, imageWidth+_interval/2);
			self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width+_interval/2, 0, -titleSize.width-_interval/2);
			break;
		}
		case PTImageButtonImageTop:
		{
			self.titleEdgeInsets = UIEdgeInsetsMake(imageHeight/2+_interval/2, -imageWidth/2,
													-imageHeight/2-_interval/2, imageWidth/2);
			self.imageEdgeInsets = UIEdgeInsetsMake(-imageHeight/2-_interval/2, titleSize.width/2,
													imageHeight/2+_interval/2, -titleSize.width/2);
			break;
		}
		case PTImageButtonImageBottom:
		{
			self.titleEdgeInsets = UIEdgeInsetsMake(-imageHeight/2-_interval/2, -imageWidth/2,
													imageHeight/2+_interval/2, imageWidth/2);
			self.imageEdgeInsets = UIEdgeInsetsMake(imageHeight/2+_interval/2, titleSize.width/2,
													-imageHeight/2-_interval/2, -titleSize.width/2);
			break;
		}
		default:
			break;
	}
}

#pragma mark - Setter

- (void)setButtonImage:(UIImage *)buttonImage
{
	_buttonImage = buttonImage;
	[self setupButton];
}

- (void)setButtonTitle:(NSString *)buttonTitle
{
	_buttonTitle = buttonTitle;
	[self setupButton];
}

- (void)setTitleFont:(UIFont *)titleFont
{
	_titleFont = titleFont;
	[self setupButton];
}

- (void)setImageButtonType:(PTImageButtonType)imageButtonType
{
	_imageButtonType = imageButtonType;
	[self setupButton];
}

- (void)setInterval:(CGFloat)interval
{
	_interval = interval;
	[self setupButton];
}

- (void)setImageSize:(CGSize)imageSize
{
	_imageSize = imageSize;
	[self setupButton];
}

@end
