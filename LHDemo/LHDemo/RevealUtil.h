//
//  RevealUtil.h
//  LHDemo
//
//  Created by leihui on 13-8-17.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RevealUtil : NSObject
{
    void *_revealLib;
}

- (void)startReveal;
- (void)stopReveal;

@end
