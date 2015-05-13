//
//  PHActionSheet.h
//  PHUtility-AppStore
//
//  Created by Lin Xiaobin on 14-3-14.
//  Copyright (c) 2014年 Lin Xiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHActionSheet : UIActionSheet

@property (nonatomic, assign) BOOL autoDismissWhenEnterBackground;

- (id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate
    cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
