//
//  PHNetworkManager.h
//  91Home
//
//  Created by leihui on 15/4/13.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

@interface PHNetworkManager : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(PHNetworkManager)

- (BOOL)connectedToNetwork;

@end
