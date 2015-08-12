//
//  PTPhotoManager.m
//  PoTu
//
//  Created by leihui on 15/6/24.
//  Copyright (c) 2015年 ~. All rights reserved.
//

#import "PTPhotoManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"

#define kSaveAlertView		1000
#define kHelpAlertView		1001
#define kHelpImageViewTag	2002

@interface PTPhotoManager () <UIAlertViewDelegate>
{
	ALAssetsLibrary		*_assetsLibrary;
}

@end

@implementation PTPhotoManager

SYNTHESIZE_SINGLETON_FOR_CLASS(PTPhotoManager)

- (id)init
{
	self = [super init];
	if (self) {
		// Init
		if (_assetsLibrary == nil) {
			_assetsLibrary = [[ALAssetsLibrary alloc] init];
		}
	}
	
	return self;
}

- (void)showMessageTitle:(NSString *)title Message:(NSString *)msg
{
	//[PHAlertMessage alertMessage:msg title:title delegate:self tag:kHelpAlertView cancelButtonTitle:_(@"ok") otherButtonTitles:_(@"Help"),nil];
}

//保存到相册
-(void)saveImageToPhotos:(UIImage*)image
{
	[self saveImageToPhotos:image toAlbum:_(@"PoTu")];
}

-(void)saveImageToPhotos:(UIImage*)image toAlbum:(NSString*)albumName
{
	[_assetsLibrary saveImage:image toAlbum:albumName withCompletionBlock:^(NSError *error) {
		if (error!=nil) {
			MLOG(@"saveImage error: %@", [error description]);
			if ([error code] == -3311) {
				if (SYSTEM_VERSION < 6.0) {
					[self showMessageTitle:_(@"Do not have permissions") Message:_(@"Make sure you have enabled 91 Home in your device's Settings/Location Services")];
				}
				else {
					[self showMessageTitle:_(@"Do not have permissions") Message:_(@"Make sure you have enabled 91 Home in your device's Settings/Privacy/Photos")];
				}
			}
			else if ([error code] == -3312) {
				[self showMessageTitle:_(@"Do not have permissions") Message:_(@"Make sure you have enabled 91 Home in your device's Settings/Location Services")];
			}
		}
		else {
			//[PHLabelMessage showMessageLable:_(@"Successfully saved to the album") atTheCenter:CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2) ofView:[[[UIApplication sharedApplication] windows] objectAtIndex:0] withTimeInterval:1.5f];
			if (_delegate && [_delegate respondsToSelector:@selector(savePhotoFinish)]) {
				[_delegate savePhotoFinish];
			}
		}
	}];
}

//保存到相册，无提示
-(void)savePhoto:(UIImage *)image withCompletionBlock:(SavePhotoCompletion)completionBlock
{
	[self savePhoto:image toAlbum:_(@"PoTu") withCompletionBlock:completionBlock];
}

-(void)savePhoto:(UIImage *)image toAlbum:(NSString*)albumName withCompletionBlock:(SavePhotoCompletion)completionBlock
{
	[_assetsLibrary saveImage:image toAlbum:albumName withCompletionBlock:^(NSError *error) {
		completionBlock(error);
	}];
}

#pragma UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	
	if (buttonIndex == 1 && alertView.tag ==  kHelpAlertView)
	{
		//self showHelpScreenView];
	}
}

@end
