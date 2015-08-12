//
//  PHDynamicCellView.h
//  LHTravel
//
//  Created by leihui on 15/6/10.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PHDynamicCellViewDelegate;

@interface PHDynamicCellView : UIView

@property (nonatomic, assign) id<PHDynamicCellViewDelegate> delegate;

@end

#pragma mark - PHDynamicCellViewDelegate

@protocol PHDynamicCellViewDelegate <NSObject>
@optional

- (void)selectedPayAttention:(id)sender;

@end