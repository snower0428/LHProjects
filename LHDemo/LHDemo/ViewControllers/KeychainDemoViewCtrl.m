//
//  KeychainDemoViewCtrl.m
//  LHDemo
//
//  Created by leihui on 14-12-8.
//  Copyright (c) 2014年 ND WebSoft Inc. All rights reserved.
//

#import "KeychainDemoViewCtrl.h"
#import "PDKeychainBindings.h"

@interface KeychainDemoViewCtrl ()

@end

@implementation KeychainDemoViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = @"Keychain";
	self.view.backgroundColor = [UIColor orangeColor];
	
	CGFloat leftMargin = 10.f;
	CGRect frame = CGRectMake(leftMargin, 100, self.view.frame.size.width-leftMargin*2, 40.f);
	
	// UserName
	UITextField *textFieldUserName = [[UITextField alloc] initWithFrame:frame];
	textFieldUserName.placeholder = @"Input UserName";
	[self.view addSubview:textFieldUserName];
	
	frame.origin.y = frame.origin.y + frame.size.height + 10.f;
	
	// Password
	UITextField *textFieldPassword = [[UITextField alloc] initWithFrame:frame];
	textFieldPassword.placeholder = @"Input Password";
	[self.view addSubview:textFieldPassword];
	
	frame.origin.y = frame.origin.y + frame.size.height + 10.f;
	
	// Save
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = frame;
	[button setTitle:@"SaveToKeychain" forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
	button.layer.cornerRadius = 8.f;
	button.layer.borderColor = [UIColor orangeColor].CGColor;
	button.layer.borderWidth = 1.f;
	[self.view addSubview:button];
	[button handleControlEvents:UIControlEventTouchUpInside withBlock:^{
		PDKeychainBindings *bindings = [PDKeychainBindings sharedKeychainBindings];
		[bindings setObject:textFieldUserName.text forKey:@"LHUserName"];
		[bindings setObject:textFieldPassword.text forKey:@"LHPassword"];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
