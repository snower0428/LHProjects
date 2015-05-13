//
//  PagePhotosView.h
//  PagePhotosDemo
//
//  Created by Andy soonest on 11-11-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagePhotosDataSource.h"
#import "TouchView.h"

#define PAGECONTROLHEIGHT 8//back ground image height
#define SCREEN_X_OFFSET   0
#define SCREEN_Y_OFFSET   0
#define PHOTO_WIDTH		  SCREEN_WIDTH
#define PHOTO_HEIGHT	  85*kAppWidthScaleFactor//184->170
#define PHOTO_INTERVAL    0

#define FIRSTVIEW_TAG                 1000
#define LASTVIEW_TAG                  1001
#define BASEVIEW_TAG                  3000
#define MAXVIEW_TAG BASEVIEW_TAG + 50
#define kPhotoImageViewBaseTag        20000

@interface PagePhotosView : UIView<UIScrollViewDelegate,ImageTouchDelegate> {
	UIScrollView *m_scrollView;
    UIPageControl   *pageControl;
	id<PagePhotosDataSource> dataSource;
	NSMutableArray *imageViews;
	
	// To be used when scrolls originate from the UIPageControl
    BOOL pageControlUsed;
    
    NSInteger kNumberOfPages;
    
    NSTimer *_timer;
}

@property (nonatomic, assign) id<PagePhotosDataSource> dataSource;
@property (nonatomic, retain) NSMutableArray *imageViews;
@property (nonatomic, assign) NSInteger kNumberOfPages;

- (void)changePage:(id)sender;

- (id)initWithFrame:(CGRect)frame withDataSource:(id<PagePhotosDataSource>)_dataSource;

- (void)reloadDataSource;//数据变化时重新刷新数据

//modify by link
- (void)stopScrollPageView;
- (void)startScrollPageView;
@end
