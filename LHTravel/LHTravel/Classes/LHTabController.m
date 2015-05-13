//
//  LHTabController.m
//  LHTravel
//
//  Created by leihui on 15/5/13.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHTabController.h"

#define kNewFeaturesTag     1440

@interface LHTabController ()

@end

@implementation LHTabController

- (void)reCreateWithImageArray:(NSArray *)imageArray
{
	int i = 0;
	for (UIView *v in [self.tabBar subviews])
	{
		MLOG(@"v:%@",v);
		if ([v isKindOfClass:NSClassFromString(@"UITabBarButton")] && i < [imageArray count])
		{
			UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((v.frame.size.width-28)/2, 4, 28, 27)];
			imageView.image = [imageArray objectAtIndex:i];
			
			[v addSubview:imageView];
			if (i == 0) {
				imageView.hidden = YES;
			}
			[imageView release];
			for (UIView *view in [v subviews])
			{
				if ([view isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
				{
					if (i != 0) {
						view.hidden = YES;
					}
				}
				else if ([view isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")])
				{
					((UILabel *)view).textColor = [UIColor whiteColor];
				}
			}
			i++;
		}
	}
}

- (void)showNewFeatureAtIndex:(int)index
{
	if (index > [[self.tabBar subviews] count] -1 ) {
		return;
	}
	int j = 0;
	for (UIView *v in [self.tabBar subviews])
	{
		if ([v isKindOfClass:NSClassFromString(@"UITabBarButton")])
		{
			if (index == j)
			{
				UIImageView *newFeature = [[UIImageView alloc] initWithFrame:CGRectMake(65, 2, 48, 20)];
				newFeature.tag = kNewFeaturesTag;
				[newFeature setImage:[[ResourcesManager sharedInstance] imageWithFileName:@"NewFeatures.png"]];
				[v addSubview:newFeature];
				[newFeature release];
				return;
			}
			j++;
		}
	}
}

- (void)hideNewFeatureAtIndex:(int)index
{
	if (index > [[self.tabBar subviews] count] -1 ) {
		return;
	}
	int j = 0;
	for (UIView *v in [self.tabBar subviews])
	{
		if ([v isKindOfClass:NSClassFromString(@"UITabBarButton")])
		{
			if (index == j)
			{
				UIImageView *newFeature = (UIImageView *)[v viewWithTag:kNewFeaturesTag];
				if ([newFeature isKindOfClass:[UIView class]])
				{
					[newFeature removeFromSuperview];
				}
				return;
			}
			j++;
		}
	}
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	NSInteger tag = tabBarController.selectedIndex;
	int i = 0;
	for (UIView *v  in [self.tabBar subviews])
	{
		if ([v isKindOfClass:NSClassFromString(@"UITabBarButton")])
		{
			MLOG(@"v:%@",v);
			for (UIView *view in [v subviews])
			{
				if ([view isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")])
				{
					if (i != tag) {
						view.hidden = YES;
					}
					else
					{
						view.hidden = NO;
					}
				}
				else if([view isKindOfClass:[UIImageView class]] && ![view isKindOfClass:NSClassFromString(@"UITabBarSelectionIndicatorView")])
				{
					if (i == tag) {
						view.hidden = YES;
					}
					else
					{
						view.hidden = NO;
					}
				}
				else if ([view isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")])
				{
					((UILabel *)view).textColor = [UIColor whiteColor];
				}
			}
			i++;
		}
	}
}


- (void)dealloc
{
	[super dealloc];
}

@end
