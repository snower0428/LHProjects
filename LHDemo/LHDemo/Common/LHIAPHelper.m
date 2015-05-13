//
//  LHIAPHelper.m
//  LHDemo
//
//  Created by leihui on 14-4-21.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import "LHIAPHelper.h"

@implementation LHIAPHelper

+ (LHIAPHelper *)sharedInstance
{
    static dispatch_once_t once;
    static LHIAPHelper * sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.lh.InAppPurchase.Free",
                                      @"com.lh.InAppPurchase.Price1",
                                      @"com.lh.InAppPurchase.Price2",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    
    return sharedInstance;
}

@end
