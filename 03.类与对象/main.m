/*
 
 上帝与人的故事:
 
 */

#import <Foundation/Foundation.h>
#import "God.h"

int main(int argc, const char * argv[]) {

    God *god = [God new];
    god->_name = @"耶稣";
    god->_age   = 123456;
    god->_gender = GenderMale;
    
    Person *p1 = [Person new];
    p1->_name = @"Tom";
    p1->_age  = 99;
    p1->_leftLife = 1;
    p1->_gender = GenderMale;
    
    //上帝可以杀死一个人
    [god killWithPerson:p1];
    NSLog(@"p1->_leftLife = %d", p1->_leftLife);   //0
    
    //上帝只创造人
    Person *p2 = [god makePerson];
    [p2 show];     //我叫夏娃, 我还有12345年可以活!
    
    //上帝创建人的同时,还指定姓名,年龄,活多长,性别
    Person *p3 = [god makePersonWithName:@"老王" andAge:30 andGender:GenderMale andLeftLife:70];
    [p3 show];    //我叫老王, 我还有70年可以活!
    
}
