//
//  AFNetworkingViewController.m
//  LHDemo
//
//  Created by leihui on 15/6/2.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import "AFNetworking.h"

@interface AFNetworkingViewController () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
{
	NSURLConnection		*_connection;
}

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor orangeColor];
	
#if 0
	NSString *strUrl = @"http://pandahome.sj.91.com/appstore/getdata.aspx?themetype=14000&tfv=14000&mt=1&pid=81&SupPhone=iPhone7,2&SupFirm=8.0&SupFun=1.9.80&SupHD=1&DivideVersion=1.9.80&udid=5F7AD18F-3558-43E6-AFDA-46469BFDC689&imei=5F7AD18F-3558-43E6-AFDA-46469BFDC689&rslt=640*1136&lan=en&iv=4&jb=1&action=1001";
	
	// 方法1
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
	AFHTTPRequestOperation *operation = [[[AFHTTPRequestOperation alloc] initWithRequest:request] autorelease];
	[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		// Success
		NSString *responseString = operation.responseString;
		NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
		id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
		MLOG(@"dict:%@", dict);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		// Failure
		MLOG(@"Error:%@", error);
	}];
	
	NSOperationQueue *queue = [[[NSOperationQueue alloc] init] autorelease];
	[queue addOperation:operation];
#endif
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
