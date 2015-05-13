
#import <Foundation/Foundation.h>


@interface NSObject(Extent)

+ (NSString *)className;

- (void)setPropertiesWithDictionary:(NSDictionary *)dict;
- (NSString *)className;
- (void)log;
//---performSelector->More parameters
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;

@end
