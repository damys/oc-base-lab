
#import "CZNumber.h"

@implementation CZNumber
- (instancetype)initWithIntValue:(int)value
{
    if(self = [super init])
    {
        self.intValue = value;
    }
    return self;
}
+ (instancetype)numberWithIntValue:(int)value
{
    return [[self alloc] initWithIntValue:value];
}
@end
