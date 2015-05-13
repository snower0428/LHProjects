//
//  EOCSoundPlayer.m
//  LHDemo
//
//  Created by leihui on 15/4/22.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "EOCSoundPlayer.h"
#import <AudioToolbox/AudioToolbox.h>

void EOCSoundPlayerCompletion(SystemSoundID ssID, void *clientData)
{
	EOCSoundPlayer *player = (EOCSoundPlayer *)clientData;
	if ([player.delegate respondsToSelector:@selector(soundPlayerDidFinish:)]) {
		[player.delegate soundPlayerDidFinish:player];
	}
}

@implementation EOCSoundPlayer
{
	SystemSoundID	_systemSoundID;
}

- (id)initWithURL:(NSURL *)url
{
	if (self = [super init]) {
		AudioServicesCreateSystemSoundID((CFURLRef)url, &_systemSoundID);
	}
	
	return self;
}

- (void)playSound
{
	AudioServicesAddSystemSoundCompletion(_systemSoundID, NULL, NULL, EOCSoundPlayerCompletion, (void *)self);
	AudioServicesPlaySystemSound(_systemSoundID);
}

#pragma mark - dealloc

- (void)dealloc
{
	AudioServicesDisposeSystemSoundID(_systemSoundID);
	
	[super dealloc];
}

@end
