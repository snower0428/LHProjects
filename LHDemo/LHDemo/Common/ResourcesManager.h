

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SynthesizeSingleton.h"

typedef enum
{
	kExtendRes,
	kHomePageRes,
	kNotificationCenterRes,
	kThemeRes,
	kWidgetRes,
}ResPathType;


@interface ResourcesManager : NSObject 
{
	NSString *m_defaultSkinPath;
}

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(ResourcesManager)

- (UIImage *)imageWithFileName:(NSString *)name;
- (UIImage *)imageWIthFilePath:(NSString *)path;

@end
