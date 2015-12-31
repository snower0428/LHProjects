//
//  PushPopCollectionViewController.m
//  LHDemo
//
//  Created by leihui on 15/11/30.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PushPopCollectionViewController.h"
#import "PushDetailViewController.h"
#import "CustomPushAnimation.h"

@interface PushPopCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PushPopCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	if (SYSTEM_VERSION >= 7.0) {
		if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
			[self setEdgesForExtendedLayout:UIRectEdgeNone];
		}
	}
	
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
	
	self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
	self.collectionView.dataSource = self;
	self.collectionView.delegate = self;
	[self.view addSubview:self.collectionView];
    
    // Register cell classes
    [self.collectionView registerClass:[PushPopCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
	
	self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PushPopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
	if (!cell) {
		NSLog(@"error ......");
	}
	cell.imageView.image = [UIImage imageNamed:@"cat1.jpg"];
	cell.label.text = [NSString stringWithFormat:@"Cell:%ld", indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	MLOG(@"Line:%ld", indexPath.row);
	
	self.selectedCell = (PushPopCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
	
#if 1
	PushDetailViewController *ctrl = [[PushDetailViewController alloc] init];
	ctrl.detailImage = self.selectedCell.imageView.image;
	[self.navigationController pushViewController:ctrl animated:YES];
#endif
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake((self.view.frame.size.width-20)/2, (self.view.frame.size.width-20)/2+50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
	return 0;
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
								   animationControllerForOperation:(UINavigationControllerOperation)operation
												fromViewController:(UIViewController *)fromVC
												  toViewController:(UIViewController *)toVC
{
	if (operation == UINavigationControllerOperationPush) {
		return [[CustomPushAnimation alloc] init];
	}
	else {
		return nil;
	}
}

@end
