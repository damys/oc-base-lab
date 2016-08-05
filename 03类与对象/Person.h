

#import <Foundation/Foundation.h>
#import "Gender.h"

@interface Person : NSObject{
    @public
    NSString *_name;
    int _age;
    Gender _gender;
    int _leftLife;     //活多少年
}

- (void)show;
@end
