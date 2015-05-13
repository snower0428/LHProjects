//
//  GrayPageControl.h
//  PandaDesk_iphone
//
//  Created by evergreenlau on 12-2-15.
//  Copyright 2012 ygf. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_BACKGROUND 1000

@interface GrayPageControl : UIPageControl {
    BOOL     hideBG;
	UIImage* activeImage;
	UIImage* inactiveImage;
}
-(id)initWithFrame:(CGRect)frame hiddenBG:(BOOL)hiddenBG;

@property (nonatomic,retain) UIImage* activeImage;
@property (nonatomic,retain) UIImage* inactiveImage;

@end
