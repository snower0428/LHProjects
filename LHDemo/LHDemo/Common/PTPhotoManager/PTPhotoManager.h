//
//  PTPhotoManager.h
//  PoTu
//
//  Created by leihui on 15/6/24.
//  Copyright (c) 2015年 ~. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"

typedef void(^SavePhotoCompletion)(NSError* error);
typedef void(^CheckPhotoAccessCompletion)(NSError* error);

@protocol PTPhotoManagerDelegate <NSObject>
@optional

- (void)savePhotoFinish;

@end

@interface PTPhotoManager : NSObject

@property (nonatomic, assign) id<PTPhotoManagerDelegate> delegate;

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(PTPhotoManager)

//保存到相册
-(void)saveImageToPhotos:(UIImage*)image;
-(void)saveImageToPhotos:(UIImage*)image toAlbum:(NSString*)albumName;

//保存到相册，无提示
-(void)savePhoto:(UIImage *)image withCompletionBlock:(SavePhotoCompletion)completionBlock;
-(void)savePhoto:(UIImage *)image toAlbum:(NSString*)albumName withCompletionBlock:(SavePhotoCompletion)completionBlock;

@end
