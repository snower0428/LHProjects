//
//  DemoViewController.m
//  LHDemo
//
//  Created by leihui on 13-9-13.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import "DemoViewController.h"
#import "GradientView.h"
#import "Foo.h"
#import "NSObject+MethodSwizzing.h"
#import <objc/runtime.h>

#import "WiFiScanner.h"
#import "KeychainDemoViewCtrl.h"
#import "EOCAutoDictionary.h"
#import "PHNetworkManager.h"
#import "TestViewController.h"
#import "iCarousel.h"
#import "PTVerticalLabel.h"
#import "PTImageButton.h"

#import "FXBlurView.h"

#import <QuartzCore/QuartzCore.h>

NSComparator comparator = ^(id obj1, id obj2) {
	if ([obj1 integerValue] > [obj2 integerValue]) {
		return (NSComparisonResult)NSOrderedDescending;
	}
	if ([obj1 integerValue] < [obj2 integerValue]) {
		return (NSComparisonResult)NSOrderedAscending;
	}
	return NSOrderedSame;
};

@implementation NSString (MyLower)

- (NSString *)myLowercaseString
{
	NSString *lowercase = [self myLowercaseString];
	NSLog(@"%@ => %@", self, lowercase);
	return lowercase;
}

int func(int count)
{
	return count*2;
}

int (*funcptr)(int) = &func;

@end

@interface DemoViewController () <iCarouselDataSource, iCarouselDelegate>
{
	NSTimer			*_timer;
}

@property (nonatomic, retain) UINavigationController *navCtrl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) iCarousel *carousel;

@end

@implementation DemoViewController

- (id)init
{
	self = [super init];
	if (self) {
		// Init
		NSLog(@"%@", NSStringFromClass([self class]));
		NSLog(@"%@", NSStringFromClass([super class]));
		NSLog(@"%@", NSStringFromClass([self superclass]));
		NSLog(@"%@", NSStringFromClass([[self superclass] class]));
		
		BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
		BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
		BOOL res3 = [(id)[DemoViewController class] isKindOfClass:[DemoViewController class]];
		BOOL res4 = [(id)[DemoViewController class] isMemberOfClass:[DemoViewController class]];
		
		NSLog(@"res1:%d, res2:%d, res3:%d, res4:%d", res1, res2, res3, res4);
		
		//
		NSLog(@"funcptr>>>>>:%d", (*funcptr)(10));
		NSLog(@"fun>>>>>:%d", func(10));
	}
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
	
	if (SYSTEM_VERSION >= 7.0) {
		if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
			[self setEdgesForExtendedLayout:UIRectEdgeNone];
		}
	}
	
#if 0
    // Gradient progress demo
    GradientView *view = [[GradientView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    [view release];
#endif
    
#if 0
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(20, 100, self.view.frame.size.width-20*2, 100);
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
	button.layer.cornerRadius = 8.f;
	button.layer.borderColor = [UIColor orangeColor].CGColor;
	button.layer.borderWidth = 1.f;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
#endif
	
	[self initNavigationItem];
	
//	[self comparaBlock2];
	
//	[self startTimer];
	
#if 0
	_pageIndex = 0;
	self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 180, SCREEN_WIDTH, 190)];
	[_scrollView setContentSize:CGSizeMake(480, 190)];
	_scrollView.contentInset = UIEdgeInsetsMake(0, 80, 0, 80);
	_scrollView.pagingEnabled = NO;
	_scrollView.delegate = self;
	[self.view addSubview:_scrollView];
	
	for (NSInteger i = 0; i < 3; i++) {
		CGRect frame = CGRectMake(i*160, 0, 160, 190);
		
		UIView *view = [[UIView alloc] initWithFrame:frame];
		view.backgroundColor = kRandomColor;
		[_scrollView addSubview:view];
	}
#endif
	
#if 0
	self.carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 200)];
	self.carousel.backgroundColor = [UIColor orangeColor];
	self.carousel.dataSource = self;
	self.carousel.delegate = self;
	self.carousel.pagingEnabled = YES;
	[self.view addSubview:self.carousel];
#endif
	
#if 0
	NSString* str = @"去年今日此门中，人面桃花相映红；人面不知何处去，桃花依旧笑春风。";
	UIFont* font = [UIFont systemFontOfSize:14.f];
	CGSize size = [str sizeWithFont:font constrainedToSize:CGSizeMake(25.0f, 460-44) lineBreakMode:NSLineBreakByWordWrapping];
	NSLog(@"size.height=%f,%f",size.height,size.width);
	NSMutableArray* array = [[NSMutableArray alloc]initWithCapacity:0];
	
	for (int i = 0; i < 4; i ++) {
		NSString* substr=[str substringWithRange:NSMakeRange(i*8, 8)];
		[array addObject:substr];
	}
	for (int i = 0;i < array.count; i++) {
		UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(220-(size.width+15)*(i+1),10, size.width, size.height)];
		label.text = [array objectAtIndex:i];
		label.numberOfLines = 0;
		label.font = font;
		label.textColor = [UIColor purpleColor];
		label.backgroundColor = [UIColor clearColor];
		label.shadowColor = [UIColor colorWithWhite:0.4 alpha:0.8];
		label.shadowOffset = CGSizeMake(1.0f, 2.0f);
		[self.view addSubview:label];
	}
#endif
	
#if 0
	PTVerticalLabel *label = [[PTVerticalLabel alloc] initWithFrame:CGRectMake(10, 10, 100, 300)];
	label.backgroundColor = [UIColor orangeColor];
	label.text = @"测试竖直排列文字！";
//	label.text = @"去年今日此门中，人面桃花相映红；人面不知何处去，桃花依旧笑春风。";
	label.textAlignment = PTVerticalTextAlignmentCenter;
	[self.view addSubview:label];
#endif
	
#if 0
	// NSArray排序
	NSArray *sortArray = @[@"1",@"3",@"4",@"7",@"8",@"2",@"6",@"5",@"13",@"15",@"12",@"20",@"28",@""];
	
	// 排序前
	NSMutableString *outputBefore = [[NSMutableString alloc] init];
	for (NSString *str in sortArray) {
		[outputBefore appendFormat:@"%@,", str];
	}
	NSLog(@"排序前：%@", outputBefore);
	
	// 排序后
	NSArray *array = [sortArray sortedArrayUsingComparator:comparator];
	
	NSMutableString *outputAfter = [[NSMutableString alloc] init];
	for (NSString *str in array) {
		[outputAfter appendFormat:@"%@,", str];
	}
	NSLog(@"排序后：%@", outputAfter);
#endif
	
#if 0
	CGFloat btnWidth = 100.f;
	CGFloat btnHeigh = 64.f;
	CGFloat leftMargin = (SCREEN_WIDTH-btnWidth)/2;
	CGFloat topMargin = 100.f;
	CGFloat imageWidth = 24.f;
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(leftMargin, topMargin, btnWidth, btnHeigh);
	button.backgroundColor = [UIColor orangeColor];
	[button setImage:getResource(@"emoji.png") forState:UIControlStateNormal];
	[button setTitle:@"表情" forState:UIControlStateNormal];
	[self.view addSubview:button];
	
	CGSize titleSize = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
	button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
	button.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width, 0, -titleSize.width);
#endif
	
#if 0
	CGFloat btnWidth = 150.f;
	CGFloat btnHeigh = 64.f;
	CGFloat leftMargin = (SCREEN_WIDTH-btnWidth)/2;
	CGFloat topMargin = 50.f;
	CGFloat yInterval = 10.f;
	
	for (NSInteger i = 0; i < 4; i++) {
		CGRect btnFrame = CGRectMake(leftMargin, topMargin+(btnHeigh+yInterval)*i, btnWidth, btnHeigh);
		
		PTImageButton *button = [PTImageButton buttonWithImage:getResource(@"emoji.png") title:@"表情键盘表情键盘"];
		button.backgroundColor = [UIColor orangeColor];
		button.frame = btnFrame;
		button.imageButtonType = (PTImageButtonType)(PTImageButtonImageLeft+i);
		//button.interval = 10.f;
		//button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		//button.imageSize = CGSizeMake(24.f, 24.f);
		button.titleFont = [UIFont systemFontOfSize:12.f];
		[self.view addSubview:button];
	}
#endif
	
#if 0
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	imageView.image = [UIImage imageNamed:@"cat1.jpg"];
	[self.view addSubview:imageView];
	
	CGFloat width = 200.f;
	CGFloat height = 200.f;
	CGFloat leftMargin = (self.view.frame.size.width-width)/2;
	
	FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(leftMargin, 100.f, width, height)];
	blurView.tintColor = [UIColor blackColor];
	blurView.blurRadius = 0;
	[self.view addSubview:blurView];
	
	CAGradientLayer *gradientLayer = [CAGradientLayer layer];
	gradientLayer.frame = blurView.bounds;
	gradientLayer.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor];
	[blurView.layer addSublayer:gradientLayer];
#endif
	
#if 1
	self.view.backgroundColor = RGB(60, 60, 65);
	
	CGFloat leftMargin = 5.f*iPhoneWidthScaleFactor;
	CGFloat topMargin = 10.f*iPhoneWidthScaleFactor;
	CGFloat width = 100.f*iPhoneWidthScaleFactor;
	CGFloat height = 150.f*iPhoneWidthScaleFactor;
	CGFloat xInterval = 5.f*iPhoneWidthScaleFactor;
	
	for (NSInteger i = 0; i < 3; i++) {
		CGRect frame = CGRectMake(leftMargin+(width+xInterval)*i, topMargin, width, height);
		NSString *imageName = [NSString stringWithFormat:@"cat%d.jpg", (int)i+1];
		
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
		//imageView.backgroundColor = [UIColor orangeColor];
		imageView.image = [UIImage imageNamed:imageName];
		imageView.contentMode = UIViewContentModeScaleAspectFill;
		imageView.clipsToBounds = YES;
		[self.view addSubview:imageView];
		
		for (NSInteger i = 0; i < 5; i++) {
			CGFloat blurViewHeight = height/5;
			FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, height-40.f+(blurViewHeight)*i, width, blurViewHeight)];
			blurView.tintColor = [UIColor blackColor];
			blurView.blurRadius = i*4+1;
			[imageView addSubview:blurView];
		}
		
		CAGradientLayer *gradientLayer = [CAGradientLayer layer];
		gradientLayer.frame = imageView.bounds;
		gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor whiteColor].CGColor];
		gradientLayer.locations = @[@(0.3), @(1.0)];
		[imageView.layer addSublayer:gradientLayer];
	}
#endif
	
#if 0
	self.view.backgroundColor = RGB(60, 60, 65);
	
	
	CGFloat topMargin = 100.f;
	CGFloat width = 200.f;
	CGFloat height = 200.f;
	CGFloat leftMargin = (SCREEN_WIDTH-width)/2;
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	imageView.image = [UIImage imageNamed:@"cat1.jpg"];
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	[self.view addSubview:imageView];
	
	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
	
	UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	blurView.frame = CGRectMake(leftMargin, topMargin, width, height);
	[self.view addSubview:blurView];
#endif
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
	NSInteger pageWidth = 160;
	NSInteger pageX = _pageIndex*pageWidth-scrollView.contentInset.left;
	if (targetContentOffset->x < pageX) {
		if (_pageIndex > 0) {
			_pageIndex--;
		}
	}
	else if (targetContentOffset->x > pageX) {
		if (_pageIndex < 3) {
			_pageIndex++;
		}
	}
	targetContentOffset->x = _pageIndex*pageWidth - scrollView.contentInset.left;
	NSLog(@"%d ----- %d", (int)_pageIndex, (int)targetContentOffset->x);
}

#pragma mark - Pirvate

- (void)initNavigationItem
{
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(btnClicked:)];
	self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)btnClicked:(id)sender
{
#if 0
	Foo *foo = [[[Foo alloc] init] autorelease];
	Bar *bar = [[[Bar alloc] init] autorelease];
	
	NSLog(@"============================== Method Swizzing test 1 ==============================");
	
	NSLog(@"Step 1");
	[foo testMethod];
	[bar testMethod];
	[bar altTestMethod];
	
	NSLog(@"Step 2");
	[Bar swizzingMethod:@selector(testMethod) withMethod:@selector(altTestMethod)];
	[foo testMethod];
	[bar testMethod];
	[bar altTestMethod];
	
	NSLog(@"============================== Method Swizzing test 2 ==============================");
	NSLog(@"Step 1");
	[foo baseMethod];
	[bar baseMethod];
	[bar altBaseMethod];
	
	NSLog(@"Step 2");
	[Bar swizzingMethod:@selector(baseMethod) withMethod:@selector(altBaseMethod)];
	[foo baseMethod];
	[bar baseMethod];
	[bar altBaseMethod];
	
	NSLog(@"============================== Method Swizzing test 3 ==============================");
	[Bar swizzingMethod:@selector(recursionMethod) withMethod:@selector(altRecursionMethod)];
	[bar recursionMethod];
	
#endif
	
	NSLog(@"============================== _cmd:%@ ==============================", NSStringFromSelector(_cmd));
	
#if 0
	if (!self.navCtrl) {
		KeychainDemoViewCtrl *ctrl = [[[KeychainDemoViewCtrl alloc] init] autorelease];
		self.navCtrl = [[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease];
	}
	
	static NSInteger count = 0;
	
	if (count%2 == 0) {
		[self.navigationController addChildViewController:self.navCtrl];
		self.navCtrl.view.frame = self.navigationController.view.frame;
		[self.navigationController.view addSubview:self.navCtrl.view];
		[self.navCtrl didMoveToParentViewController:self.navigationController];
		
		self.navCtrl.view.alpha = 0.f;
		
		[UIView animateWithDuration:0.5
							  delay:0.f
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^{
							 self.navCtrl.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
							 self.navCtrl.view.alpha = 1.f;
						 } completion:^(BOOL finished) {
							 
						 }];
	}
	else {
		[self.navCtrl willMoveToParentViewController:nil];
		[self.navCtrl.view removeFromSuperview];
		[self.navCtrl removeFromParentViewController];
		
		self.navCtrl = nil;
	}
	
	count++;
#endif
	
	
#if 0
	static CGFloat tx = 0;
	static CGFloat ty = 0;
	static CGFloat tz = 0;
	
	tx += 10;
	ty += 10;
	tz += 10;
	
	static CGFloat angle = 0;
	angle += M_PI_2/3;
	
	UIButton *btn = (UIButton *)sender;
	[UIView animateWithDuration:0.5
					 animations:^{
						 CATransform3D transform = CATransform3DIdentity;
						 transform.m34 = 2.5 / -2000;
						 
						 CATransform3D transform3D = CATransform3DRotate(transform, angle, 1, 0, 0);
						 btn.layer.transform = transform3D;
					 }
					 completion:nil];
#endif
	
#if 0
	Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
	Method swappedMethod = class_getInstanceMethod([NSString class], @selector(myLowercaseString));
	method_exchangeImplementations(originalMethod, swappedMethod);
	
	NSString *str = @"Hello World!!!";
	NSLog(@"lower:%@", [str lowercaseString]);
	
	//
	TestViewController *ctrl = [[[TestViewController alloc] init] autorelease];
	UINavigationController *navCtrl = [[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease];
	[self presentViewController:navCtrl animated:YES completion:nil];
#endif
}

- (void)comparaBlock
{
	NSArray *stringsArray = [NSArray arrayWithObjects:
							 @"string 1",
							 @"String 21",
							 @"string 12",
							 @"String 11",
							 @"String 02",
							 nil];
	
	static NSStringCompareOptions compareOptions = NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
	NSLocale *currentLocale = [NSLocale currentLocale];
	
	NSComparator finderSortBlock = ^(id string1, id string2) {
		
		NSRange string1Range = NSMakeRange(0, [string1 length]);
		NSComparisonResult result = [string1 compare:string2 options:compareOptions range:string1Range locale:currentLocale];
		
		return result;
	};
	
	NSArray *finderSortArray = [stringsArray sortedArrayUsingComparator:finderSortBlock];
	NSLog(@"finderSortArray:%@", finderSortArray);
}

- (void)comparaBlock2
{
	NSArray *stringsArray = [NSArray arrayWithObjects:
							 @"string 1",
							 @"String 21",
							 @"string 12",
							 @"String 11",
							 @"String 21",
							 @"String 21",
							 @"String 02",
							 nil];
	
	NSLocale *currentLocale = [NSLocale currentLocale];
	__block NSUInteger orderedSameCount = 0;
	
	NSArray *sortedArray = [stringsArray sortedArrayUsingComparator:^NSComparisonResult(id string1, id string2) {
		
		NSRange string1Range = NSMakeRange(0, [string1 length]);
		NSComparisonResult result = [string1 compare:string2 options:NSDiacriticInsensitiveSearch range:string1Range locale:currentLocale];
		if (result == NSOrderedSame) {
			orderedSameCount++;
		}
		return  result;
	}];
	
	NSLog(@"sortedArray:%@", sortedArray);
	NSLog(@"orderedSameCount:%d", (int)orderedSameCount);
}

- (void)startTimer
{
	[self stopTimer];
	
	_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
	if (_timer) {
		[_timer invalidate];
		_timer = nil;
	}
}

- (void)onTimer:(NSTimer *)timer
{
	BOOL hasNetwork = [[PHNetworkManager sharedInstance] connectedToNetwork];
	NSLog(@"hasNetwork: %d", hasNetwork);
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
	return 6;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
	UILabel *label = nil;
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
		CGFloat height = 100.f*iPhoneWidthScaleFactor;
		view = [[UIImageView alloc] initWithFrame:CGRectMake(0, height/2, height, height)];
		view.contentMode = UIViewContentModeCenter;
		label = [[UILabel alloc] initWithFrame:view.bounds];
		label.backgroundColor = [UIColor blueColor];
		label.textAlignment = UITextAlignmentCenter;
		label.font = [label.font fontWithSize:50];
		label.tag = 1;
		[view addSubview:label];
	}
	else
	{
		//get a reference to the label in the recycled view
		label = (UILabel *)[view viewWithTag:1];
	}
	
	//set item label
	//remember to always set any properties of your carousel item
	//views outside of the `if (view == nil) {...}` check otherwise
	//you'll get weird issues with carousel item content appearing
	//in the wrong place in the carousel
	label.text = [NSString stringWithFormat:@"%d", (int)index];
	
	return view;
}

//- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel;
//- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(nullable UIView *)view;

#pragma mark - iCarouselDelegate

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
	//customize carousel display
	switch (option)
	{
		case iCarouselOptionWrap:
		{
			//normally you would hard-code this to YES or NO
			return NO;
		}
		case iCarouselOptionSpacing:
		{
			//add a bit of spacing between the item views
			return value * 1.05f;
		}
		case iCarouselOptionFadeMax:
		{
			return value;
		}
		case iCarouselOptionShowBackfaces:
		case iCarouselOptionRadius:
		case iCarouselOptionAngle:
		case iCarouselOptionArc:
		case iCarouselOptionTilt:
		case iCarouselOptionCount:
		case iCarouselOptionFadeMin:
		case iCarouselOptionFadeMinAlpha:
		case iCarouselOptionFadeRange:
		case iCarouselOptionOffsetMultiplier:
		case iCarouselOptionVisibleItems:
		{
			return value;
		}
	}
}

#pragma mark - dealloc

- (void)dealloc
{
	[self stopTimer];
	
	self.navCtrl = nil;
}

@end
