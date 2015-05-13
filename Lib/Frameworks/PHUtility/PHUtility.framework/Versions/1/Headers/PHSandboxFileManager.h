//
//  SandboxFileManager.h
//  PandaHome
//
//  Created by Nd-link on 13-7-15.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 沙盒目录结构
 -----Document
 -----Xxx.app
 -----Library
 -----tmp
 */

@interface PHSandboxFileManager : NSObject
//获取Home目录路径
+(NSString *)getHomeDirectory;
//获取Document目录路径
+(NSString *)getDocumentsDirectory;
//获取Caches目录路径
+(NSString *)getCachesDirectory;
//获取Library目录路径
+(NSString *)getLibraryDirectory;
//获取Tmp目录路径
+(NSString *)getTmpDirectory;

@end
