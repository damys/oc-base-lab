
#import <Foundation/Foundation.h>
#import "GFProtocol.h"

@interface Boy : NSObject <GFProtocol>
@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign)int age;
@property(nonatomic, assign)int money;
@property(nonatomic, strong)id<GFProtocol> girlFriend;

//谈恋爱的方法
- (void)talkLove;

@end
