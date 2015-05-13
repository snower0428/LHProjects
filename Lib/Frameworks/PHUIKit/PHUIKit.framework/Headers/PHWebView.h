//
//  PHWebView.h
//  PandaHome
//
//  Created by ZZF on 13-7-10.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHWebView : UIWebView <UIWebViewDelegate>
{
@private
	NSMutableArray *m_rediUrls;
	NSMutableArray *m_moniFiles;
	NSMutableArray *m_matchUrls;
	NSString *m_mainUrl;
	NSString *m_originUrl;
	NSString *m_data;
	UIActivityIndicatorView *hubProgressView;
	
	BOOL bFinishLoad;
	BOOL bPostData;
	BOOL bURLRedirect;
	
	id webDelegate;
	UIAlertView * messageAlert; //用于防止pop视图后会弹出提示框导致程序崩溃
	NSError *error;
}

@property(nonatomic, assign) id webDelegate;
@property(nonatomic, retain) NSError *error;


- (id)initWithFrame:(CGRect)frame;

- (void)cancel;

- (void)openUrl:(NSString *)url;
- (void)postUrl:(NSString *)url withData:(NSString *)data;

- (void)addRedirectUrl:(NSString *)url;
- (void)addMonitSuffix:(NSString *)suffix;
- (void)addMatchUrl:(NSString *)url;

- (void)setAllowsRubberBanding:(BOOL)flag;

/* Please override these methods to handle your interested URLs. */
- (BOOL)handleRedirectUrl:(NSString *)url finishLoad:(BOOL)flag;
- (BOOL)handleMonitSuffix:(NSString *)url finishLoad:(BOOL)flag;
- (BOOL)handleMatchUrl:(NSString *)url finishLoad:(BOOL)flag;

@end

@protocol PHWebViewFinishDelegate

- (void)webViewDidFinish:(PHWebView *)webView;
- (void)webViewDidFail:(PHWebView *)webView;

@end
