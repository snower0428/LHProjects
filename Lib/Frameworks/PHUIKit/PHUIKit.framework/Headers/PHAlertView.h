//
//  PHAlertView.h
//  Test
//
//  Created by Lin Xiaobin on 14-2-13.
//  Copyright (c) 2014年 Lin Xiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHAlertView : UIAlertView

@property (nonatomic, assign) BOOL autoDismissWhenEnterBackground;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
