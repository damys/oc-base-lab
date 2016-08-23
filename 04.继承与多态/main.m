/*
 
 1. 框架的中有那些类,如何调用这些类 如:NSString *str = @"jack"; [str length]
 
 2. XCode 文档需要单独安装:
          在线安装. 离线安装/Applications/Xcode.app/Contents/Developer/Documentation/DocSets
 
 3. static 关键字
     C 语言可以修饰局部变量,变为静态变量,可以修饰常量,方法
     OC 语言中不能修饰属性,方法, 可以修改方法中的局部变量,就变成为静态变量,存储在常量区 
 
     如果当前方法返回值是当前类的对象,就是:instancetype 类型
 
 4. self 关键字
       1. 在方法内部可以定义一个与属性相同的局部变量, 调用这个方法时访问的是局部变量,用self->_name 访问类的属性
       2. 在一个对象方法当中要调用另外一个对象中的方法,不能用new 创建对象来调用,要用self
       3. self 是一个指针,在对象方法吕指向当前对象,在类方法中指向当前类
 
    使用场景:
       1. 调用当前属性/方法: self->_name, [self say]
       2. 在对象方法中,如果要调用当前对象的其他的对象方法,必须使用self
       选用:在方法中不存在和属性相同名的局部变量,访问的是当前对象的属性
       局部变量不要用下划线,对象的属性要用下划线
 
    查看类在代码段中的地址方式:
       1. 调试查看对象isa 指针的值
       2. 在类方法中查看self 的值  用%p
       3. 调用对象方法/类方法的class方法 : [p1 class] /  [Person class]
 
    建议:可以在类方法中使用self 来显示的调用本类的其他类方法
    
    注意:  对象方法 - 与类方法 + 可以重名
        1. 在对象方法中,self 代表当前对象, 不能使用self 来调用类方法 Person *p1 = [Person new] p1 = self
        2. 在类方法中,self 代表当前这个类, 不能访问对象成员,属性, Person = self
 

 5. 继承:不用自己去定义,继承只是类在继承,子类拥有所有父类的所有成员,属性. XCode 创建时可以选择父类
       语法: @interface 类名: 父亲的名称
             子类:继承类,派生类. 
             NSObject 是所有类的父类, 只有此类有new 方法,还有属性isa 指针
 
       使用场景:
            1. 发现一个类的成员,我与要使用, 不要为继承而继承
            2. 满足is a (所有)关系的类, 注意伦理关系
            3. 父亲只定义所有子类拥有的成员,属性
 
       特点: 
           1. 单根性,一个类只能为一个父类
           2. 传递性,A类从B类继承,B类从C类继承,那个A类就拥有B,C类所有的成员,属性
 
 
 6. 父类与子类同名属性
       子类不能存在与父类同名的方法,属性
 
    super 关键字: 
           1. 可以用在类方法,对象方法中, 同self, 继承用super 的可读性要好
           2. 在对象方法中可以使用 super关键字调用当前对象从父类继承过来的对象方法.[self say] = [super say]
           3. 在类方法中 super关键字可以调用当前类从父类继承过来的类方法
               a. 类方法也能被子类继承. 父类中的类方法可以使用父类名来调用 也可以使用子类名调用.
               b. 在子类的类方法中 可以使用super 只能调用父类的类方法. 不能访问属性
               综合a, b [Pseron say] = [Studen say] = [self say] = [supder say]
 
 
 7. 访问修饰符: 用来修饰属性的(不能修改方法). 可以限定对象在一定范围内访问
       @private   私有     只能在本类方法实现中访问
       @protected 受保护的  只能在本类方法,子类方法实现中访问
       @package   框架     被修饰的属性,可以有当前框架中访问
       @public    公共的   只要创建对象,可以在任意的地方访问
       不写默认: @protected
      
     注意: 子类仍然可以继承父类的私有属性,只不过,在子类中无法直接访问从父类继承过来的私有属性,
           如果父类中有一个方法为属性赋值或取值,那么子类可以调用这个方法间接的访问父类的私有属性.
 
     访问修饰符的作用域:直接遇到另一个访问修饰符或结束大括弧为止,都是最近的修饰符. 如:
          @private
            NSString *_name;
          @public
            int _age;
            int weight;       //也是@public
     使用建议:
       1. @public  无论什么时候都不要使用,属性不要直接暴露给外界
       2. 推荐使用默认的, @protected
 
    -私有属性: 将属性写在方法实现中 与 在声明中标记为@private 属性 是等同的,里面的属性就变为私有.
                   不同的是: 各种访问修饰符无效,外界XCode 也不会提示
    -私有方法: 默认只有创建其对象,就可以访问其方法. 私有(只能在本类的其它方法中调用): 只有实现,无声明
 
 
 8. 里氏替换原则(LSP): 子类可以替换父类的位置,并且程序的功能不受影响
             父类要一个父类对象,可以给一个子类对象.  如:[Person *stu = Studen new];
        原则: 当一个父类指针指向一个子类对象的时候,这里就有里氏替换原则.
 
    LSP 作用: 
             1. 一个指针可以存储本类对象的地址,还可能存储子类对象的地址
             2. 如果一个指针的类型是NSObject 类型,那么这个指针可以存储任意的OC 对象的地址
             3. 如果一个数组的元素类型是一个OC 指针类型,这个数组可以存储本类对象,子类对象
                    Person *ps[3];
                    ps[0] = [Person new];
                    ps[1] = [Studen new];
                    ps[2] = [MidStu new];
             4. 如果一个数组的元素是NSObject 指针类型,这个数组可以存储任意OC 对象
                    NSObject *obj[2];
                    obj[0] = [Studen new];
                    obj[1] = @"Tom";
             5. 如果一个方法的参数是一个对象, 为参数传值的时候,可以传递一个本类对象,子类对象
 
     注意:当一个父类指针指向一个子类对象时,通过这个父类指针就只能去调用子类中的父类成员,
         (本身)子类独有的成员无法访问.----指针指向的问题
 
 
 9. 方法重写
       场景: 子类拥有父类的行为,但这个行为具体实现和父类不一样.
       使用: 子类就按自己的方式重写就行了,直接在子类的实现中实现,方法名是一样的
 
    当一个父类指针指向一个子类对象时,通过父类指针调用的方法,如果在子类中重写,调用就是子类重写的方法(LSP 不同)
 
 
 10. 多态: 
        指是同一个行为,具备多种形态(对于不同的事物具有完全不同的表现形式).
 
 11. description
        NSLog 在打印字符时, 会先调用description 方法, 这个方法的返回值是一个字符串, 后输出这个字符串
        descrption 的定义是在NSObject 类之中的,所有每个OC对象都有此方法 如:[p1 description]
    什么时候重写:如果你希望%@打印一个对象的时候,你希望这个对象打印的个数是我们自己定义的,就可以重写此方法
 */

 
#import <Foundation/Foundation.h>
#import "Killer.h"
#import "Man.h"
#import "FireMan.h"
#import "SuperMan.h"

int main(int argc, const char * argv[]) {
    
   NSString *name = @"dddd";
   [name length];
    
    /*
     (多态)杀人游戏: 可以杀所有Person 继承的人
              方法: 可以杀各种各样的人
              分析: 每一个人都会叫, 有男人, 火星人, 超人

     */
    
   Killer *bill = [Killer new];
   
   //kill Man
   Man *man = [Man new];
   [bill killWith:man];
   
   //kill FireMan
   FireMan *fireMan = [FireMan new];
   [bill killWith:fireMan];
   
   //kill SuperMan
   SuperMan *superMan = [SuperMan new];
   [bill killWith:superMan];
    
    
    
    //description
    Person *p1 = [Person new];
    NSLog(@"%p", p1);               //指针变量的值: 0x100107450
    NSLog(@"%@", p1);               //<Person: 0x100107450>
    NSLog(@"%@", [p1 description]); //<Person: 0x100107450>
    
    //如果不想它上面格式输出,就要重写NSObject 的description 方法---实例在Person 中重写了此方法
    [p1 setName:@"Tom"];
    NSLog(@"%@", p1);              //姓名:Tom

    
    
    
    return 0;
}
