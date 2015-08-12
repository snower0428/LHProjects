//
//  PopSpringViewController.m
//  LHDemo
//
//  Created by leihui on 15/8/12.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PopSpringViewController.h"

@interface PopSpringViewController ()
{
	UIImageView		*_imageView;
	BOOL			_bChanged;
}

@end

@implementation PopSpringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"Spring";
	self.view.backgroundColor = [UIColor whiteColor];
	
	if (SYSTEM_VERSION >= 7.0) {
		if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
			[self setEdgesForExtendedLayout:UIRectEdgeNone];
		}
	}
	
	[self createNavigationItem];
	
	CGFloat width = 100.f;
	CGFloat height = 80.f;
	CGFloat leftMargin = (SCREEN_WIDTH-width)/2;
	CGFloat topMargin = 100.f;
	
	CGRect frame = CGRectMake(leftMargin, topMargin, width, height);
	
	_imageView = [[UIImageView alloc] initWithFrame:frame];
	_imageView.backgroundColor  = [UIColor clearColor];
	_imageView.image = [UIImage imageNamed:@"image.png"];
	[self.view addSubview:_imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)createNavigationItem
{
	UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightAction:)];
	self.navigationItem.rightBarButtonItem = rightItem;
	[rightItem release];
}

- (void)rightAction:(id)sender
{
#if 0
	POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
	
	CGRect rect = _imageView.frame;
	if (rect.size.width > 100.f) {
		animation.toValue = [NSValue valueWithCGSize:CGSizeMake(100, 100)];
	}
	else {
		animation.toValue = [NSValue valueWithCGSize:CGSizeMake(300, 300)];
	}
	
	// 弹性值
	animation.springBounciness = 20.0;
	
	// 弹性速度
	animation.springSpeed = 20.0;
	
	[_imageView.layer pop_addAnimation:animation forKey:@"ChangeSize"];
#endif
	
#if 1
	POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
	
	_bChanged = !_bChanged;
	if (_bChanged) {
		animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_imageView.center.x, 0)];
	}
	else {
		animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_imageView.center.x, 300)];
	}
	
	// 弹性值
	animation.springBounciness = 20.0;
	
	// 弹性速度
	animation.springSpeed = 20.0;
	
	[_imageView.layer pop_addAnimation:animation forKey:@"ChangePosition"];
#endif
}

#pragma mark - dealloc

- (void)dealloc
{
	[_imageView release];
	
	[super dealloc];
}

@end
