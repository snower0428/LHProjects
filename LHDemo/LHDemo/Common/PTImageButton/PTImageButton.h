//
//  PTImageButton.h
//  LHDemo
//
//  Created by leihui on 16/1/7.
//  Copyright © 2016年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PTImageButtonType) {
	PTImageButtonImageLeft = 0,	// 图片在左，文字在右
	PTImageButtonImageRight,	// 图片在右，文字在右
	PTImageButtonImageTop,		// 图片在上，文字在下
	PTImageButtonImageBottom,	// 图片在下，文字在上
};

@interface PTImageButton : UIButton

/**
 *  按钮图片
 */
@property (nonatomic, strong) UIImage *buttonImage;

/**
 *  按钮标题
 */
@property (nonatomic, strong) NSString *buttonTitle;

/**
 *  标题字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 *  按钮类型
 */
@property (nonatomic, assign) PTImageButtonType imageButtonType;

/**
 *  按钮图片和标题之间的距离
 */
@property (nonatomic, assign) CGFloat interval;

/**
 *  按钮图片大小
 */
@property (nonatomic, assign) CGSize imageSize;

+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title;
+ (instancetype)buttonWithImage:(UIImage *)image title:(NSString *)title type:(PTImageButtonType)type;

@end
