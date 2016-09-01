/*
 
1. 内存管理:
    内存的作用:存储数据.
    1) 如何将数据存储到内存之中.声明1个变量.然后将数据存储进去.
    2) 当数据不再被使用的时候,占用的内存空间如何被释放.
 

    1.1 内存中的五大区域
        栈:    局部变量. 当局部变量的作用域被执行完毕之后,这个局部变量就会被系统立即回收.
        堆:    OC对象.使用C函数申请的空间.
        BSS段: 未初始化的全局变量、静态变量. 一旦初始化就回收 并转存到数据段之中.
        数据段: 已经初始化的全局变量、静态变量. 直到程序结束的时候才会被回收.
        代码段: 代码. 程序结束的时候,系统会自动回收存储在代码段中的数据.

        栈、BSS段、数据段、代码段存储在它们中的数据的回收,是由系统自动完成的.不需要我们干预.
        存储在堆中的OC对象,系统不会自动回收. 直到程序结束的时候才会被回收.
 
    1.2 内存管理的范围:
        只需要管理存储在堆中的OC对象的回收.其他区域中的数据的回收是系统自动管理的.
     
    1.3 对象应该什么时候被回收?
        当有人使用这个对象的时候,这个对象就千万不能回收.
        只有在没有任何人使用这个对象的时候,才可以回收.
 
    1.4. 引用计数器
        1) 每1个对象都有1个属性叫做retainCount(引用计数器). 类型是unsigned long 占据8个字节.
            引用计数器的[作用]: 用来记录当前这个对象有多少个人在使用它.
            默认情况下,创建1个对象出来 这个对象的引用计数器的默认值是1.
        2) 当多1个人使用这个对象的时候.应该先让这个对象的引用计数器的值+1 代表这个对象多1个人使用.
        3) 当这个对象少1个人使用的时候.应该先让这个对象的引用计数器的值-1 代表这个对象少1个人使用.
        4) 当这个对象的引用计数器变为0的时候.代表这个对象无人使用. 这个时候系统就会自动回收这个对象.
 
    1.5. 如何操作引用计数器.
        1) 为对象发送1条retain消息. 对象的引用计数器就会加1. 当多1个人使用对象的时候才发.
        2) 为对象发送1条release消息.对象的引用计数器就会减1. 当少1个人使用对象的时候才发.
        3) 为对象发送1条retainCount消息. 就可以去到对象的引用计数器的值.
            就这样++ --, 当对象的引用计数器变为0的时候,对象就会被系统立即回收.
            在对象被回收的时候.会自动调用对象的dealloc方法.--类似于析构函数
 
    重点和难点:
        什么时候为对象的引用计数器+1
        什么时候为对象的引用计数器-1
 

2. 内存管理的分类
    2.1 MRC: Manual Reference Counting 手动引用计数.手动内存管理.
       当多1个人使用对象的时候,要求程序员手动的发送retain消息.少1个人使用的时候程序员手动的发送relase消息.
 
    2.2 ARC: Automatic Reference Counting  自动引用计数.自动内存管理.(2011年之前 iOS5之前.)
       系统自动的在合适的地方发送retain relase消息.

    2.3 学习MRC的理由:
        a) 面试必考 100%
        b) 早期的APP开发使用的MRC技术.
        c) iOS大牛都是从MRC成长起来的. 方便交流.
        d) ARC是基于MRC
 
    2.4 iOS5开始. Xcode4.2开始就支持ARC
        Xcode7 默认支持ARC开发.
        默认使用的开发方式就是ARC的模式. 关闭ARC开启MRC. (选择项目->all->apple LLVM language Object C->ARC-'NO')
 
 
    2.5. 当对象的引用计数器变为0的时候,系统会自动回收对象.
        在系统回收对象的时候.会自动的调用对象的dealloc方法.

        重写dealloc方法的规范:
        必须要调用父类的dealloc方法. 并且要放在最后一句代码.  [super dealloc]
        原因:子类中有父类的属性,而父类属性的release 是放在父类的dealloc方法之中,为了释放所有对象,要调用父类dealloc 方法
 
    2.6 测试引用计数器.
        1. 新创建1个对象,这个对象的引用计数器的值默认是1.
        2. 当对象的引用计数器变为0的时候.对象就会被系统立即回收 并自动调用dealloc方法.
        3. 为对象发送retain消息 对象的引用计数器就会+1

    2.7 为对象发送release消息.并不是回收对象.而是让对象的引用计数器-1
        当对象的引用计数器的值变为0的时候.对象才会被系统立即回收.
 
 
3. 内存管理的重点
    3.1. 什么时候为对象发送retain消息.
        当多1个人使用这个对象的时候,应该先为这个对象发送retain消息. +1

    3.2 什么时候为对象发送releaee消息.
        当少1个人使用这个对象的时候.应该为这个对象发送1条release消息. -1
 
    3.3 在ARC机制下,retain, release, dealloc 这些方法方法无法调用.
 
    3.4 内存管理的原则
        1). 有对象的创建,就要匹配1个release
        2). retain的次数和release的次数要匹配.
        3). 谁retain. 谁release.
        4). retain个数与release 一定要平衡.
 
4. 野指针与僵尸对象
    4.1 野指针
        C语言中的野指针: 定义1个指针变量.没有初始化.这个指针变量的值是1个垃圾值,指向1块随机的空间.这个指针就叫做野指针.
        OC中  的野指针: 指针指向的对象已经被回收了.这样的指针就叫做野指针.

    4.2 对象回收的本质.
        a) 申请1个变量,实际上就是向系统申请指定字节数的空间.这些空间系统就不会再分配给别人了.
        b) 当变量被回收的时候,代表变量占用的字节空间从此以后系统可以分配给别人使用了.
        c) 但是字节空间中存储的数据还在.

    4.3 回收对象: 指的是对象占用的空间可以分配给别人.
        当这个对象占用的空间没有分配给别人之前 其实对象数据还在.
 
    4.4 僵尸对象
        1个已经被释放的对象,但是这个对象所占的空间还没有分配给别人.这样的对象叫做僵尸对象.
        我们通过野指针去访问僵尸对象的时候.有可能没问题 也有可能有问题.
        当僵尸对象占用的空间还没有分配给别人的时候.这是可以的.

    4.5 我们认为只要对象称为了僵尸对象,无论如何 都不允许访问了.
        就希望如果访问的是僵尸对象,无论如何报错.
        僵尸对象的实时检查机制.可以将这个机制打开. 打开之后. 只要访问的是僵尸对象,无论空间是否分配 就会报错.
           机制打开:选择运行项->Edit Scheme->Diagnostics->选中:Enable Zombie Object  :不建议打开
 
    4.6 为什么不默认打开僵尸对象检测.
        一旦打开僵尸对象检测 那么在每访问1个对象的时候 都会先检查这个对象是否为1个僵尸对象,这样是极其消耗性能的.

    4.7 使用野指针访问僵尸对象会报错. 如何避免僵尸对象错误..
        当1个指针称为野指针以后.将这个指针的值设置nil
        当1个指针的值为nil 通过这个指针去调用对象的方法(包括使用点语法)的时候.不会报错. 只是没有任何反应.
        但是如果通过直接访问属性 -> 就会报错.
 
    4.8 无法复活1个僵尸对象.
 

5. 单个对象的内存管理
    5.1 内存泄露.
        指的是1个对象没有被及时的回收.在该回收的时候而没有被回收
        一直驻留在内存中,直到程序结束的时候才回收.

    5.2 单个对象的内存泄露的情况.
        1) 有对象的创建,而没有对应的release
        2) retain的次数和release的次数不匹配.
        3) 在不适当的时候,为指针赋值为nil
        4) 在方法中为传入的对象进行不适当的retain

    5.3 如何保证单个对象可以被回收
        1) 有对象的创建 就必须要匹配1个release
        2) retain次数和release次数一定要匹配.
        3) 只有在指针称为野指针的时候才赋值为nil
        4) 在方法中布要随意的为传入的对象retain.
 
 
6. setter 方法的内存管理: 案例: Jack开车去旅行.
    人类: 属性:(车). 行为:(开车), 人有一辆人,将车作为人的属性
    车类: 属性:(速度). 行为:(行驶)

    6.1 当属性是1个OC对象的时候. setter方法的写法.
        将传进来的对象赋值给当前对象的属性,代表传入的对象多了1个人使用,所以我们应该先为这个传入的对象发送1条retain消息后再赋值
        当前对象销毁的时候.代表属性指向的对象少1个人使用. 就应该在dealloc中relase
        进化一: setter代码写法:
        - (void)setCar:(Car *)car{
            _car = [car retain];
        }

        - (void)dealloc{
            [_car release];
            [super dealloc];
        }

    6.2 当属性是1个OC对象的时候,setter方法照着上面那样写,其实还是有Bug的.
        当为对象的这个属性多次赋值的时候.就会发生内存泄露.
        发生泄露的原因: 当为属性赋值的时候, 代表旧对象少1个人用.新对象多1个人使用. 应该release旧的 retain新的.
        进化二: setter代码写法:
        - (void)setCar:(Car *)car{
            [_car release];        //代表旧对象少1个人用. -1
            _car = [car retain];   //新对象多1个人使用.  +1
        }
        这样旧的没有被指向到的也会被销毁.


    6.3 出现的僵尸对象错误的原因:
        在于.新旧对象是同1个对象.
        解决的方案:  当发现新旧对象是同1个对象的时候.什么都不用做.
        最终完美版的setter方法的写法: 当判断一下:当新旧对象不是同1个对象的时候 才release旧的 retain新的.
        进化三: setter代码写法:
        - (void)setCar:(Car *)car{
            if(_car != car){
                [_car release];
                _car = [car retain];
            }
        }

    6.4 特别注意.
        我们每次管理的范围是 OC 对象.
        所以,只有属性的类型是OC对象的时候.这个属性的setter方法才要像上面那样写.
        如果属性不是OC对象类型的 setter方法直接赋值就可以了.
 
 
7. 在MRC的开发模式下.1个类的属性如果是1个OC对象类型的.那么这个属性的setter方法就应该按照下面的格式写.
    - (void)setCar:(Car *)car{
        if(_car != car){
            [_car release];
            _car = [car retain];
        }
    }

    还要重写dealloc方法.
    - (void)dealloc{
        [_car release];
        [super delloc];
    }

    注意:如果属性的类型不是OC对象类型的.不需要像上面那样写. 还是像之前那样写就OK了.
 
 
8. @property
    8.1 作用
        a. 自动生成私有属性.
        b. 自动生成这个属性的getter setter方法的声明.
        c. 自动生成这个属性的getter setter方法的实现.

    8.2 注意: 生成的setter方法的实现中,无论是什么类型的,都是直接赋值.
 
    8.3 @property参数.
        1). @property可以带参数的.
            @property(参数1,参数2,参数3......)数据类型 名称;

        2). 介绍一下@property的四组参数.
            a. 与多线程相关的两个参数.                   atomic、nonatomic.
            b. 与生成的setter方法的实现相关的参数.        assign、retain.
            c. 与生成只读、读写相关的参数.               readonly readwrite
            d. 是与生成的getter setter方法名字相关的参数. getter  setter
 
    第一组: 介绍与多线程相关的参数.
        1) atomic: 默认值. 如果写atomic,这个时候生成的setter方法的代码就会被加上一把线程安全锁.
                特点: 安全、效率低下.
        2) nonatomic: 如果写nonatomic 这个时候生成的setter方法的代码就不会加线程安全锁.
                特点: 不安全,但是效率高.
        建议: 要效率. 选择使用nonatomic. 在没有讲解多线程的知识以前. 统统使用nonatomic

    第二组: 与生成的setter方法的实现相关的参数.
        1) assign: 默认值 生成的setter方法的实现就是直接赋值.
        2) retain: 生成的setter方法的实现就是标准的MRC内存管理代码.
                机制: 先判断新旧对象是否为同1个对象. 如果不是 release 旧的 retain新的.

        当属性的类型是OC对象类型的时候,那么就使用retain
        当属性的类型是非OC对象的时候,使用assign.

        注意: retain参数.只是生成标准的setter方法为标准的MRC内存管理代码 不会自动的再dealloc中生成release的代码.
              所以, 我们还要自己手动的在dealloc中release
 
    第三组: 与生成只读、读写的封装.
        1) readwrite: 默认值.代表同时生成 getter setter
        2) readonly : 只会生成getter 不会生成setter

    第四组: 生成getter、setter方法名称相关的参数.
        默认情况下.@property生成的getter, setter方法的名字都是最标准的名字.
        1) getter = getter方法名字 用来指定@property生成的getter方法的名字.
        2) setter = setter方法名字.用来指定@property生成的setter方法的名字. 注意.setter方法是带参数的 所以要加1个冒号.

        记住:如果使用getter setter修改了生成的方法的名字.
            在使用点语法的时候.编译器会转换为调用修改后的名字的代码.

        修改建议: 一般情况下不要去改.
        1). 无论什么情况都不要改setter方法的名字. 因为默认情况下生成的名字就已经是最标准的了.
        2). 什么时候修改getter方法的名字.当属性的类型是1个BOOL类型的时候.就修改这个getter的名字以is开头 提高代码的阅读性.

9. @class
    9.1 当两个类相互包含的时候. 当Person.h中包含Book.h 而Book.h中又包含Person.h
        这个时候,就会出现循环引用的问题. 就会造成无限递归的问题,而导致无法编译通过.

    9.2 解决方案:
        其中一边不要使用#import引入对方的头文件.
        而是使用@class 类名; 来标注这是1个类.这样子就可以在不引入对方头文件的情况下,告诉编译器这是1个类.
        在.m文件中再#import 对方的头文件.就可以使用了. 不引也不会出错,只是不会提示

    9.3 @class与#import的区别
       1). #import是将指定的文件的内容拷贝到写指令的地方.
       2). @class 并不会拷贝任何内容. 只是告诉编译器,这是1个类,这样编译器在编译的时候才可以知道这是1个类.
 
 
10. 循环 retain
    10.1 当两个对象相互引用的时候.
        A对象的属性是B对象  B对象的属性是A对象.
        如果这两个@property都使用retain 就会出现泄漏.

    10.2 解决方案: 1端retain 1端assign 使用assign的那1端不再需要在dealloc中release了.

 
 
 
 
 */

#import <Foundation/Foundation.h>
/***
@interface Person : NSObject
@property NSString *name;

- (void)say;
@end

@implementation Person
//相关于析构函数
- (void)dealloc{
    NSLog(@"名字叫%@的人挂了",_name);
    [super dealloc];
}

- (void)say{
    NSLog(@"say....");
}
@end
**/




/**
 @property 参数使用
 
@interface Test : NSObject
@property(nonatomic, retain, readwrite) NSString *name;
@property(nonatomic, assign, readwrite, getter=aaa, setter=bbb:) int age;  //多处参数加:
@property(nonatomic, assign, getter=isGoodPerson) BOOL goodPerson;  //bool getter 阅读性 isGoodPerson
- (void)msg;
@end
@implementation Test
- (void)msg{
    NSLog(@"name is %@, age=%d", _name, _age);
}
@end

Test *t = [Test new];
t.name = @"test name";
t.age  = 29;          //setter
[t msg];

[t bbb:30];           //也可以用点来赋值了
NSLog(@"自定义getter 名子age:%d", [t aaa]);   //30
 
**/


#import "Person.h"
#import "Author.h"

int main(int argc, const char * argv[]) {
    

   Person *p1 = [[Person alloc] init]; //记数:1
   p1.name = @"Jack";
   
   NSInteger count = [p1 retainCount];
   NSLog(@"count=%lu", count);          //1
   
   [p1 retain];    //为对象发送retain消息 对象的引用计数器就会+1
   NSLog(@"count=%lu", p1.retainCount); //2
   
   
   [p1 release];   //为对象发送release消息.并不是回收对象.而是让对象的引用计数器-1
   NSLog(@"count=%lu", p1.retainCount); //1
   
   [p1 release];   //记数:0.   当对象的引用计数器的值变为0的时候.对象才会被系统立即回收.
    
    
    //原则1: 有对象的创建,就要匹配1个release, 否则这个对象就收不了
   Person *p1 = [Person new];          //记数:1
   [p1 setName:@"Jack"];
   [p1 release];                       //记数:0
    
    //原则2: retain的次数和release的次数要匹配. 达到平衡
   Person *p2 = [Person new];   //记数:1   要与release 匹配
   [p2 setName:@"Jack"];
   
   [p2 retain];
   [p2 retain];
   [p2 release];
   [p2 release];
   
   [p2 release];               //记数:0
    
    //回收对象, 注:其它空间没有分配给别人之前 其实对象数据还在
   Person *p1 = [Person new];
   //[p1 setName:@"Jack1"];
   p1.name = @"Jack2";
   [p1 release];    //记数:0
   [p1 say];        //有时有问题,有时没有问题,当空间分配给别人了 或 打开僵尸对象,就会出错
    
    //野指针访问僵尸对象会报错
   Person *p1 = [Person new];  //记数:1
   [p1 release];               //记数:0
   p1 = nil;        //当1个指针的值为nil 通过这个指针去调用对象的方法(包括使用点语法)的时候.不会报错. 只是没有任何反应.
   p1.name = @"Tom1";     //. 赋值时.只是没有任何反应
   //p1 setName:@"Tom2";  //  这个直接访问属性, 会出错
   [p1 say];       //执行不会报错,只是不会输出,没有任何反映
    
    
   //retain ,release 案例:人开车
   Person *jack = [Person new];  //jack:1
   
   //创建车:bmw
   Car *bmw = [Car new];         //bmw:1
   bmw.speed = 130;
   jack.car = bmw;               //bmw:2  被调用
   
   //创建车:benz
   Car *benz = [Car new];       //benz:1
   benz.speed = 150;
   jack.car = benz;             //benz:2  被调用
   
   //[jack drive]; //此时开的是benz, 即没有指向bmw.也没有开动
   
   [benz release];              //benz:1
   [bmw release];               //bmw:1
   
   //[jack drive];              //人是可以开车的,人还没有销毁
   [jack release];              //jack:0
   
    
    
    //@class, 综合安全
    Author *rose = [Author new];
    
    Book *book = [Book new];
    [rose read];
    
    [book release];
    [rose release];
    return 0;
}
















