//
//  LHTravelDetailViewCtrl.m
//  LHTravel
//
//  Created by leihui on 15/5/27.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHTravelDetailViewCtrl.h"
#import "PagePhotosView.h"

@interface LHTravelDetailViewCtrl () <PagePhotosDataSource, UITableViewDataSource, UITableViewDelegate>
{
	PagePhotosView		*_bannerView;
	NSMutableArray      *_banners;
	
	UITableView			*_tableView;
}

@end

@implementation LHTravelDetailViewCtrl

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
	[self initTableView];
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

- (void)initTableView
{
	CGFloat topMargin = _bannerView.frame.size.height + 64*iPhoneWidthScaleFactor;
	
	_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, topMargin, SCREEN_WIDTH, kAppView_Height-topMargin) style:UITableViewStylePlain];
	_tableView.backgroundColor = [UIColor clearColor];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.showsHorizontalScrollIndicator = NO;
	_tableView.showsVerticalScrollIndicator = NO;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	_tableView.backgroundView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:_tableView];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cellIdentifier";
	
	//    NSInteger row = indexPath.row;
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
		cell.backgroundColor = [UIColor lightGrayColor];
	}
	
//    if (row < <#count#>) {
//        <#do something#>
//    }
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - dealloc

- (void)dealloc
{
	[super dealloc];
}

@end
