
#import <Foundation/Foundation.h>

@interface Person : NSObject{
    NSString *_name;
}

//名子
- (void)setName: (NSString *)name;
- (NSString *)name;

//help
- (void)help;

@end
