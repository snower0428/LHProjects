//
//  ViewController.m
//  LHDemo
//
//  Created by leihui on 13-9-10.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"
#import "MotionViewController.h"
#import "LHCoreImageViewController.h"
#import "ImageEffectViewController.h"
#import "DynamicsViewController.h"
#import "InAppPurchaseViewController.h"
#import "RootFuncViewController.h"
#import "GIFViewController.h"
#import "KeychainDemoViewCtrl.h"
#import "BlockDemoViewController.h"
#import "AFNetworkingViewController.h"

@interface ViewController ()
{
    UITableView     *_tableView;
    NSArray         *_arrayName;
    NSArray         *_arrayViewController;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _arrayName = [[NSArray alloc] initWithObjects:
                  @"Demo",
//                  @"Motion",
//                  @"Core Image",
//                  @"Contacts",
#if !TARGET_IPHONE_SIMULATOR
//                  @"StoreKit",
#endif
                  @"ImageEffect",
//                  @"Dynamics",
                  @"In App Purchase",
				  @"Root",
				  @"GIF",
				  @"Keychain",
				  @"Block",
				  @"AFNetworking",
                  nil];
    
    _arrayViewController = [[NSArray alloc] initWithObjects:
                            @"DemoViewController",
//                            @"MotionViewController",
//                            @"LHCoreImageViewController",
//                            @"ABNewPersonViewController",
#if !TARGET_IPHONE_SIMULATOR
//                            @"SKStoreProductViewController",
#endif
                            @"ImageEffectViewController",
//                            @"DynamicsViewController",
                            @"InAppPurchaseViewController",
							@"RootFuncViewController",
							@"GIFViewController",
							@"KeychainDemoViewCtrl",
							@"BlockDemoViewController",
							@"AFNetworkingViewController",
                            nil];
    
    [self initTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)initTableView
{
    CGRect tableFrame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-STATUSBAR_HEIGHT-NAVIGATIONBAR_HEIGHT);
    _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

- (void)onBack:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openAppWithId:(NSString *)appId
{
    if (NSClassFromString(@"SKStoreProductViewController")) {
        SKStoreProductViewController *storeController = [[SKStoreProductViewController alloc] init];
        storeController.delegate = self;
        NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
        [storeController loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
            if (result) {
                [self presentViewController:storeController animated:YES completion:nil];
            }
            else {
                NSLog(@"%@",error);
            }
        }];
    }
    else{
        //低于iOS6没有这个类
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", appId];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

#pragma mark - SKStoreProductViewControllerDelegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ABAddressBookDelegate

- (void) addressBookDidChange: (ABAddressBook *) addressBook
{
    NSLog(@"addressBookDidChange...");
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < [_arrayViewController count])
    {
        NSString *strClass = [_arrayViewController objectAtIndex:indexPath.row];
        id object = NSClassFromString(strClass);
        
        if ([strClass isEqualToString:@"ABNewPersonViewController"])
        {
            UIBarButtonItem *leftItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(onBack:)] autorelease];
            
            UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:[[ABAddressBook sharedAddressBook] viewControllerForNewPerson]];
            navCtrl.navigationItem.leftBarButtonItem = leftItem;
			[self presentViewController:navCtrl animated:YES completion:nil];
            
            [navCtrl release];
        }
        else if ([strClass isEqualToString:@"SKStoreProductViewController"]) {
            [self openAppWithId:@"688692382"];
        }
        else
        {
            UIViewController *ctrl = [[[object alloc] init] autorelease];
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrayName count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row < [_arrayName count]) {
        cell.textLabel.text = [_arrayName objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - dealloc

- (void)dealloc
{
    [_tableView release];
    [_arrayName release];
    [_arrayViewController release];
    
    [super dealloc];
}

@end
