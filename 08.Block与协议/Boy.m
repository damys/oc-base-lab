
#import "Boy.h"

@implementation Boy

//谈恋爱的方法
- (void)talkLove{
    NSLog(@"talkLove...begin");
    [_girlFriend wash];
    [_girlFriend cook];
    NSLog(@"talkLove...end");
}

@end
