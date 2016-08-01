
/*
 OC 相对于C 
      a) 在C的基础上新增了1小部面对象的语法
      b) 将C 复杂的,繁琐的语法封装的更为简单
      c) OC完全兼容C语言
 
 CO 与C 源文件:
     OC 文件:源文件为.m  m代表message 代表OC中最重要的1个机制,消息机制
      C 文件:源文件为.c
 
 
 main 函数仍然是OC程序的入口和出口
      int 类型是返回值,代表程序结束的状态
      main 函数的参数:仍然可以接收用户在运行程序的时候传递数据给程序,参数也可以不要
 
 
 #import 指令
       a) 以# 号开头的是1个预处理指令
       b) 作用: 是#include 的增强版,将文件的内容在预编译的时候拷贝到写指令的地方
       c) 增加: 同1个文件无论#import 多次,只会包含1次
 
 框架: 是1个功能集,有点像C 语言的函数库. 如:Foundation 框架,包含了Foundation 下的所有框架
 
 
 OC 程序的编译,连接,执行
       a) 在源文件.m 中写上符合OC语法规范的源代码
       b) 使用编译器将源文件编译为目标文件: cc -c test.m  过程:预处理-->检查语法-->编译
       c) 链接 cc test.o  如果程序中使用到了框架中的函数或类,那么在链接的时候就必须要告诉编译器去哪1个框架中找这个函数或类
               如: cc test.o -framework 框架名
                  cc text.o -framework Foundation
       d)链接成功以后,就会生成1个a.out 可执行文件,执行就可以了
    相对与XCode 点击运行,所有的事情XCode 就帮了们自动的做了
 
 OC 与 C程序各个阶段后缀后对比
          源文件      目标文件      可执行文件
    C     .c           .o          .out
   OC     .m           .o          .out


----------------数据类型----------------------------------------
 OC 中支持C语言中的所有数据类型
    1. 基本数据类型: int, double, float, char
    2. 构造类型   : 数组, 结构体, 枚举
    3. 指针类型   : int *p1
    4. 空类型    : void
    5. typedef 自定义类型: typedef int money
 
 
 OC 类型
    1. BOOL 类型: 可以存储YES 或 NO 的任意1个数据, 一般表成立或不成立
            本质:typedef signed char BOOL; 是1个有符号的char 变量
                 #define YES ((BOOL)1)  YES 实际上就是1
                 #define NO((BOOL)0)     NO 实际上就是0
 
    2. Boolean 类型: 其变量可以存储true 或 flase
               本质:typedef unsigned char
                #define true 1
                #define flase 0
  
    3. class 类
    4. id 类型,万能指针
    5. nil 与 NULL 差不多
    6. SEL 文法选择器
    7. block 代码段
 
 --------------------------------------------------------
 1. NSString 类型的指针变量,专门用来存储OC字符串的地址
        OC的字符串常量前要有:@符号
            C语言的字符串: "Tom"
            OC的字符串  : @"Tom"
        完整表示: NSString *name = @"Tom";
 
 2. @autoreleasepool: 是自动释放池, 可用用,也可以不用
 
 3. SNLog 函数是printf 函数的增强版,向控制台输出信息,会自动换行
          语法: NSLog(@"字符串", 变量列表)
 
 
-----------------类-----------------------------------------
     作用:描述1群有相同特征和行为的事物
     设计类的三要素:类名,特征,行为
     问题:是先有类,还是对象
         从现实的角度:一定是先有对象再有类
         从代码的角度:一定是先有类再有对象
     
 
     位置:直接写在源文件之中,不要写在main 函数中
     定义:有两部分,一是声明,二是实现
     注意:
         1. 类必须有声明与实现
         2. 类名首字母大写, 加上NSObject
         3. 为类定义属性的时候, 属性的名词必须要以_开头

    使用对象:默认情况下类的属性是不允许外部直接访问的, 要访问加:@public
    访问对象属性的方式:
         对象名->属性名 = 值;    //赋值
         对象名->属性名;         //取值
 
 
    带我多个参数写法:
           1. [对象名 方法名:实参1 :实参2 :实参3]
           2. 方法名With:(实参类型1)参数名1 and:(参数类型2)参数名2     注:and 可以写任意.如:to toNum
 
    带参数的声明规范: 方法名可以命名: xxxWith:实参
         xxxWithxxx 如: eatWith:   eatWithFood:

 */
#import <Foundation/Foundation.h>

//声明
@interface Person : NSObject
{
//属性的声明
    @public
    NSString *_name;
    int _age;
    float _height;
    
}

- (void) run;                        //文法的声明1--无参数
- (void) eat:(NSString *)foodName;   //文法的声明2--1参数
- (int) sum:(int)num1 :(int)num2;    //文法的声明3--2参数
- (int) avgWithNum:(int)num1 and:(int)num2;  //方法的声明3--2参数--推荐写法
- (void) getMassge;                 //方法的声明--获取属性
@end



//类的实现
@implementation Person
//方法的实现1--无参数
- (void) run{
    NSLog(@"我可以run...无参数调用");
}

//方法的实现2--1个参数
-(void) eat:(NSString *)foodName{
    NSLog(@"可以吃的食物是%@", foodName);
}

//方法的实现3--2个参数
- (int) sum:(int)num1 :(int)num2{
    return num1 + num2;
}

//方法的实现3--2参数--推荐写法
//- (int) avgWith:(int)num1 and:(int)num2{
- (int) avgWithNum:(int)num1 and:(int)num2{
    return (num1 + num2)/2;
}


//获取属性的实现---当前调用者信息
- (void) getMassge{
    NSLog(@"person 的姓名:%@ 年龄:%d 身高:%.2f",
        _name, _age, _height);
}
@end



int main(int argc, const char * argv[]) {
    
   NSLog(@"hello OC");
    //2016-07-17 15:00:17.315 01 oc 语法基础[582:16086] hello OC
    //时间---------------------程序名-----进程编号:线程编号--输出信息
    
    
    Person *person = [Person new];
    
    //类的属性-赋值1
    person->_name   = @"Tom";
    person->_age    = 20;
    person->_height = 180.2f;
    
    //类的属性-赋值2
   (*person)._name   = @"Tom2";
   (*person)._age    = 21;
   (*person)._height = 181.2f;
   NSLog(@"person 的姓名:%@ 年龄:%d 身高:%.2f",
         person->_name, person->_age, person->_height);
    
    //类的方法调用：
    [person run];                   //类的方法调用1--无参数  输出:我可以run...无参数调用
    [person eat:@"apple"];          //类的方法调用2--1个参数 输出:可以吃的食物是apple
    int sum = [person sum:2 :3];    //类的方法调用3--2个参数 输出:5
    NSLog(@"两个数的和为:%d", sum);
    
    int avg = [person avgWithNum:5 and:9];   //推荐写法  输出:7
    NSLog(@"两个数的平均值为%d", avg);
   
    //获取信息
    [person getMassge];      //person 的姓名:Tom 年龄:20 身高:180.20
    
 
    return 0;
}
