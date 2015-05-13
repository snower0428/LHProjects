/*
 *  DeviceInfoDef.h
 *  PHUtility
 *
 *  Created by humin on 12-7-2.
 *  Copyright 2012 nd.com.cn. All rights reserved.
 *
 */
#ifndef		__DeviceInfoDef_H
#define		__DeviceInfoDef_H

typedef enum  
{
	iPhone_1	= 1,
	iPhone_3G,
	iPhone_3GS,
	iPhone_4,
	iPhone_4S,
    iPhone_5,
    iPhone_5C,
	iPhone_5S,
    iPhone_6Plus,
    iPhone_6,
    
	iPod_1		= 101,
	iPod_2,
	iPod_3,
	iPod_4,
	iPod_5,
    
	iPad_1		= 1001,
	iPad_2,
	iPad_mini,
	iPad_3,
	iPad_4,
	unknown,
} MACHINE_TYPE;

typedef enum {
    //iphone
    ScreenTypeUnknown = 0,
    ScreenType320_480,
    ScreenType640_960,
    ScreenType640_1136,
    ScreenType750_1334,
    ScreenType1242_2208,
    
    //ipad
    ScreenType1024_768,
    ScreenType2048_1536,
} ScreenType ;

#endif
