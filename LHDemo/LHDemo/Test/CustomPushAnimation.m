//
//  CustomPushAnimation.m
//  LHDemo
//
//  Created by leihui on 15/11/30.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "CustomPushAnimation.h"
#import "PushPopCollectionViewController.h"
#import "PushDetailViewController.h"

@interface CustomPushAnimation ()

@end

@implementation CustomPushAnimation

#pragma mark - UIViewControllerAnimatedTransitioning

// 指定转场动画持续的时长
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return 0.5;
}

// 转场动画的具体内容
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
	// 获取源ViewControl和目标ViewControl
	PushPopCollectionViewController *fromVC = (PushPopCollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	PushDetailViewController *toVC = (PushDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *containerView = [transitionContext containerView];
	
	// 创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
	UIView *snapshotView = [fromVC.selectedCell.imageView snapshotViewAfterScreenUpdates:NO];
	snapshotView.frame = [containerView convertRect:fromVC.selectedCell.imageView.frame fromView:fromVC.selectedCell];
	fromVC.selectedCell.imageView.hidden = YES;
	
	// 设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
	toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
	toVC.view.alpha = 0.f;
	
	// 都添加到 container 中。注意顺序不能错了
	[containerView addSubview:toVC.view];
	[containerView addSubview:snapshotView];
	
	//5.执行动画
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  delay:0.f
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 snapshotView.frame = toVC.detailImageView.frame;
						 toVC.view.alpha = 1.f;
					 } completion:^(BOOL finished) {
						 toVC.detailImageView.image = toVC.detailImage;
						 [snapshotView removeFromSuperview];
						 
						 // 一定要记得动画完成后执行此方法，让系统管理 navigation
						 [transitionContext completeTransition:YES];
					 }];
}

@end
