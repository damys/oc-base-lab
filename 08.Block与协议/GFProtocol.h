
#import <Foundation/Foundation.h>
//女朋友协议,只要遵守这个协议的东西都可以作为男孩子的女朋友.
@protocol GFProtocol <NSObject>

@required      //必须
- (void)wash;
- (void)cook;

@optional      //有更好
- (void)job;

@end
