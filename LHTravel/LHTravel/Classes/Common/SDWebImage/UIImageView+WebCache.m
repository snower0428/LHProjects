/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
//#import "ServerIconsMgr.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURL:url placeholderImage:placeholder options:0];
}

//获取网络天气图标接口
//- (void)setImageWithUrlIconsName:(NSString *)iconName placeholderImage:(UIImage *)placeholder
//{
//    UIImage *image = [[ServerIconsMgr sharedInstance] imageWithFileName:iconName];
//    if ([image isKindOfClass:[UIImage class]]) {
//        self.image = image;
//    }else{
//        if ([[NetworkStatusMgr sharedInstance] getNetworkStatus]) {
//            self.image = placeholder;
//            NSString *iconUrl = [[ServerIconsMgr sharedInstance] imageIconUrlWithFileName:iconName];
//            if (iconUrl) {
//                [self setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:placeholder options:0];
//            }
//        }       
//    }
//}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options];
    }
}

#if NS_BLOCKS_AVAILABLE
- (void)setImageWithURL:(NSURL *)url success:(SDWebImageSuccessBlock)success failure:(SDWebImageFailureBlock)failure;
{
    [self setImageWithURL:url placeholderImage:nil success:success failure:failure];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder success:(SDWebImageSuccessBlock)success failure:(SDWebImageFailureBlock)failure;
{
    [self setImageWithURL:url placeholderImage:placeholder options:0 success:success failure:failure];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options success:(SDWebImageSuccessBlock)success failure:(SDWebImageFailureBlock)failure;
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    self.image = placeholder;

    if (url)
    {
        [manager downloadWithURL:url delegate:self options:options success:success failure:failure];
    }
}
#endif

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didProgressWithPartialImage:(UIImage *)image forURL:(NSURL *)url
{
//    NSString *fileName = [url.absoluteString lastPathComponent];
//    if ([[ServerIconsMgr sharedInstance] isServerIcon:fileName]) {
//        return;
//    }
	
    self.image = image;
    [self setNeedsLayout];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image forURL:(NSURL *)url userInfo:(NSDictionary *)info
{
//    NSString *fileName = [url.absoluteString lastPathComponent];
//    if ([[ServerIconsMgr sharedInstance] isServerIcon:fileName]) {
//        NSString *sdWebFilePath = [imageManager getImageFilePath:url];
//        if ([sdWebFilePath isKindOfClass:[NSString class]]) {
//            [[ServerIconsMgr sharedInstance] moveFromCacheToLocalPath:sdWebFilePath localName:fileName];
//        }
//    }
	
    self.image = image;
    [self setNeedsLayout];
}

@end
