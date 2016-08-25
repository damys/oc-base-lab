#import "Person.h"

@implementation Person

////名子
//- (void)setName: (NSString *)name{
//    _name = name;
//}
//- (NSString *)name{
//    return _name;
//}


//say
- (void)say{
    NSLog(@"help...");
}

+ (void)hi{
    NSLog(@"hi...");
}

+ (id)person{
    //return [Person new]; //写死,创建都是Person
    return [self new];     //不能写死,这样创建就是本身
}
@end
