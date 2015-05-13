

#import "ResourcesManager.h"
#import "UIImage+Category.h"

@implementation ResourcesManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ResourcesManager)

- (id)init
{
	if (self = [super init])
	{
		m_defaultSkinPath = [[self defaultSkinPath] copy];
	}
	return self;
}

-(void)dealloc
{
	[m_defaultSkinPath release];
    m_defaultSkinPath = nil;
	[super dealloc];
}

- (NSString *)getiPhone5FileName:(NSString *)name
{
	if (name != nil) 
	{
		NSString *nameEx = [name pathExtension];
		int nameExLen = (int)[nameEx length];
		int nameLen = (int)[name length];
		int index = nameLen - nameExLen - 1;
		if ((index < 0)||(index > nameLen)) 
		{
			return name;
		}
		NSString *subStr = [name substringToIndex:index];
        NSString *finStr = [subStr stringByAppendingFormat:@"-568h.%@",nameEx];
		return finStr;			
	}
	return name;
}

- (NSString *)defaultSkinPath
{
    return [NSString stringWithFormat:@"%@/Resource/Image", [[NSBundle mainBundle] resourcePath]];
}

- (UIImage *)imageWithFileName:(NSString *)name
{
	if(name == nil)
		return nil;
    
    return [self imageWIthFilePath:[m_defaultSkinPath stringByAppendingPathComponent:name]];
}

- (UIImage *)imageWIthFilePath:(NSString *)path
{
	if(path == nil)
		return nil;
    
    UIImage * image = nil;
    if (iPhone5)
    {
        NSString *finName5 = [self getiPhone5FileName:path];
        image = [UIImage imageWithContentsOfFile:finName5];
        if (image != nil) {
            return image;
        }
    }
    
    image = [UIImage imageWithContentsOfFile:path];
    if (image != nil) {
        return image;
    }
    
    if ([path rangeOfString:@"@2x"].location != NSNotFound) {
        NSString *newPath = [path stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
        image = [UIImage imageWithContentsOfFile:newPath];
    } else {
        NSString *extension = [path pathExtension];
        NSString *newPath = [path stringByDeletingPathExtension];
        newPath = [NSString stringWithFormat:@"%@@2x.%@", newPath, extension];
        image = [UIImage imageWithContentsOfFile:newPath];
    }
    
    return image;
}

@end
