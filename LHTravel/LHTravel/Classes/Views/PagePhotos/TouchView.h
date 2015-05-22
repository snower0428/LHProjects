//
//  TouchView.h
//  PandaDesk_iphone
//
//  Created by yangxiangdang on 12-2-29.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

@protocol ImageTouchDelegate<NSObject>
@optional
- (void)touchesBegan;
- (void)imageTouch:(id)imageView;
@end

@interface ImageTouchView : UIImageView 
{
	id<ImageTouchDelegate>  delegateTouch;
    NSTimer *timerAnimation;
    
    NSUInteger curImageIndex;
    
    int                                 m_direct;
    CGPoint                             m_startPoint;
}
@property(nonatomic,assign)id<ImageTouchDelegate> delegateTouch;

@property (nonatomic, assign) BOOL transitionAnimated; //使用自定义图片切换效果

@end
