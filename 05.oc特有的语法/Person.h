#import <Foundation/Foundation.h>

@interface Person : NSObject{
@property NSString *name;
}

//名子
//- (void)setName: (NSString *)name;
//- (NSString *)name;

- (void)say;
+ (void)hi;
+ (void)person;
@end
