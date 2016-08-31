//
//  Person.m
//  oc base
//
//  Created by damys on 16/7/30.
//  Copyright © 2016年 damys. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)dealloc{
    //当人对象挂的时候,代表当前这个人对象就不会再使用_car指向的对象了.
    //我们说,当不再使用1个对象的时候 应该为这个对象发送1条releae 消息
    
    [_car release];
    [_name release];
    
    NSLog(@"人挂了");
    [super dealloc];   //调用下父类的方法
}

- (void)setCar:(Car *)car{
    //_car = car;
    
    //改进1: 将传入的车对象赋值给当前对象的_car属性. 代表: 传入的对象多了1个人使用.
    //那么就应该先为这个对象发送1条retain消息
    //[car retain];       为传进来的对象发送1条retain消息,代表多1个人使用.
    //_car = [car retain];
    
    
    //改进2: 为传进来的对象发送1条retain消息,让他的引用计数器的值+1, 代表多1个人使用.
    //再将传入的对象赋值给当前对象的_car属性.
    
    //当我们将传入的Car对象赋值给_car属性的时候.
    //代表1: _car属性原本指向的对象少1个人使用.
    //代表2: 传入的对象多1个使用.
    //所以,我们应该先将_car属性原本指向的对象release 再将传入的新对象retain
//    [_car release];       //没有人要release 掉, 即-1
//    _car = [car retain];
    
    
    //改进3: 出现的僵尸对象错误的原因:
    if(_car != car){         //说明新旧对象不是同1个对象.
        [_car release];      //才去release旧的
        _car = [car retain]; //retain新的.
    }
}

- (Car *)car{
    return _car;
}

//是一个对象,也要release , dealloc 增加: [_name release];
- (void)setName:(NSString *)name{
    if(_name != name){
        [_name release];
        _name = [name retain];
    }
}
- (NSString *)name{
    return _name;
}

//属性不是OC对象类型的 setter方法直接赋值就可以了
- (void)setAge:(int)age{
    _age = age;
}
- (int)age{
    return _age;
}

- (void)drive{
    NSLog(@"开动车子");
    [_car run];
}
@end
