#import <Foundation/Foundation.h>

@interface Dog : NSObject
{
    @public
    NSString *_name;
    int _age;
}

- (void) say;
@end
