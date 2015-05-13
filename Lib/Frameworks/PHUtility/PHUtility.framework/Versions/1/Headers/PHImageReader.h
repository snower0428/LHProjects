

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SynthesizeSingleton.h"

//#define IMAGE(name) IMAGE(name, [[NSBundle mainBundle] bundlePath])
//#define IMAGE(imagePath, bundlePath) [[PHImageReader sharedInstance] imageWithRelativePath:imagePath bundlePath:bundlePath]

typedef NS_ENUM(NSInteger, PHImageSourceType) {
    PHImageSourceTypeDefault = 0,
    PHImageSourceTypeCurrentDevice = 1,
};

@interface PHImageReader : NSObject 
{
}

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(PHImageReader)

/*
 * 获取图片资源，高端设备可使用低端设备资源
 * iPhone6 Plus: -h@3x, -h@2x, -h@1x, @3x, @2x, @1x
 * iPhone5/iPhone6: -h@2x, -h@1x, @2x, @1x,
 * iPhone4: @2x, @1x
 */
- (UIImage *)imageWithFilePath:(NSString *)path;
- (UIImage *)imageWithRelativePath:(NSString *)imagePath bundlePath:(NSString *)bundlePath;

/*
 * 判断图片资源是否存在，高端设备可使用低端设备资源
 */
+ (NSString *)imageExistAtPath:(NSString *)path;
+ (NSString *)imageExistAtPath:(NSString *)path sourceType:(PHImageSourceType)sourceType;

/*
 * 为资源地址添加设备适配后缀
 */
+ (NSString *)adaptDeviceImagePath:(NSString *)path withHeight:(BOOL)height;



@end
