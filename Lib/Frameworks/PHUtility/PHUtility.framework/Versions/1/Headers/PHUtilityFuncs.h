//
//  PHUtilityFuncs.h
//  PHUtility-AppStore
//
//  Created by Lin Xiaobin on 14-4-15.
//  Copyright (c) 2014年 Lin Xiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, kApplyImageLocation)
{
    kApplyImageLocationLock = 1,
    kApplyImageLocationHome,
    kApplyImageLocationAll
};

@interface PHUtilityFuncs : NSObject

+ (id)extensionInfoForKey:(NSString *)key;

+ (void)enterBackground;
+ (void)exitApplication;
//保存壁纸到锁屏，主屏，锁屏和主屏
+ (void)applyImageForIOS7:(UIImage *)image
            applyLocation:(kApplyImageLocation)location
                 complete:(void(^)(BOOL result))complete;

//用于比较版本号，支持多段版本号，如1.9.1
+ (NSComparisonResult)version:(NSString *)v1 compareToVersion:(NSString *)v2;

@end
