//
//  ViewController.m
//  LHTravel
//
//  Created by leihui on 15/5/12.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "ViewController.h"
#import "LHHomeViewController.h"
#import "LHSpecialViewController.h"
#import "LHMineViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = [UIColor orangeColor];
	
	if (SYSTEM_VERSION >= 7.0) {
		if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
			[self setEdgesForExtendedLayout:UIRectEdgeNone];
		}
	}
	
	[self initControllers];
	
	if (SYSTEM_VERSION >= 7.0) {
		[[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
															  [UIFont systemFontOfSize:18], UITextAttributeFont,
															  [UIColor colorWithRed:124/255.0 green:131/255.0 blue:217/255.0 alpha:1], UITextAttributeTextColor,
															  nil]];
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)initControllers
{
	NSArray *arrayCtrlName = @[@"LHHomeViewController", @"LHSpecialViewController", @"LHMineViewController"];
	NSArray *arrayTitle = @[@"首页", @"特别的", @"我的"];
	NSArray *arrayImageName = @[@"TabBar/Home.png", @"TabBar/Special.png", @"TabBar/Mine.png"];
	NSMutableArray *arrayImage = [NSMutableArray array];
	
	for (NSInteger i = 0; i < [arrayImageName count]; i++) {
		NSString *imageName = [arrayImageName objectAtIndex:i];
		UIImage *image = getResource(imageName);
		if (image) {
			[arrayImage addObject:image];
		}
	}
	
	NSMutableArray *arrayCtrl = [NSMutableArray array];
	
	for (NSInteger i = 0; i < [arrayCtrlName count]; i++) {
		
		NSString *ctrlName = nil;
		NSString *title = nil;
		UIImage *image = nil;
		
		if (i < [arrayCtrlName count]) {
			ctrlName = [arrayCtrlName objectAtIndex:i];
		}
		if (i < [arrayTitle count]) {
			title = [arrayTitle objectAtIndex:i];
		}
		if (i < [arrayImage count]) {
			image = [arrayImage objectAtIndex:i];
		}
		
		UIViewController *ctrl = [self controllerWithControllerName:ctrlName title:title tabImage:image tag:i];
		if (ctrl) {
			[arrayCtrl addObject:ctrl];
		}
	}
	
	self.viewControllers = arrayCtrl;
}

- (UIViewController *)controllerWithControllerName:(NSString *)ctrlName title:(NSString *)title tabImage:(UIImage *)image tag:(NSInteger)tag
{
	Class cls = NSClassFromString(ctrlName);
	UIViewController *ctrl = [[[cls alloc] init] autorelease];
	if (ctrl && [ctrl isKindOfClass:[UIViewController class]]) {
		ctrl.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:tag];
		ctrl.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
	}
	
	return ctrl;
}

#pragma mark - dealloc

- (void)dealloc
{
	[super dealloc];
}

@end
