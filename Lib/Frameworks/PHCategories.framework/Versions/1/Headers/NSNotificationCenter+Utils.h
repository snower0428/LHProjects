//
//  NSNotificationCenter+Utils.h
//  91PandaHome
//
//  Created by Ye Gaofei on 13-1-26.
//  Copyright (c) 2013年 113. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSNotificationCenter (Utils)
-(void)postNotificationOnMainThread:(NSNotification *)notification;
-(void)postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject;
-(void)postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject waitUntil:(BOOL)waitUntil;//added by ygf
-(void)postNotificationNameOnMainThread:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;
@end