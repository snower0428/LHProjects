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

@interface DemoViewController ()
{
	NSTimer			*_timer;
}

@property (nonatomic, retain) UINavigationController *navCtrl;

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
    
#if 0
    // Gradient progress demo
    GradientView *view = [[GradientView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    [view release];
#endif
    
#if 1
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
	
	[self comparaBlock2];
	
//	[self startTimer];
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

#pragma mark - Pirvate

- (void)initNavigationItem
{
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(btnClicked:)];
	self.navigationItem.rightBarButtonItem = rightItem;
	[rightItem release];
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
	
	Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
	Method swappedMethod = class_getInstanceMethod([NSString class], @selector(myLowercaseString));
	method_exchangeImplementations(originalMethod, swappedMethod);
	
	NSString *str = @"Hello World!!!";
	NSLog(@"lower:%@", [str lowercaseString]);
	
	//
	TestViewController *ctrl = [[[TestViewController alloc] init] autorelease];
	UINavigationController *navCtrl = [[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease];
	[self presentViewController:navCtrl animated:YES completion:nil];
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
	
	_timer = [[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES] retain];
}

- (void)stopTimer
{
	if (_timer) {
		[_timer invalidate];
		[_timer release];
		_timer = nil;
	}
}

- (void)onTimer:(NSTimer *)timer
{
	BOOL hasNetwork = [[PHNetworkManager sharedInstance] connectedToNetwork];
	NSLog(@"hasNetwork: %d", hasNetwork);
}

#pragma mark - dealloc

- (void)dealloc
{
	[self stopTimer];
	
	self.navCtrl = nil;
	
    [super dealloc];
}

@end
