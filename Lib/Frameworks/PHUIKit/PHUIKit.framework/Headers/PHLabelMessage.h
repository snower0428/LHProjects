//
//  PHLabelMessage.h
//  PandaSpace
//
//  Created by liucq on 09+9+16.
//  Copyright 2009 NetDragon Websoft Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHLabelMessage : NSObject{
}

@property (nonatomic, assign) BOOL isModel;
@property (nonatomic, assign) BOOL userInterface;

+ (PHLabelMessage*)shareInstance;
+ (void)exitInstance;

+ (void)showMessageLable:(NSString *)message inView:(UIView*)view;
+ (void)showMessageLable:(NSString *)message inView:(UIView*)view withTimeInterval:(CGFloat)interval;
+ (void)showMessageLable:(NSString *)message atTheCenter:(CGPoint)center ofView:(UIView*)view withTimeInterval:(CGFloat)interval;
+ (void)removeMessageLableInView:(id)view;
//
+ (void)showWaitMessageLabel:(NSString *)message inView:(UIView*)view;
+ (void)showWaitMessageLabel:(NSString *)message atTheCenter:(CGPoint)center ofView:(UIView*)view model:(BOOL)model;
+ (void)removeWaitMessageLabelInView:(UIView*)view;

+ (void)showActivityIndicatorViewInView:(UIView*)view;
+ (void)showActivityIndicatorViewInView:(UIView*)view withActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style atCenter:(CGPoint)center;
+ (void)removeActivityIndicatorViewInView:(UIView*)view;

@end
