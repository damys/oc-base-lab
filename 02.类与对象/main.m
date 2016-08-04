/*
内存管理:内存5大区域
    1. 栈区域： 存储局部变量  如：int num=10, int* p=&num。 num 与 p 都存储在栈区域
    2. 堆区域： 允许程序员手动的从堆申请空间来使用，要主动释放。除非程序结束  如：int 4, float 4.... malloc,calloc ...
    3. BSS段区域：   存储未初始化的全局变量/静态变量，因程序运行时其全局/静态变量都没有初始化
    4. 数据段/常量区：存储已初始化的全局变量/静态变量，与常量数据， 在main 外定义的变量
    5. 代码段区域：   存储程序代码/指令
 
 
类加载:
    1. 在创建的时候是需要访问
    2. 声明1个类的指针变量也会访问类的
    注:在程序运行期间,当某个类第1次被访问到的时候,会将这个类存储到内存的代码段区域,这个过程叫类加载
    只有类在第1次被访问的时候,才会做类加载,一旦类被加载到代码段区域,只到程序结束此类才能被释放
        Person *p1 = [Person new];   //会做类加载
        Person *p2 = [Person new];   //不会做类加载

调用:
    注意:内存中的对象只有属性,而没有方法,自己类的属性外加一个isa指针指向代码段的类
    调用属性: p1->_name;    //指针名->属性名
    调用方法: [指针名 方法名] //先根据指针名找到对象,对象发现要调用方法,再根据对象的isa指针找到类,然后调用类里的方法
                  本地地址   指向地址
      栈    :*p1  0x1111    0x2222
      堆    :isa  0x2222    0x3333
      代码段: 类   0x3333    0x9999

    为什么不把方法放在属性之中: 类对象的属性是不一样,而调用的方法都是一样,只保存1份.节省空间:放在代码段中
 
    对象的属性的默认值:创建一个对象如没有赋值,默认是有值的,如果基本类型:0,C指针:NULL, OC:nil
        int _age        //0
        int *_p1        //null   NULL 代表不指向任何空间,是一个宏 就是:0
        NSString *name; //nil    nil  代表不指赂任意对象,只能作为指针变量的值. 也是一个宏. 就是:0
        注意:nil, NULL 不建议相互随意用
    如果1个对象赋值为nil. 调用属性会报错,调用方法没有任何反映
    同类型的类指针是可以相互赋值的,值为对象的地址

 
函数与方法:
     函数不能定义在函数内部,可以写在类的方法声明与方法实现中:void test(){...}, 但test 并不属于此类. 不推荐
     调用:函数可以直接在main中调用  void test(); 方法只能通过对象再调用.  不推荐
 
 
 注意:
     1. 类的实现可以在使用类的后面,但类的声明一定在使用类的前面
     2. 类的声明与实现要同时存在. 特殊情况除外(不推荐)
     3. 类的属性不允许声明时初始化
     4. 方法有声明,就要实现
        a) 如果方法只有声明,没有实现,编译会给1个警告,不会报错
        b) 如果指针指向的对象,有方法的声明,而没有实现,那么这个时候通过指针来调用这个方法,在运行时就会报错

-----类,对象----------------------------------------------

数据类型: 是在内存中开辟空间的1个模板. char 1, int 4
类的数据类型由程序指定,定义属性,方法多时,就占的大一些

对象作为参数传递:是地址传递,所有在方法内部通过形参去修改形参指向的对象时,会影响实参变量指向的对象的值
    1. 声明与实现: - (void) call:(Dog *) dog;
    2. 调用
        Dog *dog = [Dog new];
        Cat *cat = [Cat new];
        [cat call:dog];       //Cat 也会叫

对象作为方法的返回值
    返回值为1个对象,那么返回值的类型应该是 类指针: -(Dog *) say;  此方法可能带参数
    方法的内部创建一个对象, return cat;

如何表示人有1条狗: 就是把狗作为人的属性. Dog *_dog; 此属性为一个指针,值为nil, 
                调用初始化时:创建一个*dog dog->_name="01"; 
                调用属性:[person->_dog = dog]   //1个类的对象要是一个对象,加多一个箭头指向
                调用方法:[person->_dog say]


对象与方法的返回值
        1. 类就是一个自定义的类型. 当类作为方法的参数时,在方法执行的时候,参数只是1个指针而已,没有创建对象,
            为参数值值以后,形参指针和实参指针指向了同1个对象
        2. 对象做为方法的返回值:方法的作用是就是创建1个对象,把这个对象的地址返回给调用者
 
 */
#import <Foundation/Foundation.h>
@interface Person : NSObject
{
    @public
    NSString *_name;
    int _age;
}
- (void) show;
@end

@implementation Person

- (void) show{
    NSLog(@"name:%@ age:%d", _name, _age);
}

@end


/*
分组导航标记,   语法:
      #pragma mark 猫类的实现
      #pragma mark -            只有分割线
      #pragma mark - 猫类的实现   分割线与描述
*/
#pragma mark Test类的声明
@interface Test : NSObject
@end

#pragma mark - Test类的实现
@implementation Test
@end


/*
多文件开发
    把类写在一个模块里,包括类的声明与实现:(.h 声明文件), (.m 实现文件)
    1. Dog.h  #import <Foundation/Foundation.h>   //引入头文件
    2. Dog.m  #import "Dog.h"
    3. main中调用: 先引入 #import "Dog.h" .再调用
 
    可以一步操作上面1,2项: 直接创建 Cocoa class
 
 */
#import "Dog.h"
#import "Cat.h"


int main(int argc, const char * argv[]) {
    
   if(nil == NULL){
       NSLog(@"nil === NULL");
   }
    
   Person *p1 = [Person new];
   
   p1->_name = @"Tom";
   p1->_age = 20;
   
   Person *p2 = p1;
   p2->_name = @"Jack";
   
   [p1 show];    //name:Jack age:20
   [p2 show];    //name:Jack age:20
    
    
    //多人的开发-调用
   Dog *dog = [Dog new];
   [dog say];
    
    //对象作为参数传递
    Dog *dog = [Dog new];
    Cat *cat = [Cat new];
    [cat call:dog];       //Cat 也会叫
    
    
    return 0;
}
