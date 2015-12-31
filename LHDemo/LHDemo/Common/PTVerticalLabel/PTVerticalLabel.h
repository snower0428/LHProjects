//
//  PTVerticalLabel.h
//  LHDemo
//
//  Created by leihui on 15/12/22.
//  Copyright © 2015年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PTVerticalTextAlignment) {
	PTVerticalTextAlignmentLeft	= 0,
	PTVerticalTextAlignmentCenter,
	PTVerticalTextAlignmentRight,
};

@interface PTVerticalLabel : UIView

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) PTVerticalTextAlignment textAlignment;

@end
