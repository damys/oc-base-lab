

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Gender.h"

@interface God : NSObject{
    @public
    NSString *_name;
    int _age;
    Gender _gender;

}

//可以杀人
- (void)killWithPerson:(Person *)per;


//只创造人
- (Person *)makePerson;


//创造人,还指定姓名,年龄,活多长, 性别
- (Person *)makePersonWithName:(NSString *)name andAge:(int)age andGender:(Gender)gender andLeftLife:(int)leftLife;


@end
