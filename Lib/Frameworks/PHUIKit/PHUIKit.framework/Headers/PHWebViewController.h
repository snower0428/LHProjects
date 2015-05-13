//
//  PushURLMsgCtr.h
//  PandaHome_iPhone
//
//  Created by link on 12-11-22.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PHWebViewController : UIViewController<UIWebViewDelegate> 
{
	NSString *_urlStr;
    UIWebView *ownWebView;
    UIActivityIndicatorView *hubProgressView;
    
    // Toolbar and used buttons
	UIToolbar *_toolbar;
    
    UIBarButtonItem *_reloadButton;
	UIBarButtonItem *_loadingButton;
	UIBarButtonItem *_forwardButton;
	UIBarButtonItem *_backButton;
    UIBarButtonItem *_flexibleSpace;
    /* This is used to store the request if the view is loaded.
     Important if view was released because of low memory conditions */
	NSURLRequest *_request;
    
}
// Read only property to access the UIToolbar. You can use this to adjust the appearance of the toolbar. 
@property (nonatomic, readonly) UIToolbar *toolbar;

@property (nonatomic,copy) NSString *urlStr;

- (instancetype)init;
- (instancetype)initWithRequest:(NSURLRequest *)request;
- (instancetype)initWithURLStr:(NSString *)urlString;

- (void)requestUrlString:(NSString *)urlString;

@end
