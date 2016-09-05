/*
 
1. 自动释放池.
    1.1 原理: 存入到自动释放池中的对象,在自动释放池被销毁的时候.会自动调用存储在该自动释放池中的所有对象的release方法.
       解决的问题: 将创建的对象,存入到自动释放池之中. 就不再需要手动的release这个对象了.
                因为池子销毁的时候 就会自动的调用池中所有的对象的release。
       1) 自动释放池: MRC下才具备作用.
       2) 如何创建1个自动释放池: @autoreleasepool{}
       3) 调用对象的autorelease方法的代码放在自动释放池.
       4) 好处: 在MRC下.创建对象把对象存储到自动释放池中 省略1个release.
 
 
    1.2 调用对象的autorelease方法.就会将这个对象存入到当前自动释放池之中. 返回对象本身
        @autoreleasepool{  Person *p1 = [[Person new] autorelease];  }   调用默认的不带参数构造方法.
        @autoreleasepool{  Person *p1 = [[[Person alloc] init] autorelease];  } 同上.调用自定义的构造方法
        当这个自动释放池执行完毕之后,就会立即为这个自动释放池中的对象发送1条release消息. 如果是0, 就销毁

    1.3 autoreleasepool 好处:
        1) 创建对象,调用对象的autorelase方法 将这个对象存入到当前的自动释放池之中.
        2) 我们就不需要再去relase 因为自动释放池销毁的时候 就会自动的调用池中所有对象的relase
 
    1.4 使用注意
        1) 只有在自动释放池中调用了对象的autorelease方法后,这个对象才会被存储到这个自动释放池之中.
        2) 对象的创建可以在自动释放池的外面,在自动释放池之中,调用对象的[p1 autorelease]方法,就可以将这个对象存储到这个自动释放池之中.

        3) 当自动释放池结束的时候.仅仅是对存储在自动释放池中的对象发送1条release消息 而不是销毁对象.如果是0, 就销毁
        4) 如果在自动释放池中,调用同1个对象的autorelease方法多次.就会将对象存储多次到自动释放池之中.
            在自动释放池结束的时候.会为对象发送多条release消息.那么这个是就会出现僵尸对象错误.

        5) 如果在自动释放池中,调用了存储到自动释放中的对象的release方法.
            在自动释放池结束的时候,还会再调用对象的release方法.有可能会造成野指针操作.
            也可以调用存储在自动释放池中的对象的retain方法.

        6). 将对象存储到自动释放池,并不会使对象的引用计数器+1
            好处: 创建对象将对象存储在自动释放池,就不需要在写个release了. 意思:省掉对象后面匹配的[对象 release]方法

        7). 自动释放池可以嵌套.
            调用对象的autorelease方法,会讲对象加入到当前自动释放池之中
            只有在当前自动释放池结束的时候才会像对象发送release消息.
 
  1.5 autorelease的规范.
        1) 创建对象,将对象存储到自动释放池之中. 就不需要再去手动的realse。
        2) 类方法的第1个规范: 一般情况下,要求提供与自定义构造方法相同功能的类方法.这样可以快速的创建1个对象.
        3) 一般情况下,写1个类. 会为我们的类写1个同名的类方法,用来让外界调用类方法来快速的得到1个对象.
          规范: 使用类方法创建的对象,要求这个对象在方法中就已经被autorelease过了.
          这样,我们只要在自动释放池中, 调用类方法来创建对象, 那么创建的对象就会被自动的加入到自动释放中.

        提供1个类方法来快速的得到1个对象. 规范:
            a. 这个类方法以类名开头. 如果没有参数就直接是类名 如果有参数就是 类名WithXX:
            b. 使用类方法得到的对象,要求这个对象就已经被autorelease过了.
            //构造方法
            + (instancetype)person{
                return [[[self alloc] init] autorelease];
            }

            这样,我们直接调用类方法.就可以得到1个已经被autorelease过的对象.
            @autoreleasepool{
                Person *p1 = [Person person];
                //这个p1对象已经被autorelase过了.不需要再调用autorelase
                //这个p1对象就被存储到当前自动释放池之中.
            }   //当自动释放池结束.就会为存储在其中的p1对象发送release消息.

       4). 实际上Apple的框架中的类也是遵守这个规范的.
            通过类方法创建的对象都是已经被autorelease过的了.
            所以,我们也要遵守这个规范. 类方法返回的对象也要被autorealse过.
            以后,我们凡事创建对象是调用类方法创建的对象 这个对象已经是被autorelease过的了.
 

 
 
 
 2. ARC 自动内存管理. 系统自动的计算对象的引用计数器的值.
 编译器特性
 
 没有任何强指针指向1个对象的时候 这个对象就会被立即回收.
 
 
 
 2. ARC
     2.1 什么是ARC: Automatic Reference Counting，自动引用计数. 即ARC.
         顾名思义:系统自动的帮助我们去计算对象的引用计数器的值,
         
         可以说是WWDC2011和iOS5引入的最大的变革和最激动人心的变化.
         ARC是新的LLVM3.0编译器的一项特性,使用ARC,可以说一举解决了广大iOS开着所憎恨的手动管理内存的麻烦.
            
         在程序中使用ARC非常简单,只需要像往常那样编写代码.
         只不过永远不要写:retain、release、autorelease. 永远要手动的调用 dealloc 这三个关键字就好,这是ARC的最基本的原则.
         当ARC开启时, 编译器会自动的在合适的地方插入retain、release、autorelase代码.
         编译器自动为对象做引用计数. 而作为开发者,完全不需要担心编译器会做错(除非开发者自己错用了ARC).
         注意: ARC是编译器机制. 在编译器编译代码的时候,会在适时的位置加入retain、release和autorealse代码.
    
    2.2 ARC机制下,对象何时被释放
         本质: 对象的引用计数器为0的时候,自动释放.
         表象: 只要没有强指针指向这个对象,这个对象就会立即回收.
         
    2.3 强指针与弱指针.
         1) 强指针: 默认情况下,我们声明1个指针 这个指针就是1个强指针.
             我们也可以使用__strong来显示的声明这是1个强指针. 如:
             Person *p1; 这是1个强指针. 指针默认情况下都是1个强指针.
             __strong Person *p2; 这也是1个强指针.使用__strong来显示的声明强指针.
         
         2) 弱指针: 使用__weak标识的指针就叫做弱指针.
             相同: 无论是强指针还是弱指针,都是指针,都可以用来存储地址,这1点没有任何区别, 都可以通过这个指针访问对象的成员.
             唯一的区别: 就是在ARC模式下.他们用来作为回收对象的基准.
         
         如果1个对象没有任何强类型的指针指向这个对象的时候,对象就会被立即自动释放
 
    2.4 确认程序是否开启ARC机制.
         1).默认情况下,Xcode开启ARC机制.
         2).ARC机制下,不允许调用retain、relase、retainCount、autorelease方法.
         3).在dealloc中 不允许[super dealloc];
 
    2.5 演示第1个ARC案例
         int main(int argc, const char * argv[]){
             @autoreleasepool{
                 Person *p1 = [Person new];    //p1是1个强指针.
                        //因为我们说过,每1个指针变量默认情况下都是1个强指针变量.
                 NSLog(@"------");
             }   //当执行到这里的时候.p1指针被回收,那么Person对象就没有任何
                  //强指针指向它了. 对象就在这被回收.
             return 0;
         }
 

 5. 第一个ARC程序
     5.1 ARC下的单个对象的内存管理. 
         在ARC的机制下: 当1个对象没有任何的强指针指向它的时候 这个对象就会被立即回收.
     5.2 当指向对象的所有的强指针被回收的时候,对象就会被立即回收.
         int main(int argc, const char * argv[]){
                 @autoreleasepool{
                    Person *p1 = [Person new];   //p1是1个强指针.
                    Person *p2 = p1;             //p2也是个强指针.p1和p2都指向Person对象.
                    //因为我们说过,每1个指针变量默认情况下都是1个强指针变量.
                    NSLog(@"------");
                 }   //当执行到这里的时候.p1指针被回收,p2指针也被回收.那么Person对象就没有任何
                     //强指针指向它了. 对象就在这被回收.
                 return 0;
         }
         
      5.3 将所有指向对象的强指针赋值为nil的时候.对象就会被立即回收.
         int main(int argc, const char * argv[]){
             @autoreleasepool{
                 Person *p1 = [Person new];   //p1是1个强指针.
                 p1 = nil;//当执行到这句话的时候.p1赋值为nil.
                             //p1指针不再执行Person对象.
                             //Person对象没有被任何的指针所指向,所以.Person对象在这里被释放.
                 NSLog(@"------");
             }
             return 0;
         }
 
      5.4 这两种情况就叫做没有任何强指针指向对象.
         1). 指向对象的所有强指针被回收掉
         2). 指向对象的所有的强指针赋值为nil
 
      5.5 在ARC机制下. 当对象被回收的时候. 原来指向这个对象的弱指针会被自动设置为nil
         
 
 6. ARC机制下的多个对象的内存管理.
    6.1 ARC机制下的对象的回收的标准: 当没有任何强类型的指针指向对象的时候,这个对象就会被立即回收.
    6.2 什么情况下叫做对象没有强指针向指向.
         1).  指向对象的强指针被回收.
         2).  指向对象的强指针被赋值为nil
    6.3 在ARC的机制下,@property参数不能使用retain
         因为retain代表生成的setter方法是MRC的标准的内存管理代码.
         而我们在ARC的机制下 不需要这些代码.
     
     所以,在ARC机制下的setter方法 什么都不需要做.直接赋值就可以了.
 
    6.5 ARC机制下,我们关注的重点.
         当1个类的属性是1个OC对象的时候.这个属性应该声明为强类型的还是弱类型的.应该声明为1个强类型的.
         如何控制@property生成的私有属性,是1个强类型的还是1个弱类型的呢?
         @property(nonatomic, strong)Car *car; 代表生成的私有属性_car 是1个强类型的.
         @property(nonatomic, weak)Car *car;   代表生成的私有属性_car 是1个弱类型的.
         如果不写,默认是strong.
 
    6.6 使用建议.
        1) 在ARC机制下.如果属性的类型是OC对象类型的. 绝大多数场景下使用strong
        2) 在ARC机制下.如果属性的类型不是OC对象类型的. 使用assign
        3) strong和weak都是应用在属性的类型是OC对象的时候. 属性的类型不是OC对象的时候就使用assign.

    6.7 在ARC机制下,将MRC下的retain换位strong
        @property(nonatomic,strong)Car *car;  
        做的事情:
            1) 生成私有属性.并且这个私有属性是strong
            2) 生成getter setter方法的声明
        setter的实现:直接赋值.
 
 
 7. ARC下的循环引用问题.
     在ARC机制下.当两个对象相互引用的时候(如:作者与书:你中有我对象,我中有你的对象).如果两边都使用strong 那么就会先内存泄露.
     解决方案: 1端使用:strong 1端使用:weak   
     book.h  @class Author;  @property(nonatomic,weak)Author *author;
 
 
8. @property参数总结
    8.1 开发程序分为ARC和MRC
    8.2 与多线程相关的参数.
        atomic : 默认值 安全,但是效率低下.
        nonatomic: 不安全,但是效率高.
        无论在ARC还是在MRC都可以使用.
        使用建议: 无论是ARC还是MRC 都使用nonatomic

    8.3 retain:
        只能用在MRC的模式下.代表生成的setter方法是标准的内存管理代码.
        当属性的类型是OC对象的时候.绝大多数情况下使用retain. 只有在出现了循环引用的时候1边retain 1边assign

    8.4 assign:
        在ARC和MRC的模式下都可以使用assign.
        当属性的类型是非OC对象的时候 使用assign.

    8.5 strong:
        只能使用在ARC机制下. 当属性的类型是OC对象类型的时候,绝大多数情况下使用strong]
        只有出现了循环引用的时候, 1端strong 1端weak

    8.6 weak: 
        只能使用在ARC机制下. 当属性的类型是OC对象的时候. 
        只有出现了循环引用的时候, 1端strong 1端weak
    8.7 readonly readwrite 无论是ARC还是MRC 都可以使用.
    8.8 setter getter      无论在ARC下还是在MRC下都可以改.
    8.9 在ARC机制下.原来使用retain的用strong, 出现循环引用的时候.
        MRC: 1边:retain 1边a:ssign
        ARC: 1边strong 1边weak
 
 
 9. ARC与MRC.
     9.1 ARC与MRC兼容:
        1) 有可能会遇到的问题: 程序使用的是ARC机制开发的,但是其中的某些类使用的是MRC.
        2) 项目->build Phasses->complie Sounces 选择项目 右击,输入使用命令.  -fno-objc-arc
 
     9.2 MRC转换为ARC
        可以将整个MRC程序,转换为ARC程序;  操作: 选中项目->菜单edit->conver->选择子项目->object-c ARC
        有时要切换一下:arc 为 NO,再转

 
 10. 分类的基本使用
    10.1 分类: 类别、类目、category, 顾名思义: 将1个类分为多个模块.将功能相似的功能定义在一个模块中
        1. 创建时选择:objectc-file M,(输入分类名,选择类型为:category, 选择本类名). 会生成1个.h 和1个.m的模块.
        2. 会成生模块的文件名: 1). 本类名+分类名.h, 2). 本类名+分类名.m
        3. 可以看出分类也分声明与实现
    
     10.2 添加的分类也分为声明和实现.
        @interface 本类名 (分类名)
        @end
 
        代表不是新创建1个类.而是对已有的类添加1个分类. 小括弧中写上这个分类的名字.
        因为1个类可以添加多个分类 为了区分每1个分类.所以分类要取名字.

    10.3 分类的实现.
        @implementation Student (itcast)
        @end

    10.4 分类的使用. 如果要访问分类中定义的成员,就要把分类的头文件引进来.
    10.5 分类的作用: 将1个类分为多个模块.方便于多个开发
 
    10.6 使用分类注意的几个地方:
        1) 分类只能增加方法,不能增加属性
        2) 在分类之中可以写@property 但是不会自动生成私有属性. 也不会自动生成getter setter的实现.
        只会生成getter setter的声明.
        所以,你就需要自己写getter 和 setter的声明. 也需要自己定义属性 这个属性就必须在本类中.

        3) 在分类的方法实现中不可以直接访问本类的真私有属性(定义在本类的@implementation之中)
        但是可以调用本类的getter setter来访问属性.
        也就是说:
            1. 本类的@property生成的私有属性,只可以在本类的实现中访问.
            2. 分类中不能直接访问私有属性 真.
            3. 分类可以使用 getter setter. 可以通过self 来访问. self.name 或[self setName][self name]
 
        4) 分类中可以存在和本类同名方法的.
        当分类中有和本类中同名的方法的时候,优先调用分类的方法.哪怕没有引入分类的头文件.
        如果多个分类中有相同的方法,优先调用最后编译的分类.

    10.7 什么时候需要使用分类.
        当1个类的方法很多很杂的时候. 当1个类很臃肿的时候.
        那么这个时候我们就可以使用分类. 将这个类分为多个模块.将功能相似的方法写在同1个模块之中.
 
    10.8 继承与分类的区别:
        1) 继承是新一个类, 可以继承扩展作意成员
        2) 分类没有创建一个类,就像本类一样, 只能加方法
 
 11. 非正式协议
    11.1 分类的作用在于可以将我们写类分为多个模块.可以不可以为系统的类写1个分类呢?
        为系统自带的类写分类 这个就叫做非正式协议.

    11.2 利用分类的第2个作用: 为1个已经存在的类添加方法.

    11.3 NSString类都挺好的. 就是差了1个方法.
        统计字符串对象中有多少个阿拉伯数字.  这样每个继承于NSString 都有这个方法
        c语言中一个汉字占3个字节,xcode 中点2个字节, 2 的24=65535 , 实际中国汉字只有2万多个
        @implementation NSString (numCount)
        - (int)numberCount{
            int count=0;
            for (int i=0; i<self.length; i++) {
                unichar ch = [self characterAtIndex:i];
                if(ch >='0' && ch <='9'){
                    count++;
                }
            }
            return count;
        }
        @end
 
        NSString *str = @"aaa111bbb222";
        NSLog(@"count:%d", [str numberCount]);   //6
 
 
12. 扩展: ARC机制垃圾回收机制的区别.
    1). GC: 程序在运行的期间,有1个东西叫做垃圾回收器.不断的扫描堆中的对象是否无人使用.
            Person *p1 = [Person new];
            p1 = nil;
    2). ARC: 不是运行时. 在编译的时候就在合适的地方插入retain,
          插入的代码足以让对象无人使用的时候 引用计数器为0
 
    3). GC 相对于ARC性能来说. ARC 性能更高.
 
 
 
 
 
 
 */

#import <Foundation/Foundation.h>
#import "Pig.h"
#import "NSString+numCount.h"

int main(int argc, const char * argv[]) {
    //类方法创建的对象,要求这个对象在方法中就已经被autorelease过了, 反之:对象方法就不用
   @autoreleasepool {
       Pig *p1 = [[Pig alloc] initWithName:@"AAA" andAge:1 andWeight:100];  //调用两个方法
       NSLog(@"%@",[p1 name]);  //AAA
       
       Pig *p2 = [Pig pigWithName:@"BBB" andAge:2 andWeight:120];           //调用一个方法
   }
    
    //类方法的规则
   @autoreleasepool {
       NSString *str1 = [[NSString alloc] initWithFormat:@"jack"]; //对象方法没有加入对象池中,可以手式加上
       NSString *str2 = [[[NSString alloc] initWithFormat:@"jack"] autorelease];
       
       NSString *str3 = [NSString stringWithFormat:@"jack"];       //类方法已经加入对象池中
   }
    
    //强,弱指针
    @autoreleasepool {
        //不能创建对象用1个弱指针存储这个对象的指针.
        //创建出来的这个对象没有被任何强指针指向,就会被释放
        //__weak Pig *p1 = [[Pig alloc] init];
        NSLog(@"----");
    }
   
    
    //分类,非正式协议
    NSString *str = @"aaa111bbb222";
    NSLog(@"count:%d", [str numberCount]);
    
    
    
    
    
    
    
    
    
    
    
    return 0;
}
