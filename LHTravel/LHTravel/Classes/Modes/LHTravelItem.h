//
//  LHTravelItem.h
//  LHTravel
//
//  Created by leihui on 15/5/25.
//  Copyright (c) 2015年 ND WebSoft Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHTravelItem : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, assign) CGFloat star;
@property (nonatomic, assign) NSInteger numberOfComments;
@property (nonatomic, assign) NSInteger consumePerPerson;

@end
