//
//  PHDynamicViewCtrl.m
//  LHTravel
//
//  Created by leihui on 15/6/10.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PHDynamicViewCtrl.h"
#import "PHDynamicCellView.h"

@interface PHDynamicViewCtrl () <UITableViewDataSource, UITableViewDelegate, PHDynamicCellViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@end

@implementation PHDynamicViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor lightGrayColor];
	self.title = @"动态";
	
	if (SYSTEM_VERSION >= 7.0) {
		if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
			[self setEdgesForExtendedLayout:UIRectEdgeNone];
		}
	}
	
	[self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 300.f;
	
	return height;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
		cell.backgroundColor = [UIColor lightGrayColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		CGFloat height = [self heightForRowAtIndexPath:indexPath];
		CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
		
		PHDynamicCellView *cellView = [[[PHDynamicCellView alloc] initWithFrame:frame] autorelease];
		cellView.delegate = self;
		[cell.contentView addSubview:cellView];
	}
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - PHDynamicCellViewDelegate

- (void)selectedPayAttention:(id)sender
{
	MLOG(@"%@", ((UIButton *)sender).titleLabel.text);
}

#pragma mark - Views

- (UITableView *)tableView
{
	UITableView *tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, kAppView_Height-TABBAR_HEIGHT) style:UITableViewStylePlain] autorelease];
	tableView.backgroundColor = [UIColor clearColor];
	tableView.dataSource = self;
	tableView.delegate = self;
	tableView.showsHorizontalScrollIndicator = NO;
	tableView.showsVerticalScrollIndicator = NO;
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.backgroundView.backgroundColor = [UIColor clearColor];
	
	return tableView;
}

#pragma mark - dealloc

- (void)dealloc
{
	self.tableView = nil;
	
	[super dealloc];
}

@end
