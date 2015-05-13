//
//  WiFiScanner.m
//  LHDemo
//
//  Created by leihui on 14-11-27.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import "WiFiScanner.h"

@implementation WiFiScanner

- (id)init {
	self = [super init];
	
	// iOS 8中留意一下/System/Library/SystemConfiguration/EAPOLController.bundle/eapolclient
	libHandle = dlopen("/System/Library/SystemConfiguration/IPConfiguration.bundle/IPConfiguration", RTLD_LAZY);
	
	apple80211Bind = dlsym(libHandle, "Apple80211BindToInterface");
	apple80211Close = dlsym(libHandle, "Apple80211Close");
	apple80211Scan = dlsym(libHandle, "Apple80211Scan"); // 扫描
	apple80211Assoc = dlsym(libHandle, "Apple80211Associate"); // 连接，iOS 8中我粗略扫了一眼，没找到这个函数
	apple80211Disassoc = dlsym(libHandle, "Apple80211Disassociate"); // 断开，iOS 8中我粗略扫了一眼，没找到这个函数
	
	apple80211Open(&airportHandle);
	apple80211Bind(airportHandle, @"en0");
	
	return self;
}

- (void)scan {
	NSDictionary *parameters = [[NSDictionary alloc] init]; // 扫描参数，不填则获取所有信息
	NSArray *scan_networks; // 存放扫描信息，每个对象均是一个NSDictionary
	
	apple80211Scan(airportHandle, &scan_networks, parameters); // 同步扫描
	for (id dictionary in scan_networks) {
		if (dictionary) // 判断要连接哪一个热点
			[self connectTo:dictionary withPassword:nil];
	}
	
	[parameters release];
}

- (void)connectTo:(NSDictionary *)apInfo withPassword:(NSString *)password {
	apple80211Assoc(airportHandle, apInfo, password);
}

- (void)disconnect {
	apple80211Disassoc(airportHandle);
}

- (void)dealloc {
	apple80211Close(airportHandle);
	dlclose(libHandle);
	[super dealloc];
}
@end