//
//  LHDetailIntroCell.h
//  LHTravel
//
//  Created by leihui on 15/6/1.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LHDetailIntroCelllDelegate;

@interface LHDetailIntroCell : UIView

@property (nonatomic, assign) id<LHDetailIntroCelllDelegate> delegate;

- (void)updateIntoWithText:(NSString *)strText;
- (void)updateCallWithText:(NSString *)strText;

@end

#pragma mark - LHDetailIntroCelllDelegate

@protocol LHDetailIntroCelllDelegate <NSObject>

- (void)phoneCallDidSelected;

@end