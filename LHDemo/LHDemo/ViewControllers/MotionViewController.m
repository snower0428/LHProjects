//
//  MotionViewController.m
//  LHDemo
//
//  Created by leihui on 13-9-13.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import "MotionViewController.h"
#import "AppDelegate.h"

@interface MotionViewController ()
{
#ifdef __IPHONE_7_0
    CMMotionActivityManager     *_motionManager;
    NSOperationQueue            *_motionQueue;
    
    CMStepCounter       *_stepCounter;
    NSOperationQueue    *_stepQueue;
#endif
}

@end

@implementation MotionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
#ifdef __IPHONE_7_0
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    CMMotionActivityManager *motionManager = [appDelegate montionManager];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.backgroundColor = [UIColor grayColor];
    textView.textColor = [UIColor blackColor];
    textView.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:textView];
    
    _motionManager = [[CMMotionActivityManager alloc] init];
    _motionQueue = [[NSOperationQueue alloc] init];
    
    _stepCounter = [[CMStepCounter alloc] init];
    _stepQueue = [[NSOperationQueue alloc] init];
    
    // 日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromeDate = [formatter dateFromString:@"2013-09-23"];
    
    if ([CMMotionActivityManager isActivityAvailable]) {
        // Available
        NSLog(@"available...");
        [_motionManager queryActivityStartingFromDate:fromeDate toDate:[NSDate date] toQueue:_motionQueue withHandler:^(NSArray *activities, NSError *error) {
            NSLog(@"activities count:%d, error:%@, ", (int)[activities count], error);
            NSLog(@"[[_motionQueue operations] count]:%d, [_motionQueue operationCount]:%d", (int)[[_motionQueue operations] count], (int)[_motionQueue operationCount]);
            
            int confidenc0 = 0;
            int confidenc1 = 0;
            int confidenc2 = 0;
            
            int stationary = 0;
            int walking = 0;
            int running = 0;
            int automotive = 0;
            
            for (int i = 0; i < [activities count]; i++) {
                CMMotionActivity *activity = [activities objectAtIndex:i];
                if (activity.confidence == 0) {
                    confidenc0++;
                }
                else if (activity.confidence == 1) {
                    confidenc1++;
                }
                else if (activity.confidence == 2) {
                    confidenc2++;
                }
                
                if (activity.stationary) {
                    stationary++;
                }
                if (activity.walking) {
                    walking++;
                }
                if (activity.running) {
                    running++;
                }
                if (activity.automotive) {
                    automotive++;
                }
            }
            NSLog(@"confidenc0:%d, confidenc1:%d, confidenc2:%d", confidenc0, confidenc1, confidenc2);
            NSLog(@"stationary:%d, walking:%d, running:%d, automotive:%d", stationary, walking, running, automotive);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *strTextView = [textView.text stringByAppendingString:[NSString stringWithFormat:@"\nactivities count:%d", (int)[activities count]]];
                strTextView = [strTextView stringByAppendingString:[NSString stringWithFormat:@"\nconfidenc0:%d, confidenc1:%d, confidenc2:%d", confidenc0, confidenc1, confidenc2]];
                strTextView = [strTextView stringByAppendingString:[NSString stringWithFormat:@"\nstationary:%d, walking:%d, running:%d, automotive:%d", stationary, walking, running, automotive]];
                textView.text = strTextView;
            });
        }];
        
        [_motionManager startActivityUpdatesToQueue:_motionQueue withHandler:^(CMMotionActivity *activity) {
            NSLog(@"activity>>>>>%@", activity);
//            NSLog(@"[[_motionQueue operations] count]:%d, [_motionQueue operationCount]:%d", [[_motionQueue operations] count], [_motionQueue operationCount]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString *strTextView = [textView.text stringByAppendingString:[NSString stringWithFormat:@"\nactivity>>>>>%@", activity]];
//                textView.text = strTextView;
            });
        }];
    }
    
    if ([CMStepCounter isStepCountingAvailable]) {
        // Available
        [_stepCounter queryStepCountStartingFrom:fromeDate to:[NSDate date] toQueue:_stepQueue withHandler:^(NSInteger numberOfSteps, NSError *error) {
            NSLog(@"numberOfSteps:%d, error:%@", (int)numberOfSteps, error);
            NSLog(@"[[_stepQueue operations] count]:%d, [_stepQueue operationCount]:%d", (int)[[_stepQueue operations] count], (int)[_stepQueue operationCount]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *strTextView = [textView.text stringByAppendingString:[NSString stringWithFormat:@"\nnumberOfSteps:%d", (int)numberOfSteps]];
                textView.text = strTextView;
            });
        }];
        
        [_stepCounter startStepCountingUpdatesToQueue:_stepQueue updateOn:2 withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
            NSLog(@"numberOfSteps>>>>>%d ==== timestamp:%@ ==== error%@", (int)numberOfSteps, timestamp, error);
//            NSLog(@"[[_stepQueue operations] count]:%d, [_stepQueue operationCount]:%d", [[_stepQueue operations] count], [_stepQueue operationCount]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString *strTextView = [textView.text stringByAppendingString:[NSString stringWithFormat:@"\nnumberOfSteps>>>>>%d ==== timestamp:%@", numberOfSteps, timestamp]];
//                textView.text = strTextView;
            });
        }];
    }
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - dealloc

- (void)dealloc
{
#ifdef __IPHONE_7_0
    [_motionManager stopActivityUpdates];
    [_stepCounter stopStepCountingUpdates];
#endif
}

@end
