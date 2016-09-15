
#import <Foundation/Foundation.h>

@interface CZNumber : NSObject

@property(nonatomic,assign)int intValue;

- (instancetype)initWithIntValue:(int)value;
+ (instancetype)numberWithIntValue:(int)value;

@end
