//
//  LHPathDefines.h
//  LHDemo
//
//  Created by leihui on 13-9-10.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#ifndef LHDemo_LHPathDefines_h
#define LHDemo_LHPathDefines_h

//app主目录
#define HOME_DIRECTORY			NSHomeDirectory()
//app下Documents 目录
#define DOCUMENTS_DIRECTORY		[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
//程序主Bundle目录
#define MAIN_BUNDLEPATH			[[NSBundle mainBundle] resourcePath]
//程序资源Resource目录
#define RESOURCE_PATH			[MAIN_BUNDLEPATH stringByAppendingPathComponent:@"Resource"]
//配置目录
#define CONFIGURATION_PATH      [RESOURCE_PATH stringByAppendingPathComponent:@"Configuration"]

#define PANDAHOME_CACHE_PATH    [[PHSandboxFileManager getCachesDirectory] stringByAppendingPathComponent:@"cache"]
#define kConfig_Path			[DOCUMENTS_DIRECTORY stringByAppendingPathComponent:@"Configuration"]
#define CACHE_PATH				[PHSandboxFileManager getCachesDirectory]

//消息图片路径
#define kMsgImagePath           [PANDAHOME_CACHE_PATH stringByAppendingPathComponent:@"msgImage"]

#endif
