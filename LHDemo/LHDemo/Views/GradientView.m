//
//  GradientView.m
//  LHDemo
//
//  Created by leihui on 13-12-13.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat progress = 0.7f; //This would be a property of your view
    CGFloat innerRadiusRatio = 0.5f; //Adjust as needed
    
    //Construct the path:
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = -M_PI_2 + MIN(1.0f, progress) * M_PI * 2;
    CGFloat outerRadius = CGRectGetWidth(self.bounds) * 0.5f - 1.0f;
    CGFloat innerRadius = outerRadius * innerRadiusRatio;
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGPathAddArc(path, NULL, center.x, center.y, innerRadius, startAngle, endAngle, false);
    CGPathAddArc(path, NULL, center.x, center.y, outerRadius, endAngle, startAngle, true);
    CGPathCloseSubpath(path);
    CGContextAddPath(ctx, path);
    CGPathRelease(path);
    
    //Draw the image, clipped to the path:
    CGContextSaveGState(ctx);
    CGContextClip(ctx);
    CGContextDrawImage(ctx, self.bounds, [[UIImage imageNamed:@"image.png"] CGImage]);
    CGContextRestoreGState(ctx);
}

@end
