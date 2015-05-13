//
//  WiFiScanner.h
//  LHDemo
//
//  Created by leihui on 14-11-27.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import <dlfcn.h>

@interface WiFiScanner : NSObject
{
	void *libHandle;
	void *airportHandle;
	
	int (*apple80211Open)(void *handle);
	int (*apple80211Bind)(void *handle, NSString *en);
	int (*apple80211Close)(void *handle);
	int (*apple80211Scan)(void *handle, NSArray **result, void *requirements);
	int (*apple80211Assoc)(void *handle, NSDictionary *apInfo, NSString *password);
	int (*apple80211Disassoc)(void *handle);
}

- (void)scan;
- (void)connectTo:(NSDictionary *)apInfo withPassword:(NSString *)password;
- (void)disconnect;

@end