

#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Cat : NSObject
{
    @public
    NSString *_name;
    int age;
}
- (void) call:(Dog *) dog;
@end
