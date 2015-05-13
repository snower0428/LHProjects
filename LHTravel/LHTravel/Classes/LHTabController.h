//
//  LHTabController.h
//  LHTravel
//
//  Created by leihui on 15/5/13.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHTabController : UITabBarController <UITabBarControllerDelegate>

- (void)reCreateWithImageArray:(NSArray *)imageArray;
- (void)showNewFeatureAtIndex:(int)index;
- (void)hideNewFeatureAtIndex:(int)index;

@end
