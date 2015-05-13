//
//  AlertMessage.h
//  AlertMessage
//
//  Created by Lizhen Zhan on 13-7-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHAlertView.h"
#import "PHActionSheet.h"

extern NSInteger const kDefaltAlertViewTag;
extern NSInteger const kDefaltActionSheetTag;

@interface PHAlertMessage : NSObject

/*
 * alert with none delegate and kDefaltAlertViewTag
 * auto dismiss while enter background 
 */
+ (PHAlertView *)alertMessage:(NSString *)message title:(NSString *)title
   cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/*
 * alert with delegate and custom tag
 * auto dismiss while enter background
 */
+ (PHAlertView *)alertMessage:(NSString *)message title:(NSString *)title delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger) tag
   cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;



/*
 * actionSheet with none delegate and kDefaltActionSheetTag
 * auto dismiss while enter background
 */
+ (PHActionSheet *)actionSheetTitle:(NSString *)title inView:(UIView *)view
       cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesotherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/*
 * actionSheet with delegate and custom tag
 * auto dismiss while enter background
 */
+ (PHActionSheet *)actionSheetTitle:(NSString *)title inView:(UIView *)view delegate:(id<UIActionSheetDelegate>)delegate tag:(NSInteger) tag
       cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitlesotherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
