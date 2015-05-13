//
//  EOCSoundPlayer.h
//  LHDemo
//
//  Created by leihui on 15/4/22.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EOCSoundPlayer;

@protocol EOCSoundPlayerDelegate <NSObject>

- (void)soundPlayerDidFinish:(EOCSoundPlayer *)player;

@end

@interface EOCSoundPlayer : NSObject

@property (nonatomic, assign) id<EOCSoundPlayerDelegate> delegate;

- (id)initWithURL:(NSURL *)url;
- (void)playSound;

@end
