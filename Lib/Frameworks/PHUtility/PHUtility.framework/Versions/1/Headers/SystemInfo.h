//
//  SystemInfo.h
//  PHUtility
//
//  Created by humin on 12-7-2.
//  Copyright 2012 nd.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kLanguageTypeUnknown = -1,
    kLanguageTypeEnglish = 0,
    kLanguageTypeSimplifiedChinese,
    kLanguageTypeTraditionalChinese,
} LanguageType;

@interface SystemInfo : NSObject {

}

//当前语言
+ (NSString *)currentLanguage;
+ (BOOL)isChineseEnable;
+ (BOOL)isChineseSimplifiedEnable;
+ (LanguageType)languageType;

//获取剩余容量大小
+ (unsigned long long)allFreeSpace:(NSString *)DirPath;
//获取剩余容量大小
+ (NSString *)getFreeDiskSpace:(NSString *)DirPath;

//hm 13/4/16 系统字体相关

//获取系统所有字体
+ (NSArray*)getAllSystemFonts;
//获取当前系统字体
+ (UIFont*)getCurrentFont;

//16进制颜色转换 比如：#e26562   e26562
+ (UIColor *)colorWithHexString:(NSString *)color;

//得到中英文混合字符串长度
+ (int)convertStringLengthToInt:(NSString*)strtemp;
+ (NSUInteger)getStringLengthToInt:(NSString*)strtemp;

//获取系统运行的进行信息
+(NSMutableArray *)runningProcesses;

/*字体名如下：
 
 Font Family: American Typewriter
 Font: AmericanTypewriter
 Font: AmericanTypewriter-Bold
 
 Font Family: AppleGothic
 Font: AppleGothic
 
 Font Family: Arial
 Font: ArialMT
 Font: Arial-BoldMT
 Font: Arial-BoldItalicMT
 Font: Arial-ItalicMT
 
 Font Family: Arial Rounded MT Bold
 Font: ArialRoundedMTBold
 
 Font Family: Arial Unicode MS
 Font: ArialUnicodeMS
 
 Font Family: Courier
 Font: Courier
 Font: Courier-BoldOblique
 Font: Courier-Oblique
 Font: Courier-Bold
 
 Font Family: Courier New
 Font: CourierNewPS-BoldMT
 Font: CourierNewPS-ItalicMT
 Font: CourierNewPS-BoldItalicMT
 Font: CourierNewPSMT
 
 Font Family: DB LCD Temp
 Font: DBLCDTempBlack
 
 Font Family: Georgia
 Font: Georgia-Bold
 Font: Georgia
 Font: Georgia-BoldItalic
 Font: Georgia-Italic
 
 Font Family: Helvetica
 Font: Helvetica-Oblique
 Font: Helvetica-BoldOblique
 Font: Helvetica
 Font: Helvetica-Bold
 
 Font Family: Helvetica Neue
 Font: HelveticaNeue
 Font: HelveticaNeue-Bold
 
 Font Family: Hiragino Kaku Gothic **** W3
 Font: HiraKakuProN-W3
 
 Font Family: Hiragino Kaku Gothic **** W6
 Font: HiraKakuProN-W6
 
 Font Family: Marker Felt
 Font: MarkerFelt-Thin
 
 Font Family: STHeiti J
 Font: STHeitiJ-Medium
 Font: STHeitiJ-Light
 
 Font Family: STHeiti K
 Font: STHeitiK-Medium
 Font: STHeitiK-Light
 
 Font Family: STHeiti SC
 Font: STHeitiSC-Medium
 Font: STHeitiSC-Light
 
 Font Family: STHeiti TC
 Font: STHeitiTC-Light
 Font: STHeitiTC-Medium
 
 Font Family: Times New Roman
 Font: TimesNewRomanPSMT
 Font: TimesNewRomanPS-BoldMT
 Font: TimesNewRomanPS-BoldItalicMT
 Font: TimesNewRomanPS-ItalicMT
 
 Font Family: Trebuchet MS
 Font: TrebuchetMS-Italic
 Font: TrebuchetMS
 Font: Trebuchet-BoldItalic
 Font: TrebuchetMS-Bold
 
 Font Family: Verdana
 Font: Verdana-Bold
 Font: Verdana-BoldItalic
 Font: Verdana
 Font: Verdana-Italic
 
 Font Family: Zapfino
 Font: Zapfino*/

@end
