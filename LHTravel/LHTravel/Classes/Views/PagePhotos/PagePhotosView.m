//
//  PagePhotosView.m
//  PagePhotosDemo
//
//  Created by Andy soonest on 11-11-22.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PagePhotosView.h"
#import "PHNetWorkInterfaceRule.h"
#import "PHLiveAssistantManager.h"

float offsetX = 0;

@interface PagePhotosView (PrivateMethods)

- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end

@implementation PagePhotosView
@synthesize dataSource;
@synthesize imageViews;
@synthesize kNumberOfPages;

- (id)initWithFrame:(CGRect)frame withDataSource:(id<PagePhotosDataSource>)_dataSource {
    if ((self = [super initWithFrame:frame])) {
		self.dataSource = _dataSource;
		
		kNumberOfPages = [dataSource numberOfPages];

        // Initialization UIScrollView
		NSInteger pageControlHeight = PAGECONTROLHEIGHT;
		m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, (PHOTO_WIDTH+PHOTO_INTERVAL), frame.size.height /*- pageControlHeight*/)];
        
        /*UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height - pageControlHeight, frame.size.width, pageControlHeight)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3f;
        [self addSubview:view];
        [view release];*/
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - pageControlHeight-2, frame.size.width, pageControlHeight)];
		pageControl.numberOfPages = kNumberOfPages;
		pageControl.currentPage = 0;
		pageControl.backgroundColor = [UIColor clearColor];
		[pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];	
	
		[self addSubview:m_scrollView];
		[self addSubview:pageControl];
		
			
        if (kNumberOfPages) {
            // in the meantime, load the array with placeholders which will be replaced on demand
            NSMutableArray *views = [[NSMutableArray alloc] init];
            for (unsigned  i = 0; i < kNumberOfPages; i++) {//default 10 object
                [views addObject:[NSNull null]];
            }
            self.imageViews = views;
            [views release];
        }
       
		
		
		// a page is the width of the scroll view
		m_scrollView.pagingEnabled = YES;
		m_scrollView.clipsToBounds = NO;
        m_scrollView.contentSize = CGSizeMake((PHOTO_WIDTH+PHOTO_INTERVAL)* (kNumberOfPages+2), m_scrollView.frame.size.height);
        [m_scrollView scrollRectToVisible:CGRectMake((PHOTO_WIDTH+PHOTO_INTERVAL),0,m_scrollView.frame.size.width,m_scrollView.frame.size.height) animated:NO];
		m_scrollView.showsHorizontalScrollIndicator = NO;
		m_scrollView.showsVerticalScrollIndicator = NO;
		m_scrollView.scrollsToTop = NO;
		m_scrollView.delegate = self;
	
		// pages are created on demand
		// load the visible page
		// load the page on either side to avoid flashes when the user starts scrolling
        [self loadScrollViewWithPage:-1];
		[self loadScrollViewWithPage:0];
		[self loadScrollViewWithPage:1];

    }
    return self;
}

//modify by link
- (void)stopScrollPageView
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)startScrollPageView
{
    if (!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(recycle) userInfo:nil repeats:YES];
    }
}
- (ImageTouchView *)getPhotoImageViewWithPage:(NSInteger)page
{
	// replace the placeholder if necessary
	ImageTouchView *view = nil;
	if ((page < kNumberOfPages)&&(page >= 0))
		view = [imageViews objectAtIndex:page];
    if ([imageViews count]>(kNumberOfPages-1)&&(kNumberOfPages-1) >= 0 && page <= -1)
    {
        view = [imageViews objectAtIndex:(kNumberOfPages-1)];
    }
    else if([imageViews count] >=1 &&page >= kNumberOfPages)
    {
        view = [imageViews objectAtIndex:0];
    }
	return view;
}

- (void)loadScrollViewWithPage:(NSInteger)page
{
    if (kNumberOfPages == 0)
        return;
    if (page < -2)
        return;
    if (page > (kNumberOfPages+1))
        return;
    
    int viewTag = 0;
    viewTag = BASEVIEW_TAG + page;
    if (page <= -1)
    {
        viewTag = FIRSTVIEW_TAG;
    }    
    else if (page >= kNumberOfPages)
    {
        viewTag = LASTVIEW_TAG;
    }
    UIImageView *itemView = (UIImageView *)[m_scrollView viewWithTag:viewTag];
    
    // replace the placeholder if necessary
	ImageTouchView *view = [self getPhotoImageViewWithPage:page];
    NSString *imageItem = nil,*imageUrl = nil;
    if (((NSNull *)view == [NSNull null])||(itemView == nil)) {		
		
		if (page >= kNumberOfPages)
		{
			imageItem =  [dataSource imageAtIndex:0];
			imageUrl  =  [dataSource imageUrlAtIndex:0];
		}
		else if(page <= -1&&(kNumberOfPages - 1)>=0&&(kNumberOfPages - 1)<kNumberOfPages){
			imageItem = [dataSource imageAtIndex:(int)(kNumberOfPages - 1)];
			imageUrl  = [dataSource imageUrlAtIndex:(int)(kNumberOfPages - 1)];
		}
		else{
			imageItem = [dataSource imageAtIndex:page];
			imageUrl  = [dataSource imageUrlAtIndex:page];
		}
        //if (imageItem) 
        {            
			view = [[[ImageTouchView alloc] initWithFrame:CGRectZero] autorelease];
			view.delegateTouch = self;
			
			UIImageView * imagePhotoView = [[UIImageView alloc] init];
			imagePhotoView.frame=CGRectMake(0, 0, PHOTO_WIDTH, self.frame.size.height);
			UIImage *localImg = nil;
			if (imageItem) {
				localImg = [UIImage imageWithContentsOfFile:imageItem];
			}
			if ([imageUrl isKindOfClass:[NSString class]]) {
				if (localImg)
					imagePhotoView.image = localImg;
				NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:imagePhotoView,@"imageView", nil];
				[[PHLiveAssistantManager sharedInstance] imageWithUrl:imageUrl target:self userInfo:dict];
			}else{
				imagePhotoView.image = localImg;
			}		
					
			[view addSubview:imagePhotoView];
			[imagePhotoView release];
			
			if ((page < kNumberOfPages)&&(page >= 0)
				&&(page<[imageViews count])
				&&[view isKindOfClass:[ImageTouchView class]])
			{
				MLOG(@"replaceObjectAtIndex begin:view:%@",view);
				[imageViews replaceObjectAtIndex:page withObject:view];           
			}
        }
		
    }
	
    // add the controller's view to the scroll view
    if (view&&((NSNull *)view != [NSNull null])&&([view isKindOfClass:[UIImageView class]])) {
        if ((nil == view.superview)) {
            CGRect frame = m_scrollView.frame;
            CGRect backupFrame;
            backupFrame.origin.x=frame.origin.x;
            backupFrame.origin.y=frame.origin.y;
            backupFrame.size.width=frame.size.width;
            backupFrame.size.height=frame.size.height;
            backupFrame.origin.x = SCREEN_X_OFFSET+PHOTO_INTERVAL*(page+1)+PHOTO_WIDTH * (page+1);	
            backupFrame.origin.y = SCREEN_Y_OFFSET;
            backupFrame.size.width = PHOTO_WIDTH;
            backupFrame.size.height =PHOTO_HEIGHT;
            view.frame = backupFrame;
            
            view.tag = viewTag;            
            
            [m_scrollView addSubview:view];	
        }              
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
   	if (kNumberOfPages>=1) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = PHOTO_WIDTH+PHOTO_INTERVAL;//scrollView.frame.size.width;

        int page = floor(((m_scrollView.contentOffset.x-pageWidth) - pageWidth / 2) / pageWidth) + 1;
        if (kNumberOfPages>=2) {           
            if (page < 0) {
                pageControl.currentPage = kNumberOfPages;
            }else if(page > kNumberOfPages){
                pageControl.currentPage = 1;
            }else{
                pageControl.currentPage = page;
            } 
        }
        
        offsetX = m_scrollView.contentOffset.x;
        // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
        if (page < (kNumberOfPages - 1)) {
            [self loadScrollViewWithPage:page - 1];
            [self loadScrollViewWithPage:page];
            [self loadScrollViewWithPage:page + 1];
        }
        else
        {
            [self loadScrollViewWithPage:page - 1];
            [self loadScrollViewWithPage:page];
            [self loadScrollViewWithPage:(int)kNumberOfPages];
        }
    }
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = YES;
    //MLOG(@"begin dragging");
}


static int indexPhoto = 0;

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //pageControlUsed = NO; 

    // The key is repositioning without animation      
	if (scrollView.contentOffset.x == 0) {         
		// user is scrolling to the left from image 1 to image 4         
		// reposition offset to show image 4 that is on the right in the scroll view         
		[scrollView scrollRectToVisible:CGRectMake((PHOTO_WIDTH+PHOTO_INTERVAL)*kNumberOfPages,0,self.frame.size.width,self.frame.size.height) animated:NO];     
	}    
	else if (scrollView.contentOffset.x == ((PHOTO_WIDTH+PHOTO_INTERVAL)*(kNumberOfPages+1))) {         
		// user is scrolling to the right from image 4 to image 1        
		// reposition offset to show image 1 that is on the left in the scroll view         
		[scrollView scrollRectToVisible:CGRectMake((PHOTO_WIDTH+PHOTO_INTERVAL),0,self.frame.size.width,self.frame.size.height) animated:NO];   
        indexPhoto = 0;
	} 
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (kNumberOfPages >= 1)
    {
        //pageControlUsed = NO;    
        
        int index = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;   
        indexPhoto = index;
       
        // The key is repositioning without animation      
        if (scrollView.contentOffset.x == 0)
        {
            // user is scrolling to the left from image 1 to image 4         
            // reposition offset to show image 4 that is on the right in the scroll view         
            [scrollView scrollRectToVisible:CGRectMake((PHOTO_WIDTH+PHOTO_INTERVAL)*kNumberOfPages,0,self.frame.size.width,self.frame.size.height) animated:NO];     
        }    
        else if (scrollView.contentOffset.x == ((PHOTO_WIDTH+PHOTO_INTERVAL)*(kNumberOfPages+1)))
        {
            // user is scrolling to the right from image 4 to image 1        
            // reposition offset to show image 1 that is on the left in the scroll view         
            [scrollView scrollRectToVisible:CGRectMake((PHOTO_WIDTH+PHOTO_INTERVAL),0,self.frame.size.width,self.frame.size.height) animated:NO];         
        } 
    }
    
}

- (void)recycle
{
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        pageControlUsed = NO;
        return;
    }     	
	BOOL flag = YES;
	if ((kNumberOfPages >= 2)&&indexPhoto > kNumberOfPages) {
        indexPhoto = 0;
        [self recycle];
		return ;
	}	
    if (kNumberOfPages >= 2) {        
        [m_scrollView scrollRectToVisible:CGRectMake((PHOTO_WIDTH + PHOTO_INTERVAL) * (indexPhoto+1), 0, m_scrollView.frame.size.width, m_scrollView.frame.size.height) animated:flag];
        
        pageControl.currentPage = indexPhoto;
        indexPhoto++;
    }
}

- (void)changePage:(id)sender {
	if (kNumberOfPages >=1 ) {
        int page = (int)pageControl.currentPage;
        indexPhoto = page;
        MLOG(@"changepage here===page:%d",page);
        
        // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
        [self loadScrollViewWithPage:page - 1];
        [self loadScrollViewWithPage:page];
        [self loadScrollViewWithPage:page + 1];
        
        // update the scroll view to the appropriate page
        CGRect frame = m_scrollView.frame;
        if (page == 0) {
            frame.origin.x = SCREEN_X_OFFSET+PHOTO_INTERVAL*(page+1)+PHOTO_WIDTH * page;	
        }else {
            frame.origin.x = PHOTO_INTERVAL*(page+1)+PHOTO_WIDTH * page;	
        }
        
        frame.origin.y = SCREEN_Y_OFFSET;
        frame.size.width = PHOTO_WIDTH;
        frame.size.height =PHOTO_HEIGHT;
        [m_scrollView scrollRectToVisible:frame animated:YES];
        
        // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
        pageControlUsed = YES;

    }
}

- (void)reloadDataSource//数据变化时重新刷新数据
{
    MLOG(@"reloadDataSource begin");
    kNumberOfPages = [dataSource numberOfPages];  
    MLOG(@"reloadDataSource kNumberOfPages:%ld",(long)kNumberOfPages);
    if (kNumberOfPages) {
                
        MLOG(@"reloadDataSource begin");
        if (self.imageViews&&[self.imageViews count]) {
            MLOG(@"removeAllObjects begin,self.imageViews:%@",self.imageViews);
            [self.imageViews removeAllObjects];
            MLOG(@"removeAllObjects end");
        }

        if (m_scrollView) {
            for (id item in [m_scrollView subviews]) {
                UIView *itemView = item;
                if (itemView&&[itemView isKindOfClass:[UIView class]]) {
                    if ((itemView.tag >= BASEVIEW_TAG && itemView.tag <= MAXVIEW_TAG)
                        || (FIRSTVIEW_TAG ==itemView.tag)
                        || (LASTVIEW_TAG ==itemView.tag)) {
                        [itemView removeFromSuperview];
                    }
                }
            }
        }        
        // in the meantime, load the array with placeholders which will be replaced on demand
        NSMutableArray *views = [[NSMutableArray alloc] init];
        for (unsigned  i = 0; i < kNumberOfPages; i++) {//default 10 object
            [views addObject:[NSNull null]];
        }
        self.imageViews = views;
        [views release];      
        MLOG(@"m_scrollView init begin");
        m_scrollView.contentSize = CGSizeMake((PHOTO_WIDTH+PHOTO_INTERVAL)* (kNumberOfPages+2), m_scrollView.frame.size.height);
       
        MLOG(@"loadScrollViewWithPage begin");
        [self loadScrollViewWithPage:-1];
		[self loadScrollViewWithPage:0];
		[self loadScrollViewWithPage:1];
        MLOG(@"loadScrollViewWithPage end");
		
		if (kNumberOfPages == 1) {
			pageControl.hidden = YES;
		}
		else {
			pageControl.hidden = NO;
			pageControl.numberOfPages = kNumberOfPages;
		}
        [pageControl updateCurrentPageDisplay];
        
    }else
    {
        if (self.imageViews&&[self.imageViews count])
        {
            [self.imageViews removeAllObjects];
        }
        MLOG(@"m_scrollView subview:%@",m_scrollView);
        if (m_scrollView) {
            for (id item in [m_scrollView subviews])
            {
                UIView *itemView = item;
                if (itemView&&[itemView isKindOfClass:[UIView class]])
                {
                    if ((itemView.tag >= BASEVIEW_TAG && itemView.tag <= MAXVIEW_TAG)
                        || (FIRSTVIEW_TAG ==itemView.tag)
                        || (LASTVIEW_TAG ==itemView.tag))
                    {
                        [itemView removeFromSuperview];
                    }
                }
            }
            m_scrollView.contentSize = CGSizeMake((PHOTO_WIDTH+PHOTO_INTERVAL)* (kNumberOfPages+2), m_scrollView.frame.size.height);
        }
        pageControl.numberOfPages = 0 ;
        [pageControl updateCurrentPageDisplay];
    }
    MLOG(@"reloadDataSource end");
}

#pragma mark --
#pragma mark ImageTouchDelegate
- (void)imageTouch:(id)imageView
{
	MLOG(@"imageView=========%@",imageView);
	ImageTouchView *view = (ImageTouchView *)imageView;
    if (view&&[view isKindOfClass:[UIView class]]) {
        MLOG(@"tag=========%ld",(long)view.tag);
        NSInteger index = -1;
        if (view.tag >= BASEVIEW_TAG && view.tag <= MAXVIEW_TAG) 
        {		
            index = view.tag - BASEVIEW_TAG;
        }
		else if(view.tag == FIRSTVIEW_TAG)
        {
            index = 0;
        }
		else if(view.tag == LASTVIEW_TAG)
        {
            index = kNumberOfPages -1;
        }
		else {
            index = -1;
            MLOG(@"touch image tag:%ld",(long)view.tag);
        }
        
        if ((index>=0)&&(dataSource)&&([dataSource respondsToSelector:@selector(imageTouchIndex:)]))
        {
            [dataSource imageTouchIndex:(int)index];
        }
    }
}
#pragma mark - SDWebImageManagerDelegate

// 图像处理成功
- (void)webImageDidFinishWithImage:(UIImage *)image forURL:(NSURL *)url userInfo:(NSDictionary *)info{
	if ([info isKindOfClass:[NSDictionary class]]) {
		UIImageView *imageView = [info objectForKey:@"imageView"];
		if ([imageView isKindOfClass:[UIImageView class]]) {
			imageView.image = image;
		}
	}
	
}

// 图像处理失败
- (void)webImageDidFailWithError:(NSError *)error forURL:(NSURL *)url userInfo:(NSDictionary *)info{
	
}


- (void)dealloc {
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
	self.imageViews = nil;
	[m_scrollView release];
    m_scrollView = nil;
	[pageControl release];
    pageControl = nil;
    [super dealloc];
}


@end
