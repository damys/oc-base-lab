/*
 
  在执行时, Student *stu1 = [Student new] 会作类加载,
     加载项有: 
            1. Student 自己定义的属性,方法
            2. Person  类(_name, - (void)say...)
            3. NSObject 类(isa, description,..)
     所有子类对象中有自己的属性,方法,与所有父类的属性,方法
 
     [stu1 say] 执行的顺序是: 通过stu1 指针(栈)找到对象 -> Student 的isa(堆) -> Student(代码段)中 - (void)say
     
     代码段中的每一个类都有一个叫做isa 的指针,这个指针指向它的父类,一直指到NSObject.
     [stu1 say];  //假设stu1是Person对象.
     1. 先根据stu1 指针找到stu1 指向的对象,然后根据对象的isa 指针找到Person 类.
     2. 搜索Person 类中是否有这个say 方法 如果有执行
     3. 如果没有 就根据类的isa 指针找父类, NSObject 中如果没有就报错.
 
 
1. 结构体与类
     1/相同点: 都可以将多个数据封装为一个整体
        struct Data{
            int year;
            int month;
            int day;
        }
 
        @interface Date : NSObject{
             int year;
             int month;
             int day;
         
         }
         @end;
 
    2/不同点: 结构体只能封装数据, 而类不仅可以封装数据,还可以封装行为
             结构体变量分配在栈空间,对象分配在堆空间.
 
     栈的特点: 空间相对较小. 但是存储在栈中的数据访问的效率更高一些
     堆的特点: 空间相对较大. 但是存储在堆中的数据访问的效率相对要低
        结论: 存储在栈中的数据访问效率高 存储在堆中的数据访问效率低
 
    3/赋值:
         结构体: Student  是值赋值
            类: Person    是对象的地址
         
         Student s1 = {"Tom",19,GenderMale};
         Student s2 = s1;
         
         Person *p1 = [Person new];
         Person *p2 = p1;
 
 
    4/应用场景:
         1). 如果表示的这个实体 不仅是由多个数据组成, 这个是实体还有行为,不解释只能使用类.
         2). 如果表示的实体没有行为.光有属性.
             a. 如果属性较少.只有几个. 那么这个时候就定义为结构体 分配在栈 提高效率.
             b. 如果属性较多.不要定义成结构体. 因为这样结构体变量会在栈中占据很大1块空间反而会影响效率. 就定义为类.
 
         比如:日期就比较适合定义为结构体.
 
 
 2. 如何拿到存储在代码段中类的对象
        a) 调用类的类方法 class 就可以得到存储类的类对象的地址
        b) 调用对象的对象方法 class 就可以得到存储这个对象所属的类的Class对象的地址.
        c) 对象中的isa指针的值其实就是代码段中存储类的类对象的地址.
     注意: 声明Class指针的时候 不需要加* 因为在typedef的时候已经加了*了.
 
     如何使用: 
          Class c1 = [Person class]; 
                c1 对象就是(等价于)Person 类,即可以调用类的属性,方法
          [c1 hi];    //c1 = Person, 即可以调用类方法调用  + (void)hi;
 
 
 3. SEL 全称叫 selector 选择器, 是一个数据类型(其实是一个类), 所以要在内存中申请空间存储数据
    1) 类是以Class对象的形式存储在代码段之中.
         类名:存储的这个类的类名. NSString
         
    2) 还要将方法存储在类对象之中.如何将方法存储在类对象之中.
         1). 先创建1个SEL对象.
         2). 将方法的信息存储在这个SEL对象之中.
         3). 再将这个SEL对象作为类对象的属性.
         
         
    3). 拿到存储方法的SEL对象.
         1. 因为SEL是1个typedef类型的 在自定义的时候已经加*了.所以 我们在声明SEL指针的时候 不需要加*
         2. 取到存储方法的SEL对象,
         SEL s1 = @selector(方法名);
 
 
    4) 调用方法的本质.
         内部的原理:  如: [p1 say];
         1. 先拿到存储say方法的SEL对象，也就是拿到存储say方法的SEL数据. SEL消息.
         2. 将这个SEL消息发送给p1对象.
         3. 这个时候,p1对象接收到这个SEL消息以后 就知道要调用方法
         4. 根据对象的isa指针找到存储类的类对象.
         5. 找到这个类对象以后 在这个类对象中去搜寻是否有和传入的SEL数据相匹配的.
         如果有 就执行  如果没有再找父类 直到NSObject
         
         
     5) OC最重要的1个机制:消息机制.
         调用方法的本质其实就是为对象发送SEL消息.
         [p1 say]; 为p1对象发送1条say消息.
 
     6) 重点掌握:
         1) 方法是以SEL对象的形式存储起来.
         2) 如何拿到存储方法的SEL对象.
 
     7) 手动的为对象发送SEL消息.
         1) 先得到方法的SEL数据. 将这个SEL消息发送给p1对象.
         2) 调用对象的方法 将SEL数据发送给对象. - (id)performSelector:(SEL)aSelector;
             如:两种调用1个对象
             Person *p1 = [Person new];
             [p1 say]
 
             SEL s1 = @selector(say);
             [p1 performSelector:s1] == [p1 say]效果是完全一样的.
 
         3) 调用1个对象的方法有两种.
             第一种:[对象名 方法名]
             第二种:手动的为对象发送SEL消息.
 
 
     8) 注意:
         1). 如果方法有参数 那么方法名是带了冒号的.
         2). 如果方法有参数,如何传递参数.
         那么就调用另外1个方法.一般小于2个参数
         - (id)performSelector:(SEL)aSelector withObject:(id)object;
         - (id)performSelector:(SEL)aSelector withObject:(id)object1 withObject:(id)object2;
 
     9). 如果有多个参数(大于3个):封装为一个对象就可以了
 
     10) 关于SEL 只要知道:
         1) 类是以Class对象的形式存储在代码段.
         2) 如何取到存储类的类对象.
         3) 如何使用类对象调用类的类方法
         4) 方法是以SEL数据的形式存储的.
         5) 调用方法的两种方式.
 
 
 4. 点语法
     对象名.去掉下划线的属性名;
     p1.name = @"jack";        这个时候就会将@"jack"赋值给p1对象的_name属性.
     NSString *name = p1.name; 把p1对象的_name属性的值取出来.
 
     1.原理:  p1.age = 18;    这句话的本质并不是把18直接赋值给p1对象的_age属性.
           点语法在编译器编译的时候.其实会将点语法转换为调用setter、getter的代码.
     
     2.赋值,取值调用过程:
         1) 当使用点语法赋值的时候. 这个时候编译器会将点语法转换为调用setter方法的代码.
         对象名.去掉下划线的属性名 = 数据;
         转换为:[对象名 set去掉下划线的属性名首字母大写:数据]; 如:
          p1.age = 10;  会换成: [p1 setAge:10];
         
         
         2) 当使用点语法取值的时候.这个时候编译器会将点语法转换为调用getter方法的代码.
         对象名.去掉下划线的属性名;
         转换为:[对象名 去掉下划线的属性名]; 如:
         int age = p1.age; 会换成:  int age = [p1 age];
 
     3.注意:
         1) 在getter和setter中慎用点语法,因为有可能会造成无限递归 而程序崩溃,
         2) 点语法在编译器编译的时候 会转换为调用setter getter方法的代码,并且方法名要符合规范.
              p1.name = @"jack";
             [p1 setName:@"jack"]
             NSString *name = p1.name;
             NSString *name = [p1 name];
 
         3) 如果属性没有封装getter setter 是无法使用点语法的, 因为点语法的本质是getter setter方法.
 
 
 5. @property 关键字
    1) 问题:setter, getter的声明是没有什么任何技术含量
    2) 作用: 自动生成setter, getter 方法声明
    3) 语法: @property 数据类型 名称;  如:@property int age;

    4) 原理:编译器在编译的时候.会根据@property生成getter和setter方法的实现.
        @property 数据类型 名称;  生成为:
        - (void)set首字母大写的名称:(数据类型)名称;
        - (数据类型)名称;

        @property int age;
        - (void)setAge:(int)age;
        - (int)age;
 
    5) 注意:
         1. @property的类型和属性的类型一致.
            @property的名称和属性的名称一致(去掉下划线)不要乱写.
         
         2. @property的名称决定了生成的getter和setter方法的名称.
           所以,@property的名称要和属性的名称一致 去掉下划线  否则生成的方法名就是不符合规范的
               @property的数据类型决定了生成的setter方法的参数类型 和 getter方法的返回值类型.

         3. @property只是生成getter和setter方法的声明. 实现还要自己来. 属性还要自己定义.
 
 
 6. @synthesize 关键字
    1) 问题: setter, getter的实现也是没有什么任何技术含量
    2) 作用: 自动生成getter、setter方法的实现.
    3) 语法: @synthesize @property名称; 如:
            @interface Person : NSObject{
                int _age;
            }
            @property int age;
            @end

            @implmentation Person
            @synthesize age;
            @end
 
    4) 原量:
            @implementaion Person{ int age; }
            - (void)setAge:(int)age{ self->age = age; }
            - (int)age{ return age; }
            @end
 
            等价于上面的原始写法:
            @implmentation Person
            @synthesize age;
            @end
 
         1. 生成1个真私有的属性.属性的类型和@synthesize对应的@property类型一致. 属性的名字和@synthesize对应的@property名字一致.
         2. 自动生成setter方法的实现. 实现的方式: 将参数直接赋值给自动生成的那个私有属性.并且没有做任何的逻辑验证.
         3. 自动生成getter方法的实现. 实现的方式: 将生成的私有属性的值返回.
 
    5) 希望@synthesize不要去自动生成私有属性了. getter setter的实现中操作我们已经写好的属性就可以了.
       5.1 语法:   @synthesize @property名称 = 已经存在的属性名;
            如: @synthesize age = _age;
       5.2 不会再去生成私有属性. 直接生成setter getter的实现,
             setter的实现: 把参数的值直接赋值给指定的属性.  { _age = age; }    与原始写法一样
             gettter的实现: 直接返回指定的属性的值.        { return = _age; } 与原始写法一样
 
       5.3 注意:
          1). 如果直接写1个@synthesize  如: @synthesize name;
          2). 如果指定操作的属性. 如: @synthesize name = _name;
          3). 生成的setter方法实现中 是没有做任何逻辑验证的 是直接赋值.
              生成的getter方法的实现中 是直接返回属性的值.
         如果setter或者getter有自己的逻辑验证 那么就自己在类的实现中 重写(原始写法)就可以了.
 
       5.4 批量声明:
         1). @property的类型一致. 可以批量声明.
             @property float height, weight;
         2). @synthesize也可以批量声明. (类型不一致是可以的)
             @synthesize name = _name, age = _age, weight = _weight, height = _height;
 
 
 7. @property 增强
     @property只是生成getter  setter 的声明.
     @synthesize是生成getter  setter 的实现.
     注: 这种写法是Xcode4.4之前的写法. 从Xcode4.4以后.Xcode对@property做了1个增强
 
     7.1 只需要写1个@property 编译器就会自动
         1) 生成私有属性.
         2) 生成getter setter的声明.
         3) 生成getter setter的实现.
         如: @property NSString *name;  不会带下划线,系统会自动添加带下划线的_name
     
     7.2 做的事情
         1) 自动的生成1个私有属性,属性的类型和@property类型一致,属性的名称和@property的名称一致,属性的名称自动的加1个下划线
         2) 自动的生成这个属性的getter setter方法的声明与实现
         setter的实现: 直接将参数的值赋值给自动生成的私有属性.
         getter的实现: 直接返回生成的私有属性的值.
 
    7.3 使用注意
         1) @property的类型一定要和属性的类型一致. 名称要和属性的名称一致 只是去掉下划线.
         2) 也可以批量声明相同类型的@property
         3) @property生成的方法实现没有做任何逻辑验证.
             setter: 直接赋值
             getter: 直接返回
         所以,我们可以重写setter来自定义验证逻辑.如果重写了setter 还会自动生成getter
         如果重写了getter 还会自动生成setter
         注:如果同时重写getter setter 那么就不会自动生成私有属性了. 需要自己写属性
 
         4) 如果你想为类写1个属性 并且为这个属性封装getter setter, 1个@property就搞定.
         5) 继承. 父类的@property一样可以被子类继承.
             @property生成的属性是私有的 在子类的内部无法直接访问生成的私有属性。
             但是可以通过setter getter来访问。
 
 
 8. 动态类型和静态类型
    8.1 OC是1门弱语言.
        编译器在编译的时候.语法检查的时候没有那么严格.不管你怎么写都是可以的
        int num = 12.12;
        优点: 灵活 咋个行都写.
        缺点: 太灵活
        强类型的语言: 编译器在编译的时候 做语法检查的时候 行就是行 不行就是不行.

    8.2 静态/动态类型
        静态类型:指的是1个指针指向的对象是1个本类对象. 如: Person *p1  = [Person new];
        动态类型:指的是1个指针指向的对象不是本类对象.  如: Person *man = [Man new];
 
    8.3 编译检查
        编译器在编译的时候,能不能通过1个指针去调用指针指向的对象的方法.
        判断原则: 看指针所属的类型之中是否有这个方法,如果有就认为可以调用,编译通过.如果这个类中没有,编译报错.这个叫做编译检查.
        在编译的时候 能不能调用对象的方法主要是看[指针的类型]. 可以将指针的类型做转换(强转),来达到骗过编译器的目的.
 
    8.4 运行检查
        编译检查只是骗过了编译器. 但这个方法究竟能不能执行.运行时会去检查对象中是否真的有这个方法.如果有就执行,没有就报错.
 
    8.5 LSP: 父类指针指向子类对象.实际上任意的指针可以执行任意的对象.编译器是不会报错的.
        当1个子类指针执行1个父类对象的时候,编译器运行通过子类指针去调用子类独有的方法.
        但是在运行的时候是会出问题的.因为父类对象中根本没有子类成员.
        如: Pig *p = @"jack";   [p eat];   //编译错
 
 
 9. id 类型
    9.1 NSObject: 是OC中所有类的基类.根据LSP NSObject指针就可以指向任意的OC对象.
         所以.NSObject指针是1个万能指针.可以执行任意的OC对象.
         缺点: 如果要调用指向的子类对象的独有的方法.就必须要做类型转换.
 
    9.2 id指针: 是1个万能指针,可以指向任意的OC对象.
         1) id是1个typedef自定义类型 在定义的时候已经加了*,所以,声明id指针的时候不需要再加*了.
         2) id指针是1个万能指针,任意的OC对象都可以指.
 
   9.3 NSObject和id的异同.
        相同点: 万能指针 都可以执行任意的OC对象.
        不同点: 通过NSObject指针去调用对象的方法的时候.编译器会做编译检查.
               通过id类型的指针去调用对象的方法的时候,编译器直接通过.无论你调用什么方法.

    id指针缺点: 只能调用对象的方法, 不能使用点语法.如果使用点语法就会直接报编译错误 。
               如果我们要声明1个万能指针, 千万不要使用NSObject 而是使用id

 
     9.4 父类中的类方法创建1个父类对象返回.
            1). 如果返回值写为父类类型的.那么子类来调用这个方法得到的就是父类指针.
                解决的方式: 把返回值改为id类型的.

            2). 方法的内部创建的对象的是 不要写死. 因为写死创建的对象就固定了.
            我们希望那1个类来调用这个方法就创建那1个类的对象.
            把类名写为self 那1个类来调用这个方法 self就指的是那1个类.创建的就是那1个类的对象.
             + (id)person{return [self new];}
             Person *p1 = [Person person];
             Studen *s1 = [Studen person];

            3). 方法的返回值是id类型的.问题就是任意指针都可以接收这个方法的返回值.
            编译器连个警告都没有.
            如果方法的返回值是instancetype, 代表方法的返回值是当前这个类的对象.
            + (instancetype)person{return [self new];}
 
    9.5 使用建议
             1). 如果方法内部是在创建当前类的对象,不要写死成类名 [类名 new]; 而是用self代替类名.
             2). 如果方法的返回值是当前类的对象,也不要写死了. 而是写instancetype
 
    9.6 id和instancetype的区别.
             1).instancetype只能作为方法的返回值.不能在别的地方使用.
             id既可以声明指针变量 也可以作为参数 也可以作为返回值.
             
             2). instancetype 是1个有类型的 代表当前类的对象.
             id是1个无类型的指针 仅仅是1个地址.没有类型的指针.
 
 
 10. 动态类型检测
     10.1 OC 编译器: LLVM 编译器在编译的时候. 判断1个指针是否可以调用指向的对象的方法.判断的准则就是指针的类型.
            [(Person*)obj1 say]; 可以很轻松的把编译器给骗过,程序运行是还会做检查
 
 
     10.2 我们就希望.我们可以写代码来先判断1下.对象中是否有这个方法.如果有再去执行.如果没有就别去执行.
        1). 判断对象中是否有这个方法可以执行.--常用,调用别人方法
             - (BOOL)respondsToSelector:(SEL)aSelector;
             如: [p1 respondsToSelector:@selector(say)];
 
        2). 判断类中是否有指定的类方法. --常用
            + (BOOL)instancesRespondToSelector:(SEL)aSelector;
             如:[Person instancesRespondToSelector:@selector(say)];
 
     10.2 判断指定的对象是否为指定类的对象或者子类对象.
        - (BOOL)isKindOfClass:(Class)aClass;
        如: BOOL b1 = [s1 isKindOfClass:[Person class]];
            判断s1对象是否为Person对象或者Person的子类对象.
 
     10.3 判断对象是否为指定类的对象, 不包括子类.
        - (BOOL)isMemberOfClass:(Class)aClass;
        如: [s1 isMemberOfClass:[Student class]];
            判断s1对象是否为1个Student对象. 不包括Student的子类对象.
 
     10.4 判断类是否为另外1个类的子类.
         + (BOOL)isSubclassOfClass:(Class)aClass;
        如: [Student isSubclassOfClass:[Person class]];
            判断Student 类对象是滞为Person的子类
 
 
 11. 构造方法
    11.1 创建对象, 类名 *指针名 =  [类名  new];  new实际上是1个类方法.
        1. new方法的作用:创建对象。初始化对象, 把对象的地址返回.
        2. new方法的内部,其实是allon init, 先调用的alloc方法. 再调用的init方法.
             alloc方法是1个类方法,作用: 那1个类调用这个方法 就创建那个类的对象,并把对象返回.
             init方法 是1个对象方法,作用: 初始化对象.

        3. 创建对象的完整步骤:
            应该是先使用alloc创建1个对象,然后再使用init初始化这个对象 才可以使用这个对象.
            虽然没有初始化的对象, 有的时候也可以使用. 但是千万不要这么做.使用1个未经初始化的对象是极其危险的.
          如:
            Person *p1 = [Person new];
            完全等价于
            Person *p1 = [[Person alloc] init];
 
    11.2 init方法.  作用: 初始化对象,为对象的属性赋初始值 这个init方法我们叫做构造方法.
         init方法做的事情:初始化对象. 为对象的属性赋默认值.

         如果属性的类型是基本数据类型就赋值为0
         C指针    NULL
         OC指针   nil

        所以.我们创建1个对象如果没有为这个对象的属性赋值 这个对象的属性是有默认值的.
        所以,我们每次新创建1个对象,这个对象的属性都被初始化了.
 
    11.3 我们想要让创建的对象的属性的默认值不是 nil NULL 0
        而是我们自定义的. 那么这个时候,我们就可以重写init方法. 在这个方法中按照我们自己的想法为对象的属性赋值.

        1. 重写init方法的规范:
            1) 必须要先调用父类的init方法.然后将方法的返回值赋值给self
            2) 调用init方法初始化对象有可能会失败,如果初始化失败.返回的就是nil
            3) 判断父类是否初始化成功. 判断self的值是否为nil 如果不为nil说明初始化成功.
            4) 如果初始化成功 就初始化当前对象的属性.
            5) 最后 返回self的值.

        2. 为什么要调用父类的init方法.
            因为父类的init方法 会初始化父类的属性. 所以必须要保证当前对象中的父类属性也同时被初始化.

        3. 为什么要赋值给self？
            因为.调用父类的init方法 会返回初始化成功的对象
            实际上返回的就是当前对象。但我们要判断是否初始化成功.
            无论如何,记住重写init方法的规范: 在实现中写
            - (instancetype)init{
                if(self = [super init]){
                     //初始化当前类的属性的代码;
                     self.name = @"jack";
                }
                retrun self;
            }

        4. 什么时候需要重写init方法:
            如果你希望创建出来的对象的属性的默认值不是 nil NULL 0 而是我们指定的值.就可以重写init方法.
 
 
    10.4  重写init方法以后.
        这样每次创建出来的对象的属性的值都是一样的.
        创建对象的时候,对象的属性的值由创建对象的人来指定.而不是写死在init方法中

        自定义构造方法. 规范:
            1). 自定义构造方法的返回值必须是instancetype
            2). 自定义构造方法的名称必须以initWith开头.
            3). 方法的实现和init的要求一样.
            - (instancetype)initWithName:(NSSing *)name;
 
            - (instancetype)initWithName:(NSString *)name andAge:(int)age{
                if(self = [super init]){
                    self.name = name;
                    self.age = age;
                }
                return self;
            }
            
 
            //要使用alloc
            Person *p1 = [[Person alloc] initWithName:@"Tom" andAge:24];
             ==
            Person *p2 = [Person new];
            p2->setName=@"Tom";  == p2.name=@"Tom";
            p2->setAge=24;       == p2.age = 24;
 
 
 */

#import <Foundation/Foundation.h>
#import "person.h"

int main(int argc, const char * argv[]) {
    
   //拿到存储在代码段中类的对象
   Class c1 = [Person class];
   NSLog(@"%p", c1);          //0x100001178,  c1 对象就是(等价于)Person 类,即可以调用类的属性,方法
   
   
   Person *p1 = [Person new];
   Class c2 = [p1 class];
   NSLog(@"%p", c2);          //0x100001178
   
   
   Person *p2 = [c1 new];    //c1 = Person
   [p2 say];
   
   [c1 hi];                  //c1 = Person, 即可以调用类方法调用  + (void)hi;
   [c2 hi];

      //SEL
   SEL s1 = @selector(say);
   NSLog(@"%p", s1);
    
   //NSObject 需要类型强转
   NSObject *obj1 = [Person new];
   [(Person*)obj1 say];
    
    //id
   id id1 = [Person new];   //id是1个typedef自定义类型,不需要*
   [id1 say];
   [id1 setName:@"property..."];
   NSLog(@"%@",[id1 name]);
    
    //动态类型检测,如果否则该方法,就去调用该方法
    Person *p1 = [Person new];
    BOOL b = [p1 respondsToSelector:@selector(say)];
    if(b){
        [p1 say];
    }else{
        NSLog(@"没有该方法");
    }
    
    
    


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    return 0;
}
