//
//  TestViewController.m
//  LHDemo
//
//  Created by leihui on 15/5/15.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.3];
	[self.navigationController.view setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.3]];
	
	UIBarButtonItem *leftItem = [[[UIBarButtonItem alloc] initWithTitle:@"<-" style:UIBarButtonItemStylePlain target:self action:@selector(onBack:)] autorelease];
	self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onBack:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc

- (void)dealloc
{
	[super dealloc];
}

@end
