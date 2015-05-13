//
//  RevealUtil.m
//  LHDemo
//
//  Created by leihui on 13-8-17.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import "RevealUtil.h"
#import <dlfcn.h>

@implementation RevealUtil

- (void)startReveal
{
    NSString *revealLibName = @"libReveal.dylib";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dyLibPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, revealLibName];
    _revealLib = NULL;
    _revealLib = dlopen([dyLibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
    if (_revealLib == NULL)
    {
        char *error = dlerror();
        NSLog(@"dlopen error: %s", error);
    }
    else {
        // Post a notification to signal Reveal to start the service.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:self];
    }
}

- (void)stopReveal
{
    if (_revealLib) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IBARevealRequestStart" object:self];
        if (dlclose(_revealLib) == 0) {
            _revealLib = NULL;
        }
        else {
            char *error = dlerror();
            NSLog(@"Reveal library could not be unloaded: %s", error);
        }
    }
}

@end
