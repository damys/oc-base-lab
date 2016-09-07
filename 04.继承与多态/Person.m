
#import "Person.h"

@implementation Person

//名子
- (void)setName: (NSString *)name{
    _name = name;
}
- (NSString *)name{
    return _name;
}


//help
- (void)help{
    NSLog(@"help...");
}

- (NSString *)description{
    return [NSString stringWithFormat:@"姓名:%@", _name];
}
@end
