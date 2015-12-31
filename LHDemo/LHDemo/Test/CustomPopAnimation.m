//
//  CustomPopAnimation.m
//  LHDemo
//
//  Created by leihui on 15/11/30.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "CustomPopAnimation.h"
#import "PushPopCollectionViewController.h"
#import "PushDetailViewController.h"

@interface CustomPopAnimation ()

@end

@implementation CustomPopAnimation

#pragma mark - UIViewControllerAnimatedTransitioning

// 指定转场动画持续的时长
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
	return 0.5;
}

// 转场动画的具体内容
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
	PushDetailViewController *fromVC = (PushDetailViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	PushPopCollectionViewController *toVC = (PushPopCollectionViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIView *containerView = [transitionContext containerView];
	
	UIView *snapshotView = [fromVC.detailImageView snapshotViewAfterScreenUpdates:NO];
	snapshotView.frame = [containerView convertRect:fromVC.detailImageView.frame fromView:fromVC.view];
	fromVC.detailImageView.hidden = YES;
	
	toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
	toVC.selectedCell.imageView.hidden = YES;
	
	[containerView insertSubview:toVC.view belowSubview:fromVC.view];
	[containerView addSubview:snapshotView];
	
	[UIView animateWithDuration:[self transitionDuration:transitionContext]
						  delay:0.f
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^{
						 snapshotView.frame = [containerView convertRect:toVC.selectedCell.imageView.frame fromView:toVC.selectedCell];
						 fromVC.view.alpha = 0.f;
					 } completion:^(BOOL finished) {
						 toVC.selectedCell.imageView.hidden = NO;
						 [snapshotView removeFromSuperview];
						 fromVC.detailImageView.hidden = NO;
						 
						 [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
					 }];
}

@end
