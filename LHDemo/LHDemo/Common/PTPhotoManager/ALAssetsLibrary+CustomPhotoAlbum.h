//
//  ALAssetsLibrary+CustomPhotoAlbum.h
//  PandaHome
//
//  Created by ZZF on 13-7-5.
//  Copyright (c) 2013年 ND WebSoft Inc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^SaveImageCompletion)(NSError* error);

@interface ALAssetsLibrary(CustomPhotoAlbum)

-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

- (void)saveImage:(UIImage *)image
          toAlbum:(NSString *)albumName
  completionBlock:(ALAssetsLibraryWriteImageCompletionBlock)completionBlock
     failureBlock:(ALAssetsLibraryAccessFailureBlock)failureBlock;

-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

@end
