//
//  PushDetailViewController.m
//  LHDemo
//
//  Created by leihui on 15/12/1.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PushDetailViewController.h"
#import "CustomPushAnimation.h"
#import "CustomPopAnimation.h"

@interface PushDetailViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@end

@implementation PushDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.f, 74.f, self.view.frame.size.width-10.f*2, 300.f)];
	[self.view addSubview:self.detailImageView];
	
	NSString *strText = @"微博直播系统今天终于上线了，本打算早点开启的，因为公司业务临近年底业务较为集中，终于现在告一段落了，以后我尽量不间断坚持下去。我在今天上午直播中提出大盘重要压力3470点后，大盘就开始一路探底到3375点的时候我提出此处为超短线的极佳抄底机会。然后大盘再次探底到3327点后就展开了反弹，最终以微涨缩量报收，基本符合缩量止跌的特征。之所以说基本，是因为我还不认为这个位置缩量达到让我满意的程度，只是一个开始缩量的过程，并且今天收出的一个锤头K线，在技术上来讲，对底部还有一个确定的过程，所以针对于今天抄底介入的股票，明天也可以考虑冲高继续出局，等到大盘如果能在周三缩量到2444亿水平的时候再考虑介入，或许为一个不错的选择。";
	
	CGRect labelFrame = CGRectMake(10.f, CGRectGetMaxY(self.detailImageView.frame)+10.f, self.detailImageView.frame.size.width, 150.f);
	
	UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
	label.backgroundColor = [UIColor clearColor];
	label.numberOfLines = 0;
	label.text = strText;
	label.font = [UIFont systemFontOfSize:10.f];
	[self.view addSubview:label];
	
	self.navigationController.delegate = self;
	
	// 手势
	UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
	edgePanGesture.edges = UIRectEdgeLeft;
	[self.view addGestureRecognizer:edgePanGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScreenEdgePanGestureRecognizer

- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePanGesture
{
	CGFloat progress = [edgePanGesture translationInView:self.view].x / self.view.frame.size.width;
	
	if (edgePanGesture.state == UIGestureRecognizerStateBegan) {
		self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
		[self.navigationController popViewControllerAnimated:YES];
	}
	else if (edgePanGesture.state == UIGestureRecognizerStateChanged) {
		[self.percentDrivenTransition updateInteractiveTransition:progress];
	}
	else if (edgePanGesture.state == UIGestureRecognizerStateCancelled || edgePanGesture.state == UIGestureRecognizerStateEnded) {
		if (progress > 0.5) {
			[self.percentDrivenTransition finishInteractiveTransition];
		}
		else {
			[self.percentDrivenTransition cancelInteractiveTransition];
		}
		self.percentDrivenTransition = nil;
	}
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
								   animationControllerForOperation:(UINavigationControllerOperation)operation
												fromViewController:(UIViewController *)fromVC
												  toViewController:(UIViewController *)toVC
{
	if (operation == UINavigationControllerOperationPop) {
		return [[CustomPopAnimation alloc] init];
	}
	else {
		return nil;
	}
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
						  interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
	if ([animationController isKindOfClass:[CustomPushAnimation class]]) {
		return self.percentDrivenTransition;
	}
	else {
		return nil;
	}
}

#pragma mark - dealloc

- (void)dealloc
{
	MLOG(@"dealloc");
	
	self.detailImageView = nil;
	self.detailImage = nil;
}

@end
