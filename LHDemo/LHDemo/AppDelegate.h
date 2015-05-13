//
//  AppDelegate.h
//  LHDemo
//
//  Created by leihui on 13-9-10.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UINavigationController *navCtrl;

#ifdef __IPHONE_7_0
@property (strong, nonatomic) CMMotionActivityManager *montionManager;
#endif

@end
