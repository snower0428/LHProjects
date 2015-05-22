//
//  LHHomeViewController.m
//  LHTravel
//
//  Created by leihui on 15/5/13.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHHomeViewController.h"
#import "PagePhotosView.h"

@interface LHHomeViewController () <PagePhotosDataSource>
{
	PagePhotosView		*_bannerView;
	NSMutableArray      *_banners;
}

@end

@implementation LHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	_banners = [[NSMutableArray alloc] init];
	
	NSArray *array = @[@"http://www.onegreen.org/desk/Upload_desk/200902/20090221002654817.jpg",
					   @"http://www.onegreen.org/desk/Upload_desk/200902/20090221000533118.jpg",
					   @"http://www.ulifeel.com/wp-content/uploads/2014/04/moore-3-640x320.jpg",];
	for (NSInteger i = 0; i < [array count]; i++) {
		NSString *strUrl = [array objectAtIndex:i];
		if (strUrl) {
			[_banners addObject:strUrl];
		}
	}
	
	[self initBannerView];
	
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)initBannerView
{
	_bannerView = [[PagePhotosView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PHOTO_HEIGHT) withDataSource:self];
	_bannerView.backgroundColor = [UIColor orangeColor];
	[self.view addSubview:_bannerView];
}

- (void)initButtons
{
	NSArray *arrayTitle = @[@"有棋牌", @"有垂钓", @"有烧烤", @"有拓展", @"有采摘"];
	NSArray *arrayColor = @[RGB(254, 176, 91),]
	
	CGFloat topMargin = _bannerView.frame.size.height + 8.f*iPhoneWidthScaleFactor;
	CGFloat buttonSize = 64.f*iPhoneWidthScaleFactor;
	
	for (NSInteger i = 0; i < [arrayTitle count]; i++) {
		
		CGRect viewFrame = CGRectMake(buttonSize*i, topMargin, buttonSize, buttonSize);
		UIView *view = [[[UIView alloc] initWithFrame:viewFrame] autorelease];
		
		CGFloat btnLeftMargin = 7.f*iPhoneWidthScaleFactor;
		CGRect buttonFrame = CGRectMake(btnLeftMargin, 0, 50.f*iPhoneWidthScaleFactor, 50.f*iPhoneWidthScaleFactor);
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		
		button.frame = buttonFrame;
		[self.view addSubview:button];
	}
}

#pragma mark -
#pragma mark PagePhotosDataSource

// 有多少页
- (NSInteger)numberOfPages
{
	NSInteger pages = [_banners count];
	if (_banners == nil || [_banners count]==0)
		pages = 1;
	return pages;
}

// 每页的图片
- (NSString *)imageAtIndex:(NSInteger)index
{
	NSString *imgPath = nil;
	if ([_banners count] > 0) {
		if (index < [_banners count]) {
			imgPath = [_banners objectAtIndex:index];
		}
	}
	return imgPath;
}

//点中哪张图片
- (void)imageTouchIndex:(NSInteger)indexImage
{
	if ([_banners count] > 0) {
		if (indexImage < [_banners count]) {
			
		}
	}
	else {
		//如果为空，则显示默认图
//		BOOL status = [[NetworkStatusMgr sharedInstance] getNetworkStatus];
//		if (!status)
//			[PHLabelMessage showMessageLable:_(@"Network error !") inView:self.view withTimeInterval:1.5];
//		else {
//			[PHLabelMessage showMessageLable:_(@"Loading...") inView:self.view withTimeInterval:1.5];
//		}
	}
}

#pragma mark - dealloc

- (void)dealloc
{
	[_bannerView release];
	[_banners release];
	
	[super dealloc];
}

@end
