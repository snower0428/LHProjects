//
//  UIDevice+Additions.h
//  Demo
//
//  Created by hui lei on 13-1-26.
//  Copyright (c) 2013年 113. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMacAddress     0

typedef enum
{
    PHDeviceNameNone = -1,
    PHDeviceNameLHiPod = 0,
    PHTestDevice1,
}PHDeviceName;

@interface UIDevice(Additions)

#if kMacAddress
- (NSString *)macaddress;//获取wifi地址
#endif

// 判断是否是iTouch
- (BOOL)isIPodTouchMachine;

// 判断是否是iPhone
- (BOOL)isIPhoneDevice;

// 判断是否是iPad
- (BOOL)isIPadMachine;

/**
 *  正在运行的进程
 *
 *  @return 返回正在运行进程的Array
 */
- (NSArray *)runningProcesses;

/**
 *  传入设备UDID，返回设备名字，用于测试
 */
+ (PHDeviceName)deviceNameWithUDID:(NSString *)UDID;

@property(readonly) double availableMemory;

+ (BOOL)isLowLevelDevice;

+ (BOOL)isLowLevelDeviceContainIPhone4;

@end
