//
//  RootFuncViewController.m
//  LHDemo
//
//  Created by leihui on 14-11-7.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import "RootFuncViewController.h"

typedef enum
{
	RFButtonActionLogout = 100,
	RFButtonActionReboot,
}RFButtonAction;

@interface RootFuncViewController ()

@end

@implementation RootFuncViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"RootApp";
	self.view.backgroundColor = [UIColor grayColor];
	
	CGFloat leftMargin = 10.f;
	CGFloat topMargin = 100.f;
	CGFloat btnWidth = self.view.frame.size.width - leftMargin*2;
	CGFloat btnHeight = 50.f;
	CGFloat yInterval = 20.f;
	
	NSArray *arrayTitle = @[@"Logout", @"Reboot"];
	
	for (int i = 0; i < 2; i++) {
		CGRect frame = CGRectMake(leftMargin, topMargin+(yInterval+btnHeight)*i, btnWidth, btnHeight);
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.frame = frame;
		btn.tag = RFButtonActionLogout+i;
		[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[btn setTitle:[arrayTitle objectAtIndex:i] forState:UIControlStateNormal];
		btn.layer.cornerRadius = 10.f;
		btn.layer.borderWidth = 1.f;
		btn.layer.borderColor = [UIColor orangeColor].CGColor;
		[btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:btn];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)btnAction:(id)sender
{
	NSInteger btnTag = ((UIButton *)sender).tag;
	switch (btnTag) {
		case RFButtonActionLogout:
		{
			[self logout];
			break;
		}
		case RFButtonActionReboot:
		{
			[self reboot];
			break;
		}
		default:
			break;
	}
}

- (void)logout
{
	NSLog(@"iOSREDebug logout");
	NSLog(@"iOSREDebut logout: %d", system("killall -9 backboardd"));
}

- (void)reboot
{
	NSLog(@"iOSREDebug reboot: %d, %d", getuid(), geteuid());
	NSLog(@"iOSREDebut reboot: %d", system("reboot"));
}

#pragma mark - dealloc

- (void)dealloc
{
	[super dealloc];
}

@end
