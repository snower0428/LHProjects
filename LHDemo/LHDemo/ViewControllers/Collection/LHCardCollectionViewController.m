//
//  LHCardCollectionViewController.m
//  LHDemo
//
//  Created by leihui on 15/8/17.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHCardCollectionViewController.h"
#import "NNCardCollectionViewLayout.h"
#import "LHCollectionViewCell.h"

@interface LHCardCollectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
	UICollectionView		*_collectionView;
}

@end

@implementation LHCardCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"CardCollection";
	self.view.backgroundColor = [UIColor whiteColor];
	
	if (SYSTEM_VERSION >= 7.0) {
		if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
			[self setEdgesForExtendedLayout:UIRectEdgeNone];
		}
	}
	
	NNCardCollectionViewLayout *layout = [[NNCardCollectionViewLayout alloc] init];
	
	_collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kAppView_Height) collectionViewLayout:layout];
	_collectionView.dataSource = self;
	_collectionView.delegate = self;
	_collectionView.showsVerticalScrollIndicator = YES;
	_collectionView.pagingEnabled = YES;
	[self.view addSubview:_collectionView];
	
	[_collectionView registerClass:[LHCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	LHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	cell.titleLabel.text = [@(indexPath.row) stringValue];
	
	return cell;
}

@end
