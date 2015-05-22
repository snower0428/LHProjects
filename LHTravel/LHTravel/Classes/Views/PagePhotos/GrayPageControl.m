//
//  GrayPageControl.m
//  PandaDesk_iphone
//
//  Created by evergreenlau on 12-2-15.
//  Copyright 2012 ygf. All rights reserved.
//

#import "GrayPageControl.h"

@interface GrayPageControl(private)

-(void)updateDots;

@end


@implementation GrayPageControl

@synthesize activeImage;
@synthesize inactiveImage;

-(id)initWithFrame:(CGRect)frame hiddenBG:(BOOL)hiddenBG{
	if(self = [super initWithFrame:frame])
	{
		hideBG = hiddenBG;
	}
	return self;
}

- (void)drawRect:(CGRect)rect
{	
    if (!hideBG&&![self viewWithTag:TAG_BACKGROUND]) {
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3f;
        view.tag = TAG_BACKGROUND;
        [self addSubview:view];
        [view release];
    }	
}

-(void)setInactiveImage:(UIImage *)image{
	[inactiveImage release];
	inactiveImage=[image retain];
	[self updateDots];
}

-(void)setActiveImage:(UIImage *)image{
	[activeImage release];
	activeImage=[image retain];
	[self updateDots];
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
	[super endTrackingWithTouch:touch withEvent:event];
	[self updateDots];
}
-(void)setCurrentPage:(NSInteger)page
{
	[super setCurrentPage:page];
	[self updateDots];//modify by ygf
}

-(void)updateDots{
	if(inactiveImage || activeImage)
	{
		NSArray *subview = self.subviews;
		for (NSInteger i=0; i<[subview count]; i++) {
			UIImageView *dot =[subview objectAtIndex:i];
			if (dot.tag != TAG_BACKGROUND && [dot isKindOfClass:[UIImageView class]]) {
                UIImage* dotImage = self.currentPage==i?activeImage:inactiveImage;
				dot.image= dotImage;
                dot.frame = CGRectMake(dot.frame.origin.x, dot.frame.origin.y, dotImage.size.width, dotImage.size.height) ;                
			}
			
		}
	}
}

-(void)dealloc
{
	[inactiveImage release];
	inactiveImage = nil;
	[activeImage release];
	activeImage = nil;
	[super dealloc];
	
}

@end
