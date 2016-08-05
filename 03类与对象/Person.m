

#import "Person.h"

@implementation Person


- (void)show{

    NSLog(@"我叫%@, 性别:%d, 我还有%d年可以活!", _name, _gender,_leftLife);
}

@end
