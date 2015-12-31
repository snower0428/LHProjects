//
//  LHCommonDefines.h
//  LHDemo
//
//  Created by leihui on 13-9-10.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#ifndef LHDemo_LHCommonDefines_h
#define LHDemo_LHCommonDefines_h

#define SYSTEM_VERSION          [[UIDevice currentDevice].systemVersion floatValue]
#define SHORT_VERSION_STRING	[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define DOCUMENTS_DIRECTORY     [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define _(x)					NSLocalizedString(x, @"")

#define getResource(name)		[[ResourcesManager sharedInstance] imageWithFileName:name]

//判断是否是iPhone4设备
#define iPhone4 ([UIScreen mainScreen].bounds.size.height==480)

//判断是否是iPhone5设备
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
				CGSizeEqualToSize(CGSizeMake(640,1136), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 *
 *  屏幕元素定义
 *
 */
#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)
#define kApplication_Heigh      (SCREEN_HEIGHT-20)
#define kAppView_Height         (kApplication_Heigh-44)
#define	DOCK_HEIGHT				93
#define	STATUSBAR_HEIGHT		20
#define	NAVIGATIONBAR_HEIGHT	44
#define	TABBAR_HEIGHT			50
#define SUB_TABBAR_HEIGHT       44

//宽度高度缩放因子
#define iPhoneWidthScaleFactor  ([UIScreen mainScreen].bounds.size.width/320.f)

//状态栏透明页面偏移量
#define kTopShift   (SYSTEM_VERSION<7.0 ? (-STATUSBAR_HEIGHT) : 0)

#define RGB(r, g, b)            [UIColor colorWithRed:(float)(r)/255.f green:(float)(g)/255.f blue:(float)(b)/255.f alpha:1.0f]
#define RGBA(r, g, b, a)        [UIColor colorWithRed:(float)(r)/255.f green:(float)(g)/255.f blue:(float)(b)/255.f alpha:a]
#define kRandomColor			[UIColor colorWithRed:(float)(arc4random()%256)/255.0 green:(float)(arc4random()%256)/255.0 blue:(float)(arc4random()%256)/255.0 alpha:1.0]

#ifdef __IPHONE_6_0
	#define UITextAlignment                 NSTextAlignment
	#define UITextAlignmentLeft             NSTextAlignmentLeft
	#define UITextAlignmentCenter           NSTextAlignmentCenter
	#define UITextAlignmentRight            NSTextAlignmentRight
	#define UILineBreakModeCharacterWrap 	NSLineBreakByCharWrapping
	#define UILineBreakModeWordWrap         NSLineBreakByWordWrapping
	#define UILineBreakModeClip             NSLineBreakByClipping
	#define UILineBreakModeTruncatingHead   NSLineBreakByTruncatingHead
	#define UILineBreakModeTruncatingMiddle NSLineBreakByTruncatingMiddle
	#define UILineBreakModeTailTruncation   NSLineBreakByTruncatingTail
#endif

//格式化容量大小
#define Localizable_LF_Size_Bytes       @"%lld Bytes"
#define Localizable_LF_Size_K           @"%lld KB"
#define Localizable_LF_Size_M           @"%lld.%lld M"
#define Localizable_LF_Size_G           @"%lld.%d G"
#define Localizable_LF_All_Size_M       @"%lld.%lld M"
#define Localizable_LF_All_Size_G       @"%lld.%lld G"

#define TICK    NSDate *startTime = [NSDate date]
#define TOCK    NSLog(@"Time:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%f", -[startTime timeIntervalSinceNow])

#endif
