//
//  LHCoreImageViewController.h
//  LHDemo
//
//  Created by leihui on 13-9-16.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHCoreImageViewController : UIViewController
{
    UIImageView     *_imageView;
    
    CIContext       *_context;
    CIFilter        *_filter;
    CIImage         *_image;
}

@end
