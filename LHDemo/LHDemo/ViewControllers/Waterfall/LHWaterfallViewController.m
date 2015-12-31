//
//  LHWaterfallViewController.m
//  LHDemo
//
//  Created by leihui on 15/8/18.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHWaterfallViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"

#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"

#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"
#define HEADER_IDENTIFIER @"WaterfallHeader"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

@interface LHWaterfallViewController () <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *cellSizes;
@property (nonatomic, strong) MJRefreshHeaderView *refreshHeader;
@property (nonatomic, strong) MJRefreshFooterView *footerView;

@end

@implementation LHWaterfallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	if (!_collectionView) {
		CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
		
		layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
		layout.headerHeight = 15;
		layout.footerHeight = 10;
		layout.minimumColumnSpacing = 20;
		layout.minimumInteritemSpacing = 30;
		layout.columnCount = 2;
		
		_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
		_collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_collectionView.dataSource = self;
		_collectionView.delegate = self;
		_collectionView.backgroundColor = [UIColor whiteColor];
		[_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
			forCellWithReuseIdentifier:CELL_IDENTIFIER];
		[_collectionView registerClass:[CHTCollectionViewWaterfallHeader class]
			forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
				   withReuseIdentifier:HEADER_IDENTIFIER];
		[_collectionView registerClass:[CHTCollectionViewWaterfallFooter class]
			forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
				   withReuseIdentifier:FOOTER_IDENTIFIER];
		
		[self.view addSubview:_collectionView];
		
		
		// 下拉刷新
		MJRefreshHeaderView *refreshHeader = [MJRefreshHeaderView header];
		refreshHeader.scrollView = self.collectionView;
		refreshHeader.delegate = self;
		// 自动刷新
		[refreshHeader beginRefreshing];
		self.refreshHeader = refreshHeader;
		
		// 上拉加载更多
		MJRefreshFooterView *footerView = [MJRefreshFooterView footer];
		footerView.scrollView = self.collectionView;
		footerView.delegate = self;
		self.footerView = footerView;
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (NSMutableArray *)cellSizes {
	if (!_cellSizes) {
		_cellSizes = [NSMutableArray array];
		for (NSInteger i = 0; i < CELL_COUNT; i++) {
			CGSize size = CGSizeMake(arc4random() % 50 + 50, arc4random() % 50 + 50);
			_cellSizes[i] = [NSValue valueWithCGSize:size];
		}
	}
	return _cellSizes;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
	// 刷新表格
	[self.collectionView reloadData];
	
	// (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
	[refreshView endRefreshing];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return CELL_COUNT;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CHTCollectionViewWaterfallCell *cell =
	(CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
																				forIndexPath:indexPath];
	cell.displayString = [NSString stringWithFormat:@"%ld", (long)indexPath.item];
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	UICollectionReusableView *reusableView = nil;
	
	if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
		reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
														  withReuseIdentifier:HEADER_IDENTIFIER
																 forIndexPath:indexPath];
	} else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
		reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
														  withReuseIdentifier:FOOTER_IDENTIFIER
																 forIndexPath:indexPath];
	}
	
	return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	return [self.cellSizes[indexPath.item] CGSizeValue];
}

#pragma mark - 刷新控件的代理方法
#pragma mark 开始进入刷新状态

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
	NSLog(@"%@----开始进入刷新状态", refreshView.class);
	
	// 添加假数据
	// ...
	
	// 2秒后刷新表格UI
	[self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
}

#pragma mark 刷新完毕

- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
	NSLog(@"%@----刷新完毕", refreshView.class);
}

#pragma mark 监听刷新状态的改变

- (void)refreshView:(MJRefreshBaseView *)refreshView stateChange:(MJRefreshState)state
{
	switch (state) {
		case MJRefreshStateNormal:
			NSLog(@"%@----切换到：普通状态", refreshView.class);
			break;
			
		case MJRefreshStatePulling:
			NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
			break;
			
		case MJRefreshStateRefreshing:
			NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
			break;
		default:
			break;
	}
}

#pragma mark - dealloc

- (void)dealloc
{
	_collectionView.delegate = nil;
	_collectionView.dataSource = nil;
	
	[_refreshHeader free];
	[_footerView free];
}

@end
