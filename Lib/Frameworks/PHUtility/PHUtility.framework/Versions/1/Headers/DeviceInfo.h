//
//  DeviceInfo.h
//  PHUtility
//
//  Created by humin on 12-7-2.
//  Copyright 2012 nd.com.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfoDef.h"
#import "OpenUDID.h"

@interface DeviceInfo : NSObject {

}
//获取设备类型
+ (MACHINE_TYPE)getMachineType;
//获取平台名称 如 “iPhone5,2”
+ (NSString *)getPlatformName;
//获取设备名称 如 “iPhone5,2”
+ (NSString *)getMachineName;
//获取设备唯一标识
+ (NSString *)getMachineUDID;

//判断设备是否支持多任务
+ (BOOL)hasMultiTask;
//判断设备是否支持高清
+ (BOOL)isHDMachine;
//判断是否iPad设备
+ (BOOL)isIPADMachine;
//判断是否iPhone设备
+ (BOOL)isIPhoneMachine;
//判断是否iPod设备
+ (BOOL)isIPodMachine;
//判断设备是否支持摄像头
+ (BOOL)isSupportAVCapture;
//获取固件
+ (NSString *)firmwareVersion;
+ (float)getFirmwareVersion;

//hm 2013-1-8 新增

//获取屏幕大小
+ (CGSize)getMachineScreenSize;
//获取系统分辨率
+ (CGSize)getMachineResolutionSize;

//hm 2013-1-31 新增

//是否是苹果五代设备
+ (BOOL)isFiveiPhoneMachine;

//是否六代设备
+ (BOOL)isIPhone6OrPlus;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone6Plus;

//emoji
//判断是否支持emoji
+ (BOOL)supportEmoji;
//设置开启\关闭emoji
+ (void)setControlEmojivalue:(BOOL)open;


//lxb 2013-10-18 新增

//获取设备名称+型号 - 如 “xxx的 iPod Touch 5”
+ (NSString *)machineNameAndModelType;
//获取设备名称 - 如 “xxx的iPhone”
+ (NSString *)machineName;
//获取设备型号 - 如 “iPod Touch 5”
+ (NSString *)machineModelType;

//获取设备颜色
/*
    优先获取后盖颜色，若获取失败，获取前盖颜色
    优先返回UIColor*，若获取失败，返回颜色名称，如white
 */
+ (id)machineColor;
//返回设备后盖颜色
+ (UIColor *)machineBackColor;
//返回设备前盖颜色
+ (UIColor *)machineFrontColor;
//获取设备后盖颜色 iOS7之前返回颜色名称 如white，iOS7之后返回颜色值 如#d7d9d8
+ (NSString *)machineBackColorString;
//获取设备前盖颜色 iOS7之前返回颜色名称 如white，iOS7之后返回颜色值 如#d7d9d8
+ (NSString *)machineFrontColorString;

//获取设备重量 单位g
+ (NSString *)machineWeight;

//获取摄像头像素
+ (NSString *)machineBackCamera;
+ (NSString *)machineFrontCamera;

// 可用磁盘容量
+ (NSString *)machineDiskAvailableString;
+ (unsigned long long)machineDiskAvailable;
// 已用磁盘容量
+ (NSString *)machineDiskInavailableString;
+ (unsigned long long)machineDiskInavailable;
// 总磁盘容量
+ (NSString *)machineDiskCapString;
+ (unsigned long long)machineDiskCap;

//内存
+ (NSUInteger)totalMemory;
+ (NSUInteger)activeMemory;
+ (NSUInteger)inactiveMemory;
+ (NSUInteger)freeMemory;
+ (NSUInteger)wiredMemory;
+ (NSUInteger)totalUserMemory;

//电池
+ (float)machineBatteryLevel;
+ (NSString *)realMachineBatteryLevel;
+ (UIDeviceBatteryState)machineBatteryState;
+ (NSString *)machineBatteryCapacity;
+ (NSArray *)machineBatteryTimeLimit;
//待机时间-单位分钟
+ (NSString *)machineStandbyTime;

//设备是否越狱
+ (BOOL)isJailbroken;

//lxb 2014-2-13 新增

/*
 * 判断设备屏幕是否相等
 * 设备名称 如 “iPhone5,2”
 */
+ (BOOL)isScreenSizeEqualToMachinePlatform:(NSString *)machineName;
+ (BOOL)isMachine:(NSString *)machineA screenSizeEqualTo:(NSString *)machineB;

//获取屏幕类型
+ (ScreenType)screenType;
+ (ScreenType)screenTypeWithMachine:(NSString *)machineName;

@end
