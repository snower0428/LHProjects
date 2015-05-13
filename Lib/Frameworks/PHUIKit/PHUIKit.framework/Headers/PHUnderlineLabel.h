//
//  UIUnderlineLabel.h
//  91Home
//
//  Created by leihui on 13-10-18.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHUnderlineLabel : UILabel
{
    UIColor     *_highlightedColor;
}

@property (nonatomic, retain) UIColor *normalColor;
@property (nonatomic, retain) UIColor *highlightedColor;
@property (nonatomic, retain) UIColor *unableColor;

- (void)addTarget:(id)target action:(SEL)action;

@end
