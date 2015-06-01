//
//  LHDetailAddressCell.h
//  LHTravel
//
//  Created by leihui on 15/6/1.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHDetailAddressCellDelegate;

@interface LHDetailAddressCell : UIView

@property (nonatomic, assign) id<LHDetailAddressCellDelegate> delegate;

@end

@protocol LHDetailAddressCellDelegate <NSObject>

- (void)gotoThePlace;

@end
