//
//  Logger.h
//  SystemCommand
//
//  Created by zhangtianfu on 10-10-25.
//  Copyright 2010 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kLogTypeNone = 0,
    kLogTypeConsoleLog = 1,
    kLogTypeFileLog = 2,
    kLogTypeAllLog = 3,
} LogType;

#if 1
#warning 开启日志
#define  MLOG(...) [Logger log:[NSString stringWithFormat:__VA_ARGS__] fileName:__FILE__ line:__LINE__];
#else
#define  MLOG(...)
#define  NSLog(...)
#endif

@interface Logger : NSObject

+ (void)log:(NSString *)text fileName:(const char *)name line:(int)number;

+ (void)setLogType:(LogType)type;

@end

