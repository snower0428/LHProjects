//
//  PagePhotosDataSource.h
//  PagePhotosDemo
//
//  Created by Andy soonest on 11-11-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PagePhotosDataSource<NSObject>

// 有多少页
//
- (int)numberOfPages;

// 每页的默认的本地图片
//
- (NSString *)imageAtIndex:(NSInteger)index;

//每页的默认的服务器端图片
//
- (NSString *)imageUrlAtIndex:(NSInteger)index;

//点中哪张图片

- (void)imageTouchIndex:(NSInteger)indexImage;

@end
