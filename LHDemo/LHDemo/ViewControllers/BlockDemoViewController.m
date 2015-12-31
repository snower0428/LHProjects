//
//  BlockDemoViewController.m
//  LHDemo
//
//  Created by leihui on 15/4/24.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

/**
 *	^void(int event) { NSLog(@"123"); };
 *		|		|		|
 *	^返回值类型 参数列表 表达式
 *
 */

#import "BlockDemoViewController.h"

@interface BlockDemoViewController ()

@end

@implementation BlockDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	//
	void (^block)(int) = ^void(int event) {
		NSLog(@"val = %d", event);
	};
	block(10);
	
	//
	const char *text = "Hello";
	void (^blk)(void) = ^{
		NSLog(@"text:%c", text[2]);
	};
	blk();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
