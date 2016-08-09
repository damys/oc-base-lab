#import "God.h"

@implementation God

//杀死人
- (void)killWithPerson:(Person *)per{
    per->_leftLife = 0;
    NSLog(@"名子叫做%@的人已经死了!", per->_name);
}


//只创造人
- (Person *)makePerson{
    Person *person = [Person new];
    person->_name = @"夏娃";
    person->_age  = 1;
    person->_leftLife = 12345;
    person->_gender = GenderFeMale;
    
    return person;
}


//创造人,还指定姓名,年龄,活多长,性别
- (Person *)makePersonWithName:(NSString *)name andAge:(int)age andGender:(Gender)gender andLeftLife:(int)leftLife{
    
    Person *person = [Person new];
    person->_name = name;
    person->_age  = age;
    person->_leftLife = leftLife;
    person->_gender   = gender;
    
    return person;
}

@end
