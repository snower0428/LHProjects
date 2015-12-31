//
//  AutoCaptureViewController.m
//  LHDemo
//
//  Created by leihui on 15/7/29.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "AutoCaptureViewController.h"
#import "UIImage+Category.h"
#import "PTPhotoManager.h"

@interface AutoCaptureViewController ()
{
	NSTimer			*_timer;
	UIImageView		*_imageView;
	NSArray			*_array;
	
	BOOL	_bStart;
}

@end

@implementation AutoCaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	_imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	_imageView.image = [UIImage imageNamed:@"test.png"];
	[self.view addSubview:_imageView];
	
	_array = [[NSArray alloc] initWithObjects:@"test.png", @"test1.jpg", @"test2.png", nil];
	
	[self rightItemWithTitle:@"开始截图"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)startTimer
{
	if (_timer == nil) {
		_timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
	}
}

- (void)stopTimer
{
	if (_timer) {
		[_timer invalidate];
		_timer = nil;
	}
}

- (void)onTimer
{
	UIImage *image = [UIImage imageWithView:_imageView];
	
	[[PTPhotoManager sharedInstance] savePhoto:image toAlbum:@"截图测试" withCompletionBlock:^(NSError *error) {
		static NSInteger index = 1;
		if (error == nil) {
			self.title = [NSString stringWithFormat:@"%d", (int)index++];
		}
	}];
}

- (void)startCaptureAction:(id)sender
{
	_bStart = !_bStart;
	if (_bStart) {
		[self rightItemWithTitle:@"停止截图"];
		[self startTimer];
	}
	else  {
		[self rightItemWithTitle:@"开始截图"];
		[self stopTimer];
	}
}

- (void)rightItemWithTitle:(NSString *)title
{
	UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
	btnRight.frame = CGRectMake(0, 0, 80, 44);
	[btnRight setTitle:title forState:UIControlStateNormal];
	[btnRight setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
	[btnRight addTarget:self action:@selector(startCaptureAction:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
	self.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark - dealloc

- (void)dealloc
{
	[self stopTimer];
}

@end
