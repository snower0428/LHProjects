//
//  Logger.h
//  SystemCommand
//
//  Created by zhangtianfu on 10-10-25.
//  Copyright 2010 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  MLOG(...) [Logger log:[NSString stringWithFormat:__VA_ARGS__] fileName:__FILE__ line:__LINE__];

@interface Logger : NSObject

+ (void)log:(NSString *)text fileName:(const char *)name line:(int)number;

@end

