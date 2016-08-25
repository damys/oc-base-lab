#import <Foundation/Foundation.h>

@interface Person : NSObject{
@property NSString *name;
}

////名子
//- (void)setName: (NSString *)name;
//- (NSString *)name;

//say
- (void)say;

+ (void)hi;

+ (void)person;

@end
