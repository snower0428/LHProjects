//
//  PopDemoViewController.m
//  LHDemo
//
//  Created by leihui on 15/8/11.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PopDemoViewController.h"
#import "PopSpringViewController.h"
#import "PopBasicViewController.h"

NS_ENUM(NSInteger, ButtonType) {
	ButtonTypeSpring		= 0,
	ButtonTypeBasic,
};

@interface PopDemoViewController ()
{
	UIImageView		*_imageView;
	UILabel			*_label;
}

@end

@implementation PopDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"Pop";
	self.view.backgroundColor = [UIColor whiteColor];
	
	if (SYSTEM_VERSION >= 7.0) {
		if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
			[self setEdgesForExtendedLayout:UIRectEdgeNone];
		}
	}
	
#if 0
	[self createNavigationItem];
	
	CGFloat width = 30.f;
	CGFloat height = 30.f;
	CGFloat leftMargin = 0.f;//(SCREEN_WIDTH-width)/2;
	CGFloat topMargin = 100.f;
	
	CGRect frame = CGRectMake(leftMargin, topMargin, width, height);
	
	_imageView = [[UIImageView alloc] initWithFrame:frame];
	_imageView.backgroundColor  = [UIColor clearColor];
	//[self.view addSubview:_imageView];
	
	height = 80.f;
	frame = CGRectMake(leftMargin, topMargin, SCREEN_WIDTH, height);
	
	_label = [[UILabel alloc] initWithFrame:frame];
	_label.backgroundColor = [UIColor clearColor];
	_label.textAlignment = NSTextAlignmentCenter;
	_label.font = [UIFont boldSystemFontOfSize:30.f];
	[self.view addSubview:_label];
#endif
	
	NSArray *arrayName = @[@"Spring", @"Basic"];
	
	CGFloat topMargin = 100.f;
	CGFloat height = 40.f;
	
	for (NSInteger i = 0; i < [arrayName count]; i++) {
		CGRect frame = CGRectMake(0, topMargin+height*i, SCREEN_WIDTH, height);
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.tag = ButtonTypeSpring + i;
		button.frame = frame;
		[button setTitle:arrayName[i] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		[self.view addSubview:button];
		[button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
	}
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
	POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
	animation.fromValue = @(0.0);
	animation.toValue = @(1.0);
	[_imageView pop_addAnimation:animation forKey:@"fade123"];
#endif
	
#if 0
	POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
	animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, _imageView.frame.origin.y, SCREEN_WIDTH, SCREEN_WIDTH)];
	[_imageView.layer pop_addAnimation:animation forKey:@"size"];
#endif
	
#if 0
	POPDecayAnimation *animation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
	animation.velocity = @(100.0);
	[_imageView.layer pop_addAnimation:animation forKey:@"slide"];
#endif
	
#if 0
	POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
	animation.toValue = @(_imageView.frame.origin.x+300);
	animation.beginTime = CACurrentMediaTime();
	animation.duration = 2.0;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	[_imageView pop_addAnimation:animation forKey:@"position"];
#endif
	
#if 0
	POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
	animation.toValue = @(_imageView.frame.origin.x+300);
	animation.beginTime = CACurrentMediaTime() + 1.0f;
	animation.springBounciness = 10.f;
	[_imageView pop_addAnimation:animation forKey:@"position"];
#endif
	
#if 0
	POPDecayAnimation *animation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
	animation.velocity = @(600);
	animation.beginTime = CACurrentMediaTime() + 1.0f;
	[_imageView.layer pop_addAnimation:animation forKey:@"position"];
#endif
	
	POPAnimatableProperty *property = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
		prop.writeBlock = ^(id obj, const CGFloat values[]) {
			UILabel *label = (UILabel *)obj;
			label.text = [NSString stringWithFormat:@"%02d:%02d:%02d", (int)values[0]/60, (int)values[0]%60, (int)(values[0]*100)%100];
		};
	}];
	
	POPBasicAnimation *animation = [POPBasicAnimation linearAnimation];
	animation.property = property;
	animation.fromValue = @(0);
	animation.toValue = @(3*60);
	animation.duration = 3*60;
	animation.beginTime = CACurrentMediaTime() + 1.0f;
	[_label pop_addAnimation:animation forKey:@"countdown"];
}

- (void)btnAction:(id)sender
{
	NSInteger btnTag = ((UIButton *)sender).tag;
	switch (btnTag) {
		case ButtonTypeSpring:
		{
			PopSpringViewController *ctrl = [[[PopSpringViewController alloc] init] autorelease];
			[self.navigationController pushViewController:ctrl animated:YES];
			break;
		}
		case ButtonTypeBasic:
		{
			PopBasicViewController *ctrl = [[[PopBasicViewController alloc] init] autorelease];
			[self.navigationController pushViewController:ctrl animated:YES];
			break;
		}
		default:
			break;
	}
}

#pragma mark - dealloc

- (void)dealloc
{
	[_imageView release];
	[_label release];
	
	[super dealloc];
}

@end
