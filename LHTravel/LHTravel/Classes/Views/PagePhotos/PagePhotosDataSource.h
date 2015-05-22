//
//  PagePhotosDataSource.h
//  PagePhotosDemo
//
//  Created by Andy soonest on 11-11-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PagePhotosDataSource

// 有多少页
//
- (NSInteger)numberOfPages;

// 每页的图片
//
- (NSString *)imageAtIndex:(NSInteger)index;

//点中哪张图片

- (void)imageTouchIndex:(NSInteger)indexImage;

@end
