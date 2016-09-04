

#import <Foundation/Foundation.h>

@interface Pig : NSObject
@property(nonatomic,retain)NSString *name;
@property(nonatomic,assign)int age;
@property(nonatomic,assign)float weight;

- (instancetype)initWithName:(NSString *)name andAge:(int)age andWeight:(float)weight;

+ (instancetype)pig;

+ (instancetype)pigWithName:(NSString *)name andAge:(int)age andWeight:(float)weight;

@end
