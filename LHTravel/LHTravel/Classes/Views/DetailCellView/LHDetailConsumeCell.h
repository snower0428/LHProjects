//
//  LHDetailConsumeCell.h
//  LHTravel
//
//  Created by leihui on 15/6/1.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHDetailConsumeCellDelegate;

@interface LHDetailConsumeCell : UIView

@property (nonatomic, assign) id<LHDetailConsumeCellDelegate> delegate;

@end

@protocol LHDetailConsumeCellDelegate <NSObject>

@end
