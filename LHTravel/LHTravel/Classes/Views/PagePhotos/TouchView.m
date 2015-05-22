//
//  TouchView.m
//  PandaDesk_iphone
//
//  Created by yangxiangdang on 12-2-29.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TouchView.h"

#define kScrollInterval 6.0f
@interface ImageTouchView()
- (void)rippleImage;
@end

@implementation ImageTouchView
@synthesize     delegateTouch;
@synthesize transitionAnimated;

-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) 
	{
		[self setUserInteractionEnabled:YES];
        timerAnimation = nil;
        transitionAnimated = NO;
        curImageIndex = 0;
	}
	return  self;
}

- (void)dealloc {
    [self stopAnimating];
    
    [super dealloc];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	m_startPoint.x = location.x;
	m_startPoint.y = location.y;
    m_direct = 0;
    
    if ((delegateTouch)&&([delegateTouch respondsToSelector:@selector(touchesBegan)]))
    {
        [delegateTouch touchesBegan];
    }

    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];	
	float moveLenX = location.x-m_startPoint.x;
	float moveLenY = location.y-m_startPoint.y;
	if(m_direct == 0)
	{
		if( fabs(moveLenX) > kScrollInterval || fabs(moveLenY) > kScrollInterval)
		{
			if( moveLenX < -0.1f && (fabs(moveLenY) * 3 <= fabs(moveLenX) * 2) ){
				m_direct = 1;						
				//[self swipingViewBegin:location.x];	
				
			}
		}
	}
	if (m_direct == 1) {				
		//[self swipingViewOffset:location.x];		
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];	
	//[self swipingViewEnd:location.x];
    if (m_direct == 0) {
        float moveLenX = location.x - m_startPoint.x;
        float moveLenY = location.y-m_startPoint.y;
        if ( fabs(moveLenX) <= kScrollInterval || fabs(moveLenY) <= kScrollInterval) {
            if ((delegateTouch)&&([delegateTouch respondsToSelector:@selector(imageTouch:)]))
            {
                [delegateTouch imageTouch:self];
            }
        }
    }
    
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)startAnimating
{
    if (transitionAnimated && [self.animationImages count]>0)
    {
        timerAnimation = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration/[self.animationImages count])
                                                          target:self selector:@selector(rippleImage) userInfo:nil repeats:YES];
        if (self.image == nil)
        {
            [timerAnimation fire];
        }
    }
    else
    {
        [super startAnimating];
    }
}
- (void)stopAnimating
{
    if (timerAnimation)
    {
        [timerAnimation invalidate];
        timerAnimation = nil;
    }
    [super stopAnimating];
}

- (void)rippleImage
{
    if ([self.animationImages count] == 0)
        return;
    
    if ([self.animationImages count] == 1)
    {
        self.image = [self.animationImages objectAtIndex:0];
    }
    else
    {
        float interval = self.animationDuration/[self.animationImages count] * 0.8;
        if (interval > 1.0)
            interval = 1.0;
        if (interval >= 0.8)
        {
            CATransition *animation = [CATransition animation];
            animation.type = @"rippleEffect";
            animation.duration = interval;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            [self.layer addAnimation:animation forKey:@"ripple"];
        }
        
        self.image = [self.animationImages objectAtIndex:curImageIndex];
        curImageIndex = (++curImageIndex)%[self.animationImages count];
    }
}



@end
