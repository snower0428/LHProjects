//
//  GIFViewController.m
//  LHDemo
//
//  Created by leihui on 14-11-20.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import "GIFViewController.h"
#import "UIImage+animatedGIF.h"
#import "ResourcesManager.h"

@interface GIFViewController ()

@end

@implementation GIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"GIF";
	self.view.backgroundColor = [UIColor whiteColor];
	
	UIImage *image = nil;
	NSString *resPath = [NSString stringWithFormat:@"%@/Resource/Image", [[NSBundle mainBundle] resourcePath]];
	NSString *resGIFPath = [resPath stringByAppendingPathComponent:@"test.gif"];
	NSFileManager *defaultManager = [NSFileManager defaultManager];
	if ([defaultManager fileExistsAtPath:resGIFPath]) {
		NSData *data = [NSData dataWithContentsOfFile:resGIFPath];
		if (data) {
			image = [UIImage animatedImageWithAnimatedGIFData:data];
		}
	}
	
	CGFloat imageWidth = 240.f;
	CGFloat imageHeight = 320.f;
	CGFloat leftMargin = (self.view.frame.size.width - imageWidth)/2;
	CGFloat topMargin = (self.view.frame.size.height - imageHeight)/2;
	
	CGRect frame = CGRectMake(leftMargin, topMargin, imageWidth, imageHeight);
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
	imageView.image = image;
	[self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

@end
