//
//  PopBasicViewController.m
//  LHDemo
//
//  Created by leihui on 15/8/12.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "PopBasicViewController.h"

@interface PopBasicViewController ()

@end

@implementation PopBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"Basic";
	self.view.backgroundColor = [UIColor whiteColor];
	
	if (SYSTEM_VERSION >= 7.0) {
		if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
			[self setEdgesForExtendedLayout:UIRectEdgeNone];
		}
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
