//
//  Logger.m
//  SystemCommand
//
//  Created by zhangtianfu on 10-10-25.
//  Copyright 2010 ND WebSoft Inc. All rights reserved.
//

#import "Logger.h"

#define kOpenLog        1

#if kOpenLog
#warning 开启日志
#else
#endif

#define LOG_PATH  [DOCUMENTS_DIRECTORY stringByAppendingPathComponent:@"91HomeLog.txt"]

typedef enum {
    kLogTypeNone = 0,
    kLogTypeConsoleLog = 1,
    kLogTypeFileLog = 2,
    kLogTypeAllLog = 3,
} LogType;

LogType const kLogType = kLogTypeConsoleLog;

@interface Logger()
{
	FILE		*m_hFile;
}

+ (Logger*)shareInstance;
+ (void)exitInstance;
- (void)logToFile:(NSString *)text fileName:(const char *)name line:(int)number;
+ (void)logToConsole:(NSString *)text fileName:(const char *)name line:(int)number;
@end

@implementation Logger

static Logger *kLogger = nil;

+ (Logger*)shareInstance
{
	@synchronized(self)
	{
		if (nil == kLogger)
		{
			kLogger = [[Logger alloc] init];
		}
	}
	
	return kLogger;
}

+ (void)exitInstance
{
	@synchronized(self)
	{
		if (nil != kLogger)
		{
			[kLogger release];
			kLogger = nil;
		}
	}
}

+ (void)log:(NSString *)text fileName:(const char *)name line:(int)number
{
#if kOpenLog
    if (kLogType == kLogTypeNone) {
        return;
    }
    
    switch (kLogType) {
        case kLogTypeConsoleLog:
        {
            [[self class] logToConsole:text fileName:name line:number];
        }
            break;
        case kLogTypeFileLog:
        {
            [[[self class] shareInstance] logToFile:text fileName:name line:number];
        }
            break;
        case kLogTypeAllLog:
        {
            [[self class] logToConsole:text fileName:name line:number];
            [[[self class] shareInstance] logToFile:text fileName:name line:number];
        }
            break;
        default:
            break;
    }
#endif
}

- (void)logToFile:(NSString *)text fileName:(const char *)name line:(int)number
{
	NSString *fileName = [NSString stringWithUTF8String:name];
	fileName = [fileName lastPathComponent];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *curDate = [formatter stringFromDate:[NSDate date]];
	NSString *logText = [NSString stringWithFormat:@"%@  %@(%d): %@\n", curDate, fileName, number, text];
    
	if (NULL == m_hFile)
	{
		m_hFile = fopen([LOG_PATH UTF8String], "wb+");//创建文件，如果存在会清空内容
	}
	
	if (NULL != m_hFile)
	{
		NSData *data = [logText dataUsingEncoding:NSUTF8StringEncoding];
		fseek(m_hFile, 0, SEEK_END);
		fwrite([data bytes], 1, [data length], m_hFile);
		fflush(m_hFile);
	}
	[formatter release];
}


+ (void)logToConsole:(NSString *)text fileName:(const char *)name line:(int)number
{
    NSString *fileName = [NSString stringWithUTF8String:name];
    fileName = [fileName lastPathComponent];
    NSString *logText = [NSString stringWithFormat:@"%@(%d): %@\n", fileName, number, text];
    NSLog(@"%@", logText);
}

- (void)dealloc
{
	fclose(m_hFile);
	[super dealloc];
}

@end
