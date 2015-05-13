//
//  LHCoreImageViewController.m
//  LHDemo
//
//  Created by leihui on 13-9-16.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import "LHCoreImageViewController.h"

@interface LHCoreImageViewController ()

@end

@implementation LHCoreImageViewController

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
    
    UIBarButtonItem *rightItem1 = [[[UIBarButtonItem alloc] initWithTitle:@"Button1" style:UIBarButtonItemStyleBordered target:self action:@selector(action1:)] autorelease];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem1, nil];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 213)];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.image = [UIImage imageNamed:@"image.png"];
    [self.view addSubview:_imageView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 250, self.view.frame.size.width-40, 50)];
    [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
    [slider release];
    
    //
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    _image = [[CIImage imageWithContentsOfURL:url] retain];
    _context = [[CIContext contextWithOptions:nil] retain];
    _filter = [[CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, _image, @"inputIntensity", [NSNumber numberWithFloat:0.0], nil] retain];
    CIImage *outputImage = [_filter outputImage];
    
    CGImageRef imageRef = [_context createCGImage:outputImage fromRect:[outputImage extent]];
    _imageView.image = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)action1:(id)sender
{
//    // 1
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    
//    // 2
//    CIImage *beginImage = [CIImage imageWithContentsOfURL:url];
//    
//    // 3
//    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
//    CIImage *outputImage = [filter outputImage];
//    
//    // 4
//    UIImage *image = [UIImage imageWithCIImage:outputImage];
//    _imageView.image = image;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    
    CIImage *beginImage = [CIImage imageWithContentsOfURL:url];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, beginImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    _imageView.image = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
}

- (void)sliderAction:(UISlider *)slider
{
    float value = slider.value;
    NSLog(@"value:%f", value);
    [_filter setValue:[NSNumber numberWithFloat:value] forKey:@"inputIntensity"];
    CIImage *outputImage = [_filter outputImage];
    
    CGImageRef imageRef = [_context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    _imageView.image = image;
    
    CGImageRelease(imageRef);
}

#pragma mark - dealloc

- (void)dealloc
{
    [_imageView release];
    
    [_context release];
    [_filter release];
    [_image release];
    
    [super dealloc];
}

@end
