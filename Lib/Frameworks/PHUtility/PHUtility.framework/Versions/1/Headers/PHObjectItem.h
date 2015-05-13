//
//  PHObjectItem.h
//  Backup
//
//  Created by Lin Xiaobin on 14-3-21.
//  Copyright (c) 2014年 linxiaobin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHObjectItem : NSObject

+ (NSMutableArray *)itemsWithContentsOfFile:(NSString *)path;
+ (instancetype)itemWithContentsOfFile:(NSString *)path;
+ (NSMutableArray *)itemsWithDictionaryItems:(NSArray *)dictItems;
+ (instancetype)itemWithDictionaryItem:(NSDictionary *)dictItem;

+ (BOOL)writeItems:(NSArray *)items toFileAtPath:(NSString *)path;
+ (BOOL)writeItem:(PHObjectItem *)item toFileAtPath:(NSString *)path;
+ (NSMutableArray *)dictionaryItemsWithItems:(NSArray *)items;
+ (NSMutableDictionary *)dictionaryItemWithItem:(PHObjectItem *)item;

- (NSString *)description;

@end
