//
//  ImageEffectViewController.m
//  LHDemo
//
//  Created by leihui on 13-12-11.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//

#import "ImageEffectViewController.h"
#import "UIImage+ImageEffects.h"

@interface ImageEffectViewController ()
{
    UIImage     *_image;
    UIImageView *_backgroundView;
    UISlider    *_sliderRadius;
    UISlider    *_sliderAlpha;
    UISlider    *_sliderSaturationDeltaFactor;
    
    CGFloat     _radius;
    CGFloat     _alpha;
    CGFloat     _saturationDeltaFactor;
}

@end

@implementation ImageEffectViewController

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
    
    UIBarButtonItem *light = [[UIBarButtonItem alloc] initWithTitle:@"Light" style:UIBarButtonItemStylePlain target:self action:@selector(lightAction:)];
    UIBarButtonItem *extraLight = [[UIBarButtonItem alloc] initWithTitle:@"ExtraLight" style:UIBarButtonItemStylePlain target:self action:@selector(extraLightAction:)];
    UIBarButtonItem *dark = [[UIBarButtonItem alloc] initWithTitle:@"Dark" style:UIBarButtonItemStylePlain target:self action:@selector(darkAction:)];
    UIBarButtonItem *color = [[UIBarButtonItem alloc] initWithTitle:@"Color" style:UIBarButtonItemStylePlain target:self action:@selector(colorAction:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:light, extraLight, dark, color, nil];
    
    [light release];
    [extraLight release];
    [dark release];
    
    _radius = 5.0;
    _alpha = 0.2;
    _saturationDeltaFactor = 1.8;
    
    CGFloat leftMargin = 20;
    CGFloat width = SCREEN_WIDTH - leftMargin*2;
    CGFloat height = 30;
    CGFloat interval = 10;
    
    _image = [[UIImage imageNamed:@"test.png"] retain];
    UIImage *image = [_image applyBlurWithRadius:_radius tintColor:[UIColor colorWithWhite:1.0 alpha:_alpha] saturationDeltaFactor:_saturationDeltaFactor maskImage:nil];
    
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kTopShift, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backgroundView.image = image;
    [self.view addSubview:_backgroundView];
    
    NSInteger index = 3;
    CGRect sliderFrame = CGRectMake(leftMargin, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - (height + interval)*index, width, height);
    _sliderRadius = [[UISlider alloc] initWithFrame:sliderFrame];
    _sliderRadius.minimumValue = 0.0;
    _sliderRadius.maximumValue = 20.0;
    _sliderRadius.value = _radius;
    _sliderRadius.continuous = NO;
    [_sliderRadius addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sliderRadius];
    
    index--;
    sliderFrame = CGRectMake(leftMargin, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - (height + interval)*index, width, height);
    _sliderAlpha = [[UISlider alloc] initWithFrame:sliderFrame];
    _sliderAlpha.minimumValue = 0.0;
    _sliderAlpha.maximumValue = 1.0;
    _sliderAlpha.value = _alpha;
    _sliderAlpha.continuous = NO;
    [_sliderAlpha addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sliderAlpha];
    
    index--;
    sliderFrame = CGRectMake(leftMargin, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVIGATIONBAR_HEIGHT - (height + interval)*index, width, height);
    _sliderSaturationDeltaFactor = [[UISlider alloc] initWithFrame:sliderFrame];
    _sliderSaturationDeltaFactor.minimumValue = 0.0;
    _sliderSaturationDeltaFactor.maximumValue = 10.0;
    _sliderSaturationDeltaFactor.value = _saturationDeltaFactor;
    _sliderSaturationDeltaFactor.continuous = NO;
    [_sliderSaturationDeltaFactor addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_sliderSaturationDeltaFactor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)lightAction:(id)sender
{
    _backgroundView.image = [_image applyLightEffect];
}

- (void)extraLightAction:(id)sender
{
    _backgroundView.image = [_image applyExtraLightEffect];
}

- (void)darkAction:(id)sender
{
    _backgroundView.image = [_image applyDarkEffect];
}

- (void)colorAction:(id)sender
{
    _backgroundView.image = [_image applyTintEffectWithColor:[UIColor blueColor]];
}

- (void)sliderAction:(id)sender
{
    CGFloat value = ((UISlider *)sender).value;
    
    if (sender == _sliderRadius) {
        _radius = value;
    }
    else if (sender == _sliderAlpha) {
        _alpha = value;
    }
    else if (sender == _sliderSaturationDeltaFactor) {
        _saturationDeltaFactor = value;
    }
    UIImage *image = [_image applyBlurWithRadius:_radius tintColor:[UIColor colorWithWhite:1.0 alpha:_alpha] saturationDeltaFactor:_saturationDeltaFactor maskImage:nil];
    _backgroundView.image = image;
}

#pragma mark - dealloc

- (void)dealloc
{
    [_image release];
    [_backgroundView release];
    [_sliderRadius release];
    [_sliderAlpha release];
    [_sliderSaturationDeltaFactor release];
    
    [super dealloc];
}

@end
