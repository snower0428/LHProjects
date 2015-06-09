//
//  LHTravelDetailViewCtrl.m
//  LHTravel
//
//  Created by leihui on 15/5/27.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "LHTravelDetailViewCtrl.h"
#import "PagePhotosView.h"
#import "LHDetailAddressCell.h"
#import "LHDetailConsumeCell.h"
#import "LHDetailIntroCell.h"
#import "LHDetailCommentCell.h"

static const CGFloat kAddressCellHeight = 55.f;
static const CGFloat kComsumeCellHeight = 55.f;
//static const CGFloat kIntroCellHeight = 55.f;
static const CGFloat kCommentCellHeight = 55.f;

static const CGFloat kBottomBarHeight = 50.f;

static const NSInteger kCellViewTag = 800;

typedef NS_ENUM(NSInteger, BottomBarAction) {
    BottomBarActionComment  = 0,    // 写点评
    BottomBarActionfaverite,        // 收藏
};

@interface LHTravelDetailViewCtrl () <PagePhotosDataSource, UITableViewDataSource, UITableViewDelegate,
										LHDetailAddressCellDelegate, LHDetailConsumeCellDelegate,
                                        LHDetailIntroCelllDelegate>
{
	NSMutableArray      *_banners;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) PagePhotosView *bannerView;
@property (nonatomic, retain) UIView *bottomBar;
@property (nonatomic, retain) NSString *strIntro;
@property (nonatomic, retain) NSString *strPhoneNumber;

@end

@implementation LHTravelDetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor whiteColor];
    
    if (SYSTEM_VERSION >= 7.0) {
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        }
    }
	
	_banners = [[NSMutableArray alloc] init];
	
#if 1
	NSArray *array = @[@"http://www.onegreen.org/desk/Upload_desk/200902/20090221002654817.jpg",
					   @"http://www.onegreen.org/desk/Upload_desk/200902/20090221000533118.jpg",
					   @"http://www.ulifeel.com/wp-content/uploads/2014/04/moore-3-640x320.jpg",];
#else
	NSArray *array = @[@"", @"", @""];
#endif
	for (NSInteger i = 0; i < [array count]; i++) {
		NSString *strUrl = [array objectAtIndex:i];
		if (strUrl) {
			[_banners addObject:strUrl];
		}
	}
	
	[self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (CGFloat)heightForIntro
{
    CGFloat fontSize = 9.f;
    CGFloat height = 14.f;
    CGFloat leftMargin = 10.f;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize size = CGSizeZero;
    
    if (_strIntro && ![NSString isEmptyString:_strIntro]) {
        size = [_strIntro sizeWithFont:font
                     constrainedToSize:CGSizeMake(SCREEN_WIDTH-leftMargin*2, 1000)
                         lineBreakMode:UILineBreakModeWordWrap];
    }
    else {
        size = CGSizeMake(SCREEN_WIDTH-leftMargin*2, height);
    }
    
    NSInteger numberOfLines = size.height/9.f;
    
    return height*numberOfLines;
}

- (void)btnAction:(id)sender
{
    NSInteger btnTag = ((UIButton *)sender).tag;
    switch (btnTag) {
        case BottomBarActionComment:
        {
            MLOG(@"写点评");
            break;
        }
        case BottomBarActionfaverite:
        {
            MLOG(@"收藏");
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark PagePhotosDataSource

// 有多少页
- (NSInteger)numberOfPages
{
	NSInteger pages = [_banners count];
	if (_banners == nil || [_banners count]==0)
		pages = 1;
	return pages;
}

// 每页的图片
- (NSString *)imageAtIndex:(NSInteger)index
{
	NSString *imgPath = nil;
	if ([_banners count] > 0) {
		if (index < [_banners count]) {
			imgPath = [_banners objectAtIndex:index];
		}
	}
	return imgPath;
}

//点中哪张图片
- (void)imageTouchIndex:(NSInteger)indexImage
{
	if ([_banners count] > 0) {
		if (indexImage < [_banners count]) {
			
		}
	}
	else {
//如果为空，则显示默认图
//		BOOL status = [[NetworkStatusMgr sharedInstance] getNetworkStatus];
//		if (!status)
//			[PHLabelMessage showMessageLable:_(@"Network error !") inView:self.view withTimeInterval:1.5];
//		else {
//			[PHLabelMessage showMessageLable:_(@"Loading...") inView:self.view withTimeInterval:1.5];
//		}
	}
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"cellIdentifier";
	
    NSInteger row = indexPath.row;
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
		cell.backgroundColor = [UIColor whiteColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
    UIView *view = [cell.contentView viewWithTag:kCellViewTag];
    if (view) {
        [view removeFromSuperview];
    }
    
	switch (row) {
		case 0:
		{
			CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, kAddressCellHeight);
			LHDetailAddressCell *cellView = [[[LHDetailAddressCell alloc] initWithFrame:frame] autorelease];
            cellView.tag = kCellViewTag;
			cellView.delegate = self;
			[cell.contentView addSubview:cellView];
			break;
		}
		case 1:
		{
			CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, kComsumeCellHeight);
			LHDetailConsumeCell *cellView = [[[LHDetailConsumeCell alloc] initWithFrame:frame] autorelease];
            cellView.tag = kCellViewTag;
			cellView.delegate = self;
			[cell.contentView addSubview:cellView];
			break;
		}
		case 2:
		{
            NSString *strText = @"在西方一片抵制声中，俄罗斯将中国领导人的出席视为精神支柱，从迎接领导人的车队到参加阅兵式的仪仗队人数，都给了中国独一无二的最高待遇。在习近平10日起程赴白俄罗斯前，俄罗斯还派了军乐团和三军仪仗队，在机场再一次接受中国领导人检阅。";
            self.strIntro = strText;
            
            CGFloat introHeight = [self heightForIntro];
            CGFloat cellHeight = 20.f + 1.f + introHeight + 35.f;
            CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, cellHeight);
            
            LHDetailIntroCell *cellView = [[[LHDetailIntroCell alloc] initWithFrame:frame] autorelease];
            cellView.tag = kCellViewTag;
            cellView.delegate = self;
            [cell.contentView addSubview:cellView];
            
            [cellView updateIntoWithText:strText];
            
            strText = @"0513-845158768";
            self.strPhoneNumber = strText;
            [cellView updateCallWithText:strText];
            
			break;
		}
		case 3:
		{
            CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, kCommentCellHeight);
            
            LHDetailCommentCell *cellView = [[[LHDetailCommentCell alloc] initWithFrame:frame] autorelease];
            cellView.tag = kCellViewTag;
            [cell.contentView addSubview:cellView];
			break;
		}
		default:
			break;
	}
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat height = 0.f;
	NSInteger row = indexPath.row;
	switch (row) {
		case 0:
		{
			height = kAddressCellHeight;
			break;
		}
		case 1:
		{
			height = kComsumeCellHeight;
			break;
		}
		case 2:
		{
            CGFloat introHeight = [self heightForIntro];
            CGFloat cellHeight = 20.f + 1.f + introHeight + 35.f;
			height = cellHeight;
			break;
		}
		case 3:
		{
			height = kCommentCellHeight;
			break;
		}
		default:
			break;
	}
	return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - LHDetailAddressCellDelegate

- (void)gotoThePlace
{
	MLOG(@"gotoThePlace");
}

#pragma mark - LHDetailIntroCelllDelegate

- (void)phoneCallDidSelected
{
    if (_strPhoneNumber && ![NSString isEmptyString:_strPhoneNumber]) {
        MLOG(@"Phone number:%@", _strPhoneNumber);
    }
}

#pragma mark - Views

- (UITableView *)tableView
{
    CGRect tableViewFrame = CGRectMake(0.f, 0.f, SCREEN_WIDTH, kAppView_Height-kBottomBarHeight);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = [self tableHeaderView];
    
    return tableView;
}

- (UIView *)tableHeaderView
{
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, PHOTO_HEIGHT);
    
    UIView *headerView = [[[UIView alloc] initWithFrame:frame] autorelease];
    headerView.backgroundColor = [UIColor orangeColor];
    
    // Banner view
    if (_bannerView == nil) {
        _bannerView = [[PagePhotosView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PHOTO_HEIGHT) withDataSource:self];
        _bannerView.backgroundColor = [UIColor orangeColor];
        [headerView addSubview:_bannerView];
    }
    
    return headerView;
}

- (UIView *)bottomBar
{
    CGRect frame = CGRectMake(0, kAppView_Height - kBottomBarHeight, SCREEN_WIDTH, kBottomBarHeight);
    
    UIView *bottomBar = [[[UIView alloc] initWithFrame:frame] autorelease];
    bottomBar.backgroundColor = RGB(128, 128, 128);
    
    // Horizontal line
    frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
    UIView *horizontalLine = [[[UIView alloc] initWithFrame:frame] autorelease];
    horizontalLine.backgroundColor = RGB(96, 96, 96);
    [bottomBar addSubview:horizontalLine];
    
    // Vertical line
    frame = CGRectMake(SCREEN_WIDTH/2, 10.f, 1, kBottomBarHeight-10.f*2);
    UIView *verticalLine = [[[UIView alloc] initWithFrame:frame] autorelease];
    verticalLine.backgroundColor = RGB(96, 96, 96);
    [bottomBar addSubview:verticalLine];
    
    CGFloat btnWidth = SCREEN_WIDTH/2;
    NSArray *arrayTitle = @[@"写点评", @"收藏"];
    
    for (NSInteger i = 0; i < 2; i++) {
        CGRect btnFrame = CGRectMake(btnWidth*i, 0, btnWidth, kBottomBarHeight);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = BottomBarActionComment + i;
        button.frame = btnFrame;
        NSString *title = nil;
        if (i < [arrayTitle count]) {
            title = [arrayTitle objectAtIndex:i];
        }
        [button setTitle:title forState:UIControlStateNormal];
        [bottomBar addSubview:button];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return bottomBar;
}

#pragma mark - dealloc

- (void)dealloc
{
	[_banners release];
    
    self.tableView =  nil;
    self.bannerView = nil;
    self.strIntro = nil;
    self.strPhoneNumber = nil;
	
	[super dealloc];
}

@end
