/*
1. 延展:Extension
    1.1 介绍: 是1个特殊的分类. 所以延展也是类的一部分.
         特殊之处:
         a. 延展这个特殊的分类没有名字.
         b. 只有声明没有实现.和本类共享1个实现.
 
    1.2 延展的语法
        @interface 本类名 ()
        @end
        没有实现. 和本类共享1个实现.

    1.3 为类添加延展的步骤
        只有1个.h文件, 文件名称: 本类名_取得文件名.h, 生成:
        @interface Person ()
        @end
 
    1.4 延展的使用.
        1) 延展的本质是1个分类. 作为本类的一部分.只不过是1个特殊的分类没有名字.
        2) 延展只有声明,没有单独的实现. 和本类共享一个实现. 在本类中实现
 
    1.5 延展和分类的区别
        1) 分类有名字.延展没有名字 是1个匿名的分类.
        2) 每1个分类都有单独的声明和实现. 而延展只有声明 没有单独的实现 和本类共享1个实现,
        3) 分类中只能新增方法. 而延展中任意的成员都可以写.
        4) 分类中可以写@property 但是只会生成getter setter的声明.
           延展中写@property 会自动生成私有属性 也会生成getter setter的声明和实现.
 
    1.6 延展的应用场景.
        1) 要为类写1个私有的@property.
            生成getter、setter方法只能在类的内部访问 不能在外部访问.
            其实,我们可以想: @property生成私有属性、生成getter setter的实现,不要声明.

        2) 延展100%的情况下不会独占1个文件. 都是将延展直接写在本类的实现文件中.
            这个时候,写在延展中的成员,就相当于是这个类的私有成员.只能在本类的实现中访问. 外部不能访问.

        3) 什么时候使用延展?
            当我们想要为类定义私有成员的时候,就可以使用延展. 将延展定义在这个类的实现文件中.

        如果想要为类写1个真私有属性,虽然我们可以定义在@implementation之中.但是不要这么写 这样很不规范.
        写1个延展.将这个私有属性定义在延展中.

        如果要为类写1个私有方法,建议将声明写在延展中, 实现写在本类的实现中. 提供代码的阅读性
        如果想要为类写1个私有的@property 就直接写在延展就可以了.

        4) 延展天生就是来私有化类的成员的.
            如果类的成员只希望在类的内部访问,那么就将其定义在延展中.
            如果类的成员允许被外界访问 定义在本类的@interface中.


2. Block
    2.1 OC在C的基础之上新增了一些数据类型.
        BOOL, Boolean, class, nil, SEL, id, block
 
    2.2 block是1个数据类型.  如: int, double, float, char .......
        既然是1个数据类型,那么就可以声明这个数据类型的变量. 所以我们完全也可以声明1个block类型的变量.
        不同类型的变量中可以存储不同类型的数据.
        block类型的变量: 专门存储1段代码. 这段代码可以有参数, 可以有返回值.

    2.3 block变量的声明:
        返回值类型 (^block变量的名称)(参数列表);
        void (^myBlock1)(); 表示声明了1个block类型的变量叫做myBlock1 这个变量中只能存储没有返回值没有参数的代码段.
        int (^myBlock2)();
        int (^myBlock3)(int num1,int num2);

    2.4 注意:
        声明block变量的时候要指定这个block变量可以存储的代码段的返回值和参数描述.
        一旦指定.这个block变量中就只能存储这样的代码段了. 其他格式的代码段无法存储.

    2.5 初始化block变量
        1) 原理: 写1个符合block要求的代码段.存储到block变量中就可以了.
        2) 代码段的书写格式:
            ^返回值类型(参数列表){
                 代码段;
            };

        3) 写1个无参数无返回值的代码段.
            ^void(){
                NSLog(@"我爱你");
                NSLog(@"我恨你");
            };

            这个时候,我们就可以将这段代码使用赋值符号存储到 无返回值无参数要求的block变量中.
            void (^myBlock1)();
            myBlock1 =  ^void(){
                NSLog(@"我爱你");
                NSLog(@"我恨你");
            };
 
            当然也可以在声明block变量的同时使用符合要求的代码段初始化.
            void (^myBlock1)() =  ^void(){
                NSLog(@"我爱你");
                NSLog(@"我恨你");
            };

        4) 有返回值的代码段.
            ^int(){
                int num1 = 10 + 20;
                return num1;
            };

            我们就可以将这段代码赋值给符合要求的block变量.
            int (^myBlock2)() =  ^int(){
                int num1 = 10 + 20;
                return num1;
            };

        5) 既有参数既有返回值的代码段.
            ^int(int num1,int num2){
                int num3= num1 + num2;
                return num3;
            };

            所以 我们可以将这个代码赋值给符合要求的block变量.
            int (^myBlock3)(int num1,int num2) =  ^int(int num1,int num2){
                int num3= num1 + num2;
                return num3;
            };
 
        6) 注意: 赋值给block变量的代码段必须要符合block变量的要求. 否则就会报错.
        
     2.6 如何执行存储在block变量中的代码段.
        语法格式: block变量名();   有参数就传参数.有返回值就接. 如:
            myBlock1();
     
            int sum =  myBlock2();
            NSLog(@"sum = %d",sum);
     
            int res = myBlock3(10,100);
            NSLog(@"res = %d",res);

    2.7 关于block的简写(不建议这样写,可读性不好)
        1)  如果我们写的代码段没有返回值.那么代码段的void可以省略.
            void (^myBlock1)() =  ^(){
                NSLog(@"我爱你");
                NSLog(@"我恨你");
            };
        注意,我说的是代码段的返回值如果是void可以省略,声明block变量的返回值无论是什么不可以省略.

        2)  如果我们写的代码段没有参数,那么代码段的小括弧写可以省略.
            int (^myBlock2)() =  ^int{
                int num1 = 10 + 20;
                return num1;
            };

        所以,当1个代码段既没有参数,也没有返回值的适合,就只写^
            void (^myBlock1)() =  ^{
                NSLog(@"我爱你");
                NSLog(@"我恨你");
            };

        3) 声明block变量的时候.如果有指定参数.可以只写参数的类型而不写参数的名称;
            int (^myBlock3)(int,int) =  ^int(int num1,int num2){
                int num3= num1 + num2;
                return num3;
            };

        4) 无论代码段是否有返回值.在写代码的时候.可以不写返回值类型 省略.
            如果在写代码段的时候,省略了返回值,这个时候系统会自动的确定返回值的类型.
            如果代码段中没有返回任何数据 那么它会认为这个代码段是没有返回值的.
            如果代码中有返回数据 返回的数据是什么类型 它就会认为这个代码段是什么类型的.

        建议: 仍然按照我们最标准的写法来写block变量和block代码段.因为这样可以提高代码的阅读性.
 
    2.8. 简化block变量的复杂定义.
        1) typedef的使用场景: 将1个长类型定义为1个短类型.
             传通用法:unsigned long long int num = 10; 问题: 类型太长
             用自定义类型可以解决: tyedey unsigned long long int ulli; ulli num = 10;
        2) 我们也可以使用typedef将长的block类型, 定义为1个短类型.
            typedef 返回值类型 (^新类型)(参数列表);
            typedef void (^NewType)(); 代表重新定义了1个类型叫做NewType, 是1个block类型 无参数无返回值的block类型
 
 
    2.9. 关于block块访问外部变量的问题.
        1). 在block代码块的内部可以取定义在外部的变量的值, 定义在外部的局部变量和全局变量.
        2). 在block代码块的内部可以修改全局变量的值.但是不能修改定义在外部的局部变量的值.
        3). 如果你希望我们定义的局部变量可以允许在block代码的内部去修改,那么就为这个局部变量加1个__block的修饰符.
                          __block int num2 = 200;//局部变量.

    2.10 总结
        1.  block是1个数据类型.
        2.  block变量是来存储1段代码的.
        3.  block变量的声明.
        4.  block变量的初始化
        5.  执行存储在block变量中的代码.
        6.  关于4个简写.
        7.  使用typedef将复杂的block定义简化.
        8.  访问外部变量的问题.
 
 
 3. Block 使用
     3.1 block是1个数据类型.能不能不能作为函数的参数呢? 当然是可以的.
     3.2 如何为函数定义block类型的参数?
         a. 就是在小括弧中声明1个指定格式的block变量就可以了.
         b. 可以使用typedef简化定义,这样看起来就不会晕了.
     
     3.3 如何调用带block参数的函数?
         a. 如果要调用的函数的参数是block类型的,那么要求在调用的时候传入1个和形参block要求的代码段.
         b. 调用的时候,可以先讲代码段存储到1个block变量中,然后再传递这个block变量
         也可以直接将符合要求的代码段写在小括弧中传递.
         c. 小技巧. 通过Xcode提示可以快速的生产block代码段的框架.
     
     3.4 作用: 将block作为函数的参数可以将调用者自己写的1段代码, 传递到函数的内部去执行.
     
     3.5 block也可以作为函数的返回值.
         当将block作为函数的返回值的时候,返回值的类型就必须要使用typedef定义的短类型.
 
     3.6 block与函数
         相同点: 都是封装1段代码.
         不同点:
             1). block是1个数据类型. 函数是1个函数.
             2). 我们可以声明block类型的变量  函数就只是函数.
             3). block可以作为函数的参数. 而函数不能直接作为函数的参数.
     
      3.7 什么时候block可以作为方法、函数的参数?(见案例:国家排序})
         当方法的内部需要执行1个功能.但是这个功能具体的实现函数的内部不确定.
         那么这个时候,就使用block让调用者将这功能的具体实现传递进来.
 
 
4.  协议 protocol
    4.1 作用:  类似于接口
         1). 专门用来声明一大堆方法. (不能声明属性,也不能实现方法,只能用来写方法的声明).
         2). 只要某个类遵守了这个协议.就相当于拥有这个协议中的所有的方法声明.而不用自己去定义.

    4.2 协议的声明语法:
            @protocol 协议名称 <NSObject>
            方法的声明;
            @end

        协议的文件名只有一个文件: .h
 
    4.3. 类遵守协议语法:
        协议就是用来写方法声明的,就是用来被类遵守的.
            @interface 类名 : 父类名 <协议名称>
            @end

        如果类不实现协议中的方法,其实也不会报错.编译器只是会报警告.
        但是当创建对象,来调用这个没有实现的协议中的方法的时候,就会报错.
 
    4.4 类是单继承. 但是协议可以多遵守.
        1个类只能有1个父类              : 表示继承.
        1个类可以同时遵守多个个协议.     <> 表示遵守的协议.
            @interface 类名 : 父类名  <协议名称1,协议名称2......>
            @end
 
    4.5 @required 与 @optional
        声明被@required 修饰,那么遵守这个协议的类必须要实现这个方法, 编译器会发出警告.
        声明被@optional 修饰,那么遵守这个协议的类如果不实现这个方法, 编译器不会报警告.

        无论是@required还是@optional你都可以不实现. 编译器是不会报错的. 仍然可以编译运行.
        默认: @required
        区别: 当遵守协议的类不实现协议中的方法的时候,@required会给1个警告. @optional警告都木有
        作用: 告诉遵守协议的类 哪些方法是必须要实现的,
 
    4.6 协议可以从另外1个协议继承,并且可以多继承.
        协议之间继承的语法:
            @protocol A协议名称 <B协议名称>
            @end
            代表A协议继承自B协议, A协议中既有自己的方法声明,也有B协议中的方法声明.

        NSOBject: 是基类,也是1个协议. 这个协议被NSObject类遵守.
        所有的OC对象都拥有这个协议中的所有的方法. 这个协议我们也叫做[基协议].

        写协议的规范: 任何1个协议,必须要间接的或者直接的去遵守这个NSObject基协议.
        协议的名称: 可以和类的名称相同:
 
 
5. 协议的类型限制
    5.1 请声明1个指针.这个指针可以指向任意的对象,但是要求指向的对象要遵守指定的协议.
        要求声明1个指针指向1个遵守了学习协议的对象, 否则就会报1个警告.
        NSObject<协议名称> *指针名;
        NSObject<StudyProtocol> *stu = [Student new];
        [stu study];

        当然了完全也可以使用id指针.
        id<协议名称> 指针名;
        id<StudyProtocol> id1 =  [Student new];
        [id1 study];

    5.2 声明1个指针变量,要求这个指针变量指向的对象必须遵守多个协议.
        NSObject<StudyProtocol, SBProtocol> *obj1 = [Student new];  //student 要先声明遵守这2个协议
        id<StudyProtocol, SBProtocol> obj1 = [Student new];

    5.3 我要调用这个对象中的协议方法. 只有类遵守了协议,这个类中一定才会有协议方法.

 

6. 代理模式. 案例: 男孩找女朋友
    6.1 代理模式: 传入的对象,代替当前类完成了某个功能
    6.2 利用协议实现代理模式的主要思路.
        1) 定义1个协议. 里面声明代理类需要实现的方法列表. 比如这里的1个代理类需要实现wash cook方法.
        2) 创建1个代理类(比如猪猪) 遵守上面的代理协议 并实现方法
        3) 在需要代理的类中,定义1个对象属性 类型为id 且遵守代理协议的属性.
        4) 在代理的类中,调用代理对象的方法.

    6.3 代理模式:
        有1个对象中有1个属性, 这个属性的可以是任意的对象,但是这个对象必须具有指定的行为. 这时就可以使用协议.
        将行为定义在代理之中.
        对象的属性的类型 id<协议>
        只要遵守了这个协议的对象都可以作为这个类的代理.

    6.4 代理设计模式的场合
        1) 当对象A发生了一些事情,想告知对象B 让对象B称为对象A的代理.
        2) 对象B想监听对象A的一些行为. 让B称为A的代理,
        3) 当对象A无法处理某些场景的时候,想让对象B帮忙处理.
 
 */

#import <Foundation/Foundation.h>
#import "SArray.h"
//block 作为参数 --3.3
typedef void(^NewType)();

void test(NewType block1){
    NSLog(@"-------");
    block1();
    NSLog(@"-------");
}


//block 作为返回值  --3.5
typedef void (^NewType1)();
NewType1 ttt()
{
    void (^block1)() = ^ {
        NSLog(@"~~~~~~");
    };
    return block1;
}



#import "Boy.h"
#import "Girl.h"

int main(int argc, const char * argv[]) {
    
    
   //简化block变量的复杂定义----不带参数
   typedef void (^NewType)(); //1. 声明
    
   NewType block1 = ^{        //2. 初始化, 代表重新定义了1个类型叫做NewType
       NSLog(@"呵呵");
   };
   block1();                  //3. 调用

   //简化block变量的复杂定义----带参数
   typedef int (^NewType2)(int num1,int num2);
    
   NewType2 t1 = ^int(int num1,int num2){

       int num3 = num1 + num2;
       return num3;
   };
   int sum = t1(10,20);      //调用
   NSLog(@"sum:%d", sum);
    
    
    //block 作为参数,调用 --3.3
   NewType type = ^{
       NSLog(@"this is block1");
   };
   
   //1. 一般调用
   test(type);//此此会打印三行:---- this is block1 ----
   
   //2. 可以直接传值
   test(^{
       NSLog(@"this is block2");
   });
   
    
    //返回值调用--3.5
   NewType1 type =  ttt();
   type();
    
    
   //案例:排序--传递方式, block 方式
   char *countries[] =
   {
       "Nepal",
       "Cambodia",
       "Afghanistan",
       "China",
       "Singapore",
       "Bangladesh",
       "India",
       "Maldives",
       "South Korea",
       "Bhutan",
       "Japan",
       "Sikkim",
       "Sri Lanka",
       "Burma",
       "North Korea",
       "Laos",
       "Malaysia",
       "Indonesia",
       "Turkey",
       "Mongolia",
       "Pakistan",
       "Philippines",
       "Vietnam",
       "Palestine"
   };
   
   
   SArray *arr = [SArray new];
   //传统方式实现排序
   //[arr sortWithCountries:countries andLength:sizeof(countries)/8];
   
   //以block 自定义实现
   [arr sortWithCountries:countries andLength:sizeof(countries)/8 andCompareBlock:^BOOL(char *country1, char *country2) {
   
       int res1 = (int)strlen(country1) - (int)strlen(country2);   //按字母长度排序
       int res2 = strcmp(country1, country2);                      //按首字母排序
       
       if(res2 > 0){
           return YES;
       }
       return NO;
   }];
   
   //输出已排序好的数组,数组是按地址传递的
   for(int i=0; i<sizeof(countries)/8; i++){
       NSLog(@"%s", countries[i]);
   }
   
    
    
    /*
     男孩子找女朋友 案例:
     
     要求:必须
         1). 会洗衣服
         2). 会做饭
     优先: 如果有份过万的月薪的工作.
     
     男孩子类:
         属性:姓名,年龄,钱,女朋友.
         行为:谈恋爱.
     
     定义1个协议;女朋友协议.
     洗衣
     做饭
     
     扩展:当然自己也可以实现wash, cook 方法,自己也可以做自己的女朋友
     */
    
    Boy *jack = [Boy new];
    jack.name = @"jack";
    jack.age = 20;
    jack.money = 120000;
    
    
    Girl *rose = [Girl new];
    rose.name = @"rose";
    
    jack.girlFriend = rose;      //Girl 属性实现wash, cook方法
    [jack talkLove];
    
    
    
    return 0;
}
