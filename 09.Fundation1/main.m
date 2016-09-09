/*
Foundation框架:  是1个包 这里面有很多类、函数、定义了一些数据类型.
    这个框架中的类都是一些最基础的类. NSString NSObject...
    其他的框架都是基于Foundation框架, UIKit, AVFoundation

1.  NSString
    1) NSString是1个数据类型.保存OC字符串的. NSString的本质是1个类.既然是1个类.
        最标准的创建NSString对象的方式:
        NSString *str1 = [NSString new];
        NSString *str2 = [[NSString alloc] init];
        NSString *str3 = [NSString string];

    2) 这种方式快捷创建的字符串是1个空的字符.  @""
        NSString *str = @"jack";
        格式控制符%p: 打印指针变量的值.打印地址.
        格式控制符%@:  打印指针指向的对象.
 
    3) NSString的恒定性.
        1. 使用快捷方式创建字符串是存在常量区
            NSString *str = @"jack"; //是存在常量区的
            str = @"rose"  
            修改不是原来的字符串对象,而是重新创建一个字符串对象, 将这个字符串对象的地址重新复制给字符串指针变量
 
        2. 创建的字符串对象是存储在堆区:
            NSString *str1 = [NSString stringWithFormar:@"jack"];
            NSString *str2 = [NSString new];
 
        2. 当系统准备要在内存中创建字符串对象的时候.会先检查内存中是否有相同内容的字符串对象.
           如果有,直接指向. 如果没有才会重新创建.
             NSString *str1 = [NSString new];
             NSLog(@"str1=%p", str1);         //0x7fff7ab82d20
             str1 = nil;
             NSString *str2 = [NSString new];
             NSLog(@"str2=%p", str2);         //0x7fff7ab82d20  是一样的

        3. 存储在常量区的数据不会被回收. 所以存储在常量区的字符串对象也不会被回收.

 
2. NSString是1个类. 使用频率高的几个方法.
    1). 使用拼接的方式创建1个NSString对象.
        + (instancetype)stringWithFormat:(NSString *)format, ...
        NSString *newStr = [NSString stringWithFormart:@"name:%@, age:%d", name, age];

    2). 得到字符串的长度.
        @property (readonly) NSUInteger length;
        NSUInteger len = str.length;

    3). 得到字符串中指定下标的字符.
        - (unichar)characterAtIndex:(NSUInteger)index;
        返回值是unichar类型的 要打印的话使用%C
        unichar ch = [str characterAtIndex:2];


    4). 判断两个字符串的内容是否相同.
        1. 能否使用 == 来判断两个OC字符串的内容是否相同.
        2. == 运算符的作用: 比较左右两边的数据是否相同.
            10 == 10  这个时候直接比较的是左右两边的数据是否相同.
             a == b   两边也可以写1个变量.这个时候比较是左右两边的变量的值是否相同.
        3. 如果两边是1个指针变量.那么比较的也是变量的值. 只不过指针变量的值是地址.
 
        3. 调用方法:
         - (BOOL)isEqualToString:(NSString *)aString;
 
           [str1 isEqualToString(str2)];
          比较当前字符串对象和传入的字符串对象的内容是否相同.

    5). 将C语言的字符串转换为OC字符串对象.
        + (nullable instancetype)stringWithUTF8String:(const char *)nullTerminatedCString;
 
         char *name = "jack";
         NSString *ocName = [NSString stringWithUTF8String:name];

    6). 将OC字符串对象转换为C语言的字符串.
        @property (nullable, readonly) __strong const char *UTF8String
 
        NSString *str = @"tom";
        const char *ch = [str UTF8String];  //str.UTF8String;
        NSLog(@"%s", ch);


3. File
    1. 写文件
        - (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error;
        第一个参数:path,
        第二个参数:BOOL 如果是YES,先存临时文件后转指定文件
                            NO, 直接存指定文件, 推荐用NO
        第三个参数:编码,是一个枚举,4 或 NSUTF8StringEncoding
        第四个参数:二级指针,要传递一个NSERROR指针的地址, 返回值是BOOL
                 如果写入成功,这个指针的值就是nil,
                 如果写入失败,这个指针会指向一个错误对象
            NSString *str = @"hello world";
            NSError *err;
            BOOL res = [str writeToFile:@"/Users/damys/Desktop1/test.txt" atomically:NO encoding:NSUTF8StringEncoding error:&err];   //如果不想出现错误:&err 改为nil
            //LogBOOL(res);

            if(err != nil){
                NSLog(@"写入失败:%@", err.localizedDescription);  //只打印出错误的简要信息
            }

    2. 读文件
        + (nullable instancetype)stringWithContentsOfFile:(NSString *)path encoding:(NSStringEncoding)enc error:(NSError **)error;      nullable 代表返回的对象有可能是nil
        NSError *err;
        NSString *content = [NSString stringWithContentsOfFile:@"/Users/damys/Desktop/test.txt" encoding:NSUTF8StringEncoding error:&err];

        if(err == nil){
            NSLog(@"%@", content);   //成功就读取文件内容
        }
 
    3. NSURL读写资源.
        1). NSURL对象. 专门用来保存资源地址的. 资源地址: 本地磁盘路径、网页地址、ftp文件地址.
        2). 资源路径的地址的写法:
            http://   开头的是网页路径的写法.
            file://   开头的是本地磁盘的路径. 如:file:///Users/damys/test
            ftp://    开头的是ftp文件资源的路径
            如果要讲1个资源路径的地址保存到NSURL对象中 地址一定要是标准写法.

        3). 如何将资源地址存储到NSURL对象中.
            NSURL *url1 = [NSURL URLWithString:@"http://www.baidu.com"];
            NSURL *url2 = [NSURL URLWithString:@"ftp://server.baidu.com/ccc.txt"];
            NSURL *url3 = [NSURL URLWithString:@"file:///Users/damys/Desktop/test.txt"];
 
        4). NSURL获取资源文件
            从指定资源路径读取文本内容.
            + (nullable instancetype)stringWithContentsOfURL:(NSURL *)url encoding:(NSStringEncoding)enc error:(NSError **)error;

            NSString *str = [NSString stringWithContentsOfURL:url3 encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"%@",str);
 
        5). NSURL写入资源文件
            - (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error;
            如果要向网页或者ftp写内容要有权限.

            NSString *data = @"dddd";   //可以写普通string, 也可以写获取到的网页内容
            BOOL res = [str writeToURL:url3 atomically:NO encoding:NSUTF8StringEncoding error:nil];
            LogBOOL(res);
 
4 字符操作
    4.1 字符串比较.
        - (NSComparisonResult)compare:(NSString *)string;
 
        NSComparisonResult res = [str1 compare:str2]
        int res = [str1 compare:str2];   等价于上面一行
 
    4.2 判断字符串是否以指定的字符串开头
        - (BOOL)hasPrefix:(NSString *)str;
 
            NSString *str = @"http://www.baidu.com";
            BOOL res = [str hasPrefix:@"https"];    //NO
            LogBOOL(res);

    4.3 判断字符串是否以指定的字符串结尾
        - (BOOL)hasSuffix:(NSString *)str;
 
            NSString *img = @"abc.jpg";
            BOOL res = [img hasSuffix:@".jpg"];      //YES
            LogBOOL(res);
 
    4.4 在主串中搜索子串.从前往后, 第1次匹配的子串.
        - (NSRange)rangeOfString:(NSString *)searchString;  返回值是1个NSRange类型的结构体变量.
        返回值是一个结构体:
        typedef struct _NSRange {
            NSUInteger location; 代表子串在主串出现的下标.
            NSUInteger length;   代表子串在主串中匹配的长度.
        } NSRange;
        
            NSString *str = @"aabb ccdd";
            NSRange range = [str rangeOfString:@"cc"];
            NSLog(@"下标为:%lu", range.location);    //5
            NSLog(@"长度为:%lu", range.length);      //2
 
        如果没有找到,返回值:
        location 为NSUInteger的最大值, 也就是NSNotFound: if(range.location == NSNotFound)
        length 的值为0,                         可以判断:if(range.length== 0) 没有找到

    4.5 在主串中搜索子串.从后往前.
        NSString *str = @"i love ios love!";
        NSRange range =  [str rangeOfString:@"love" options:NSBackwardsSearch];

    4.6 NSRange结构体.
        1). 是Foundation框架中定义的1个结构体.
            typedef struct _NSRange {
                NSUInteger location;
                NSUInteger length;
            } NSRange;

        NSRange range;
        这个结构体变量一般情况下用来表示1段范围.特别用在子串在主串中的范围表示.
 
        @"aabbjackccdd"
        可以匹配 @"jack"  NSRange range = {4, 4};

        2). 声明并初始化结构体变量的方式.
            a) 最原始的方式: 为属性赋值
                NSRange range;
                range.location = 3;
                range.length = 4;
            b) 第二种方式: NSRange range = {3, 7};
            c) 第三种方式: NSRange range = {.location = 3,.length = 7};
 
            d) (推荐)第四种方法:Foundation框架中定义了1个函数.这个函数可以快速的创建1个NSRange结构体会,
                NSRange range = NSMakeRange(loc, len);
                NSRange range = NSMakeRange(3, 7);
                返回1个指定属性的NSRange结构体变量.
 
        3). Foundation框架中定义了1个函数 可以将1个NSRange结构体变量转换为NSString
            NSStringFromRange(ran) 函数可以将NSRange结构体变量转换为指定格式的字符串.
 
            NSRange ran = NSMakeRange(3, 7);
            NSLog(@"ran.loc = %lu ran.len = %lu", ran.location, ran.length);  //ran.loc = 3 ran.len = 7
            NSLog(@"%@", NSStringFromRange(ran));   //{3, 7}
 
 
    4.7 字符串的截取.   取到字符串中的1部分.
        - (NSString *)substringFromIndex:(NSUInteger)from; 从指定的下标出一直截取到最后.
        - (NSString *)substringToIndex:(NSUInteger)to; 从第0个开始截取指定的个数.
        - (NSString *)substringWithRange:(NSRange)range; 截取指定的1段范围.  要传一个范围
            //字符串的截取
            NSString *name = @"aabbccdd";
            NSLog(@"截取后的字符串为:%@", [name substringFromIndex:3]);  //bccdd
            NSLog(@"截取后的字符串为:%@", [name substringToIndex:3]);    //aab

            //要传一个范围
            NSRange ran = NSMakeRange(2, 3);
            NSLog(@"截取后的字符串为:%@", [name substringWithRange:ran]); //bbc

    4.8  字符串的替换
        - (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement
 
            NSString *name = @"aabb";
            name = [name stringByReplacingOccurrencesOfString:@"b" withString:@"f"];
            NSLog(@"替换后的字符串为:%@", name);  //aaff

        将字符串中第1个参数替换为第2个参数.友情提示: 原来的指针指向字符串的内容是不会变的,替换时会做全部替换.
        新串是以方法的返回值返回的.要重新接收一下
        还可以做删除. 原理: 将其替换为@"", 也就是空串

    4.9 字符串数据转换为其他的类型.
        @property (readonly) double doubleValue;
        @property (readonly) float floatValue;
        @property (readonly) int intValue;
        @property (readonly) NSInteger integerValue
        @property (readonly) long long longLongValue
        @property (readonly) BOOL boolValue
 
        NSString *num = @"100";
        NSLog(@"num=%d", num.intValue + 1);        //101
        NSLog(@"num=%.2lf", num.doubleValue + 1);  //101.00
        NSLog(@"num=%.2f", num.floatValue + 1);    //101.00

        转换注意. 从头开始转换,能转换多少就是多少. 到遇到不能转换的时候就停止转换.如:
        NSString *num = @"100aa101";  可以转.为100
        NSString *num = @"aa100";   不可以转


    4.10 去掉字符串前后的空格.
        str =  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
 
         NSString *name = @"  aa bb ";
         name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
         NSLog(@"name %@", name);   //name aa bb  中间的空格无法去掉.

    4.11 大小写转
        NSString *str = @"AaBbCc";
        str = [str uppercaseString];    //AABBCC
        str = [str lowercaseString];    //aabbcc
        NSLog(@"转换后的字符串为:%@", str);

 
 
 5. NSMutableString  字符串的可变性
    5.1 字符串的恒定性.
        一旦创建1个字符串对象,那么这个字符串对象的内容就无法更改, 当我们修改字符串的时候,其实是重新的创建了1个字符串对象.
        代码案例:
        NSLog(@"-------------------");
        NSString *str = @""; //@""
        for(int i = 0; i < 50000; i++){
            str = [NSString stringWithFormat:@"%@%d",str,i];
        }
        NSLog(@"-------------------");
 
        会耗费很长的时间. 每次循环的时候都会创建1个新的字符串对象. 上面就创建了50000个,
        因为字符串的[恒定性]: 每次修改字符串的时候,是重新的创建1个对象,

    5.2 如何让这样的大批量的字符串拼接可以更加快速的1点.
        有没有一种对象是用来存储字符串的,并且存储在这个对象中的字符串数据可以更改.
 
    5.3 NSMutableString
        1). 从NSString继承. NSMutableString对象是用来存储字符串数据的.
        2). 存储在NSSMutableString对象中的字符串数据可以更改.具备可变性.不会新创建对象.
 
    5.4 NSMutableString的用法
        1). 既然是1个类,要使用的话,就得创建1个对象.
            NSMutableString *str = [NSMutableString string];
 
        2). 往可变字符串对象中追加字符串.
            - (void)appendString:(NSString *)aString;  直接追加内容.
            - (void)appendFormat:(NSString *)format, ... 以拼接的方式往可变字符串对象中追加内容.
            
            NSMutableString *str = [NSMutableString string];
            [str appendString:@"aa"];
            [str appendString:@"bb"];
            [str appendString:@"cc"];
            NSLog(@"str = %@", str);   //aabbcc

            //拼接的方式追加
            int age = 10;
            [str appendFormat:@" %d岁了",age];
            NSLog(@"str = %@", str);   //aabbcc 10岁了
 
 
        3). 注意: 这样的初始化方式是不正确: 
            NSMutableString *str = @"jack";
            @"jack" 是1个NSString对象, 是1个父类对象.
 
            而str指针是1个NSMutableString类型, 是1个子类类型的.
            如果通过子类指针去调用子类独有的成员就会运行错误.
 
        4). 使用NSMutableString来做大批量的字符串拼接.
            NSLog(@"~~~~~~~~~~~~");
            NSMutableString *str = [NSMutableString string];
            for(int i = 0; i < 100000; i++){
                [str appendFormat:@"%d",i];
            }
            NSLog(@"~~~~~~~~~~~~");

            因为NSMutableString只有1个.每次修改的时候 直接修改的是这个对象中的数据.

    5.5. 使用建议
        1). 我们平时使用的时候,还是使用NSString. 因为效率高.
            NSString *str1 = @"jack";
            NSString *str2 = @"jack";   str1, str2 指向同一个对象

        2). NSMutbaleString: 只在做大批量的字符串拼接的时候才使用.
           大量拼接的时候,就不要去使用NSString 因为效率低下, 5次以上.

 
 6. NSArray
    6.1 回忆C语言中的数组. 特点:
        1) 存储多个数据.
        2) 类型相同.
        3) 长度固定.
        4) 每1个元素都是紧密相连的.

    6.2 NSArray. 特点:
        1) 只能存储OC对象. 任意的OC对象
        2) 长度固定. 一旦NSArray数组创建完毕之后,元素的长度固定,无法新增 无法删除元素.
        3) 每1个元素都是紧密相连的. 每1个元素仍然有自己的下标.
        4) 元素的类型是id类型的.

    6.3 NSArray数组的创建.
        1) 没有意义的创建
            a) 因为这是1个类,所以当然就是创建NSArray对象.
                NSArray *arr1 = [NSArray new];
                NSArray *arr2 = [[NSArray alloc] init];
                NSArray *arr3 = [NSArray array];
            这样创建出来的NSArray数组的元素的个数是0个,因为长度固定,不能增加与删除. 所以没有任何意义.
 
            b) 创建数组的同时指定1个数组的元素. 仍然没有意义,因为这个数组中只有1个元素.
                + (instancetype)arrayWithObject:(ObjectType)anObject;
                NSArray *arr = [NSArray arrayWithObject:@"jack"];

        2) 最常用的创建NSArray数组的方式.
            + (instancetype)arrayWithObjects:(ObjectType)firstObj, ...

            NSArray *arr = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", nil];
            NSLog(@"数据为:%@", arr);   //a,b,c,d
            使用注意: 只能存储OC对象. 最后一个元素要写1个nil(nil = 0 是基本数据类型), 表示元素到此结束了.

        3) 创建NSArray数组的简要方式. 不需要在最后加nil.
            NSArray *arr = @[写上每1个元素的值用逗号分隔];
 
            NSArray * arr = @[@"a", @"b", @"c", @"d"];
            NSLog(@"数据为:%@", arr);   //a,b,c,d

    6.4 取出存储在NSArray数组中的元素的值.
        1). 可以使用下标取出对应的元素的值.
            NSArray * arr = @[@"a", @"b", @"c"];
            NSLog(@"%@", arr[0]);  //a
            NSLog(@"%@", arr[1]);  //b
            NSLog(@"%@", arr[2]);  //c
            如果下标越界 就直接运行报错.

        2). 调用数组对象的对象方法来取出指定下标的元素的值.
        - (ObjectType)objectAtIndex:(NSUInteger)index;
 
            NSArray * arr = @[@"a", @"b", @"c"];
            NSString *str = [arr objectAtIndex:1];
            NSLog(@"%@", str);  //b

 
7. NSArray数组的其他的常用方法
    1). 得到NSArray数组中的元素的个数.
        @property (readonly) NSUInteger count;
 
        NSArray *arr = @[@"a", @"b", @"c", @"d"];
        NSLog(@"length: %lu", [arr count]);  //4
 
    2). 判断NSArray数组中是否包含指定的元素.
        - (BOOL)containsObject:(ObjectType)anObject;
 
        NSArray *arr = @[@"a", @"b", @"c", @"d"];
        BOOL res = [arr containsObject:@"c"];
        NSLog(@"res:%d", res);   //1  注: 1找到. 0没有找到

    3). 取到NSArray数组中的第1个元素.
        @property (nullable, nonatomic, readonly) ObjectType firstObject
 
        NSArray *arr = @[@"a", @"b", @"c", @"d"];
        NSLog(@"第1个元素值:%@", arr[0]);            //a
        NSLog(@"第1个元素值:%@", [arr firstObject]); //a
        NSLog(@"第1个元素值:%@", arr.firstObject );  //a
        与arr[0]的区别. 如果数组中没有任何元素.arr[0]报错. firstObject取到nil 不报错.

    4). 取到NSArray数组中的最后1个元素.
        @property (nullable, nonatomic, readonly) ObjectType lastObject
        
        NSArray *arr = @[@"a", @"b", @"c", @"d"];
        NSLog(@"最后一个元素值:%@", [arr lastObject]); //d
        NSLog(@"最后一个元素值:%@", arr.lastObject );  //d

    5). 查找指定的元素在NSArray数组中第一次出现的下标.
        - (NSUInteger)indexOfObject:(ObjectType)anObject;
 
        NSArray *arr = @[@"a", @"b", @"c", @"d"];
        NSUInteger index = [arr indexOfObject:@"dd"];
        if(index == NSNotFound){  // NSNotFound  = NSUInteger 的最大值
            NSLog(@"没有找到");
        }else{
            NSLog(@"找到了,下标为:%lu", index);  //3
        }
        如果没有找到 返回的是NSUInteger的最大值.
 

8. NSArray数组的遍历.
    8.1 传统方式: 使用for循环来遍历数组中的每1个元素.
        NSArray *arr = @[@"a",@"b",@"c",@"d"];
        for(int i = 0; i < arr.count; i++){
          //NSLog(@"%@",arr[i]);                //方式1
            NSLog(@"%@",[arr objectAtIndex:i]); //方式2
        }
        原理: 将下标挨个挨个遍历出来 取值.

    8.2 增强方式: 使用for循环来遍历NSArray数组中的元素.
        1) 语法格式:
            for(元素类型 变量名 in 数组名){
                直接通过变量名就可以拿到数组中的每1个元素.
            }
            NSArray *arr = @[@"a",@"b",@"c",@"d"];
            for(NSString *str in arr){
                NSLog(@"%@", str);   //abcd
            }

        2) 声明在for()中的变量叫做迭代变量.
        3) 执行的原理.
            将数组中的第1个元素的值赋值给迭代变量.执行循环体.
            将数组中的第2个元素的值赋值给迭代变量.执行循环体.
            .......
            将数组中的最后1个元素的值赋值给迭代变量.执行循环体.
            结束循环.
 
        4) 语法总结:
            1. 迭代变量的类型和数组中的元素的类型保持一致. 如:Person 对象,就是Person
            2. in是固定的.
            3. 遍历哪1个数组,就将数组写在in后面.
            4. 循环体里面. 迭代变量的值就是元素的值.
            注: 当NSArray数组中存储的数据类型不一致时候 迭代变量的类型建议使用id类型.
                Person *p1 = [Person new];
                Person *p2 = [Person new];

                NSArray *arr = @[p1, p2, @"a", @"b", @"c", @"d"];
                for (id item in arr) {
                NSLog(@"%@", item);
                }
                输出:
                <Person: 0x100104960>
                <Person: 0x100103920>
                abcd

    8.3 使用block遍历.
        - (void)enumerateObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block
        这是1个方法.这个方法的作用就是来遍历数组中的每1个元素.
        
         NSArray *arr = @[@"a",@"b",@"c",@"d"];
        //使用技巧: 输入名后,直接回车
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"%@", obj);    //abcd
            NSLog(@"%@ index = %lu", obj, idx);   //abcd 与各下标
 
            //如果想停止遍历:stop 改为YES,  下面表示只打印第1,2条
            if(idx == 1){
                *stop = YES;
            }
        }];

 
8. NSArray与字符串的两个方法: 连接 与 分隔
     1). 将数组中的元素连接起来组成1个新的字符串.
         - (NSString *)componentsJoinedByString:(NSString *)separator
          参数: 连接符.  可以使用空连接
 
         NSArray *arr = @[@"a",@"b",@"c",@"d"];
         NSString *str = [arr componentsJoinedByString:@"#"];
         NSLog(@"%@", str);    //a#b#c#d
 
 
     2). 将字符串以指定的分隔符分成1个数组. 每1部分就是数组的1个元素.
     - (NSArray<NSString *> *)componentsSeparatedByString:(NSString *)separator;
        
        NSString *str = @"a,b,c,d";
        NSArray *arr = [str componentsSeparatedByString:@","];
        for(NSString *item in arr){
            NSLog(@"%@", item);   //abcd
        }

 
 9. NSMutableArray 是 NSArray的子类
    9.1 NSMutableArray相对于父类做的扩展: NSMutableArray数组的元素可以动态的新增和删掉.
        NSArray数组一旦创建, 其元素的个数就固定, 无法新增删除.
        NSMutableArray数组.元素可以新增,删除. 其他用法和父类一样.

    9.2 NSMutableArray数组的
        创建方式一:
        NSMutableArray *arr1 = [NSMutableArray new];
        NSMutableArray *arr2 = [[NSMutableArray alloc] init];
        NSMutableArray *arr3 = [NSMutableArray array];
        数组的元素是0, 仍然是有意义的, 可以动态的新增和删除元素.
 
        创建方式二:
        NSMutableArray *arr4 = [NSMutableArray arrayWithObjects:@"a",@"b",@"c", d];

        注意:不可以这样写
        NSMutableArray *arr5 = @[@"a",@"b",@"c"];
            @[@"a",@"b",@"c"];   //这是1个NSArray对象.
            arr5是1个子类指针. 子类指针指向父类对象的就有可能会出问题.

    9.3 注意:
        1. 任意的指针其实可以指向任意的对象.  编译不会报错 只会给1个警告.
        2. 虽然语法上可以乱指.但是你千万别乱指.因为运行的适合可能出错.
        当我们调用指针类型特有的方法的时候.
 
    9.4 常规操作: NSArray 的方法 子类都可以使用
        1)  新增元素.
            - (void)addObject:(ObjectType)anObject; 将传入的参数作为数组的元素添加进去.
            
            NSMutableArray *arr = [NSMutableArray new];
            [arr addObject:@"aa"];
            NSLog(@"%@ count=%lu", arr[0], arr.count);  //aa count=1

        2)  将另外1个数组中的每1个元素添加到可变数组中.
            - (void)addObjectsFromArray:(NSArray<ObjectType> *)otherArray;
            
            NSMutableArray *arr = [NSMutableArray new];
            [arr addObject:@"aa"];
            NSArray *temp = @[@"bb", @"cc", @"cc"];
            [arr addObjectsFromArray:temp];
            NSLog(@"%@ count=%lu", arr[1], arr.count);  //bb count=4

        3) 在可变数组中指定的下标出插入1个元素.
            - (void)insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;

            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"cc", nil];
            [arr insertObject:@"bb" atIndex:1];
            NSLog(@"%@ count=%lu", arr[1], arr.count);  //bb count=3

        4) 删除可变数组中指定下标的元素.
            - (void)removeObjectAtIndex:(NSUInteger)index;
            
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb", @"cc", nil];
            [arr removeObjectAtIndex:1];
            NSLog(@"%@ count=%lu", arr[1], arr.count);  //cc count=2

        5) 删除可变数组中所有的指定的元素.
            - (void)removeObject:(ObjectType)anObject;
            
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb", @"cc", nil];
            [arr removeObject:@"bb"];
            NSLog(@"%@ count=%lu", arr[1], arr.count);  //cc count=2

        6) 删除指定范围中的所有指定元素.
            - (void)removeObject:(ObjectType)anObject inRange:(NSRange)range;
            
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb",@"bb", @"cc", nil];
            [arr removeObject:@"bb" inRange:NSMakeRange(0, 4)];  //表示在数组0 到4长度(arr.count-1)范围中找,
            NSLog(@"%ld", arr.count);  //count=2

        7) 删除最后1个元素
            - (void)removeLastObject;
            
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb", @"cc", nil];
            //[arr removeObjectAtIndex:arr.count-1];   //方式1
            [arr removeLastObject];                    //方式2
            NSLog(@"count=%lu", arr.count);  // count=2

        8) 删除所有的元素.
            - (void)removeAllObjects;
            
            NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb", @"cc", nil];
            [arr removeAllObjects];
            NSLog(@"count=%lu", arr.count);  // count=0
 
 
10. NSNumber
    1. 无论是NSArray还是NSMutbaleArray里面都只能存储OC对象.
        基本数据类型是无法存储的.

    2. 如何将基本数据类型的数据存储到NSArray数组中. 自定义包装类来包装基本数据类型.
       传统方式: 定义1个类,这个类的对象的作用是用来存储1个int类型的数据. 再将这个对象存储到NSArray数组中.
   
    3. 这个类的对象的作用就是用来包装基本数据类型的.
        将基本数据类型存储到NSArray数组中的步骤.
        第一步: 先讲基本数据类型包装到NSNumber对象中.
        第二步: 再降NSNumber对象存储到NSArray数组中.
        
       //例子: 类型自己指定:numberWithInt/Float/...
         NSNumber *number1 = [NSNumber numberWithFloat:10.1f];
         NSNumber *number2 = [NSNumber numberWithFloat:10.2f];
         NSNumber *number3 = [NSNumber numberWithFloat:10.3f];
         //一般方式:
         //NSArray *arr = @[number1,number2,number3];
         
         //简写方式:
         NSArray *arr = @[@10, @20, @30];
         
         for(NSNumber *num in arr){
             NSLog(@"%f",num.floatValue);  //包装的什么类型,就按什么类型取
         }
 
    4. 创建NSNumber对象的简写方式:
        @10;  代表是1个NSNumber对象. 这个对象中包装的是整形的10:
        [NSNumber numberWithInt:10];

        包装注意: 如果后面的数据是1个变量 那么这个变量就必须要使用小括弧括起来.
            一般包装: @(10);
            变量包装: int num = 10;
                    @(num)

 */


#import <Foundation/Foundation.h>
@interface Person : NSObject
@end
@implementation Person
@end

#define LogBOOL(var) NSLog(@"%@",var==YES?@"YES":@"NO")

int main(int argc, const char * argv[]) {
    
    //字符串的恒定性
   NSString *str1 = [NSString new];
   NSLog(@"str1=%p", str1);         //0x7fff7ab82d20
   str1 = nil;
   NSString *str2 = [NSString new];
   NSLog(@"str2=%p", str2);         //0x7fff7ab82d20  是一样的

   BOOL res = [str1 isEqualToString:str2];
   LogBOOL(res);
    
    //将C语言的字符串转换为OC字符串对象
   char *name = "jack";
   NSString *ocName = [NSString stringWithUTF8String:name];
   NSLog(@"%@", ocName);
    
    //将OC字符串对象转换为C语言的字符串
   NSString *str = @"tom";
   const char *ch = [str UTF8String];  //str.UTF8String;
   NSLog(@"%s", ch);
    
    //写入文件
   NSString *str = @"hello world";
   NSError *err;
   BOOL res = [str writeToFile:@"/Users/damys/Desktop/test.txt" atomically:NO encoding:NSUTF8StringEncoding error:&err];
   //LogBOOL(res);
   
   if(err != nil){
       NSLog(@"写入失败:%@", err.localizedDescription);  //只打印出错误的简要信息
   }
    
    //读文件-----
   NSError *err;
   NSString *content = [NSString stringWithContentsOfFile:@"/Users/damys/Desktop/test.txt" encoding:NSUTF8StringEncoding error:&err];
   
   if(err == nil){
       NSLog(@"%@", content);   //成功就读取文件内容
   }
    
    
   //3. NSURL读写资源.
   NSURL *url1 = [NSURL URLWithString:@"http://www.baidu.com"];
   NSURL *url2 = [NSURL URLWithString:@"ftp://server.baidu.com/ccc.txt"];
   NSURL *url3 = [NSURL URLWithString:@"file:///Users/damys/Desktop/test.txt"];
   
   NSString *str = [NSString stringWithContentsOfURL:url1 encoding:NSUTF8StringEncoding error:nil];
   NSLog(@"%@",str);
    
   //写入文件
   NSString *data = @"dddd";   //可以写普通string, 也可以写获取到的网页内容
   BOOL res = [str writeToURL:url3 atomically:NO encoding:NSUTF8StringEncoding error:nil];
   LogBOOL(res);
   
    
    //字符串比较:-----
   NSString *str1 = @"aaa";
   NSString *str2 = @"AAA";

   NSComparisonResult res = [str1 compare:str2];
   switch (res){
       case NSOrderedAscending:
           NSLog(@"小");   //说明str1比str2小.
           break;
       case NSOrderedSame:
           NSLog(@"一样");  //说明一样大
           break;
       case NSOrderedDescending:
           NSLog(@"大");   //str1 > str2
           break;
   }
    
        //增加参数类型: 为忽略大小写的比法,同给1是一样
        int res =  [str1 compare:str2 options:NSCaseInsensitiveSearch];
    
        //增加参数类型: 字母加数字比:输出大
       NSString *img1 = @"a003.jpg";
       NSString *img2 = @"a002.jpg";
       int res  = [img1 compare:img2 options:NSNumericSearch];
    
        //返回enun, 也就是int
        int res = [str1 compare:str2];
       switch (res){
           case -1:
               NSLog(@"小");   //str1 < str2.
               break;
           case 0:
               NSLog(@"一样");  //说明一样大
               break;
           case 1:
               NSLog(@"大");    //str1 > str2
               break;
       }
    
    //判断字符串是否以指定的字符串开头
   NSString *str = @"http://www.baidu.com";
   BOOL res = [str hasPrefix:@"https"];    //NO
   LogBOOL(res);
    
    
    //判断字符串是否以指定的字符串结尾
   NSString *img = @"abc.jpg";
   BOOL res = [img hasSuffix:@".jpg"];      //YES
   LogBOOL(res);
    
    //在主串中搜索子串
   NSString *str = @"aabb ccdd";
   NSRange range = [str rangeOfString:@"cc"];
   NSLog(@"下标为:%lu", range.location);    //5
   NSLog(@"返回的长度为:%lu", range.length);      //2
    
    //NSRange结构体
   NSRange ran = NSMakeRange(3, 7);
   NSLog(@"ran.loc = %lu ran.len = %lu", ran.location, ran.length);  //ran.loc = 3 ran.len = 7
   NSLog(@"%@", NSStringFromRange(ran));   //{3, 7}
    
    //字符串的截取
   NSString *name = @"aabbccdd";
   NSLog(@"截取后的字符串为:%@", [name substringFromIndex:3]);  //bccdd
   NSLog(@"截取后的字符串为:%@", [name substringToIndex:3]);    //aab
   
   //要传一个范围
   NSRange ran = NSMakeRange(2, 3);
   NSLog(@"截取后的字符串为:%@", [name substringWithRange:ran]); //bbc
    
    //字符串的替换
   NSString *name = @"aabb";
   name = [name stringByReplacingOccurrencesOfString:@"b" withString:@"f"];
   NSLog(@"替换后的字符串为:%@", name);  //aaff
   
    
    //字符串数据转换为其他的类型
   NSString *num = @"100";
   NSLog(@"num=%d", num.intValue + 1);        //101
   NSLog(@"num=%.2lf", num.doubleValue + 1);  //101.00
   NSLog(@"num=%.2f", num.floatValue + 1);    //101.00
    
    //去掉字符串前后的空格
   NSString *name = @"  aa bb ";
   name = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   NSLog(@"name %@", name);   //name aa bb
    
    //大小写转
   NSString *str = @"AaBbCc";
   str = [str uppercaseString];    //AABBCC
   str = [str lowercaseString];    //aabbcc
   NSLog(@"转换后的字符串为:%@", str);
    
    
    //5. NSMutableString  字符串的可变性
   NSMutableString *str = [NSMutableString string];
   [str appendString:@"aa"];
   [str appendString:@"bb"];
   [str appendString:@"cc"];
   NSLog(@"str = %@", str);   //aabbcc
   
   //拼接的方式追加
   int age = 10;
   [str appendFormat:@" %d岁了",age];
   NSLog(@"str = %@", str);   //aabbcc 10岁了
    
    
    
    //6. NSArray
   NSArray *arr1 = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", nil];
   NSLog(@"数据为:%@", arr1);   //a,b,c,d
   
   NSArray *arr2 = @[@"a", @"b", @"c", @"d"];
   //1. 取出全部值
   NSLog(@"数据为:%@", arr2);   //a,b,c,d
   //2. 取出指定值-传统
   NSLog(@"%@", arr2[0]);  //a
   NSLog(@"%@", arr2[1]);  //b
   NSLog(@"%@", arr2[2]);  //c
   NSLog(@"%@", arr2[3]);  //d
   //3. 取出指定值-对象方式
   NSString *str = [arr2 objectAtIndex:1];
   NSLog(@"%@", str);  //b
    
    //得到NSArray数组中的元素的个数
   NSArray *arr3 = @[@"a", @"b", @"c", @"d"];
   NSLog(@"length: %lu", [arr3 count]);  //4
    
    
    //判断NSArray数组中是否包含指定的元素
   NSArray *arr4 = @[@"a", @"b", @"c", @"d"];
   BOOL res = [arr4 containsObject:@"c"];
   NSLog(@"res:%d", res);   //1
    
    //取到NSArray数组中的第1个元素.
   NSLog(@"第1个元素值:%@", [arr4 firstObject]); //a
   NSLog(@"第1个元素值:%@", arr4.firstObject );  //a
    
    //取到NSArray数组中的最后一个元素.
   NSLog(@"最后一个元素值:%@", [arr4 lastObject]); //d
   NSLog(@"最后一个元素值:%@", arr4.lastObject );  //d
    
    //查找指定的元素在NSArray数组中第一次出现的下标
   NSArray *arr5 = @[@"a", @"b", @"c", @"d"];
   NSUInteger index = [arr5 indexOfObject:@"dd"];
   if(index == NSNotFound){  // NSUInteger 的最大值
       NSLog(@"没有找到");
   }else{
       NSLog(@"找到了,下标为:%lu", index);  //3
   }
    
    //数组的遍历
   NSArray *arr = @[@"a",@"b",@"c",@"d"];
   for(NSString *str in arr){
       NSLog(@"%@", str);   //abcd
   }
    
    //不同类型遍历:使用id 类型
   Person *p1 = [Person new];
   Person *p2 = [Person new];
   
   NSArray *arr = @[p1, p2, @"a", @"b", @"c", @"d"];
   for (id item in arr) {
       NSLog(@"%@", item);
   }
    /*
     <Person: 0x100104960>
     <Person: 0x100103920>
     abcd
     */
    
    
    //使用block遍历.
   NSArray *arr = @[@"a",@"b",@"c",@"d"];
   //使用技巧: 输入名后,直接回车
   [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       //NSLog(@"%@", obj);    //abcd
       NSLog(@"%@ index = %lu", obj, idx);   //abcd 与各下标
       
       //如果想停止遍历:stop 改为YES,  下面表示只打印第1,2条
       if(idx == 1){
           *stop = YES;
       }
       
   }];
    
    
    //数组中的元素连接起来组成1个新的字符串
   NSArray *arr = @[@"a",@"b",@"c",@"d"];
   NSString *str = [arr componentsJoinedByString:@"#"];
   NSLog(@"%@", str);    //a#b#c#d
    
    
    //将字符串以指定的分隔符分成1个数组
   NSString *str = @"a,b,c,d";
   NSArray *arr = [str componentsSeparatedByString:@","];
   for(NSString *item in arr){
       NSLog(@"%@", item);   //abcd
   }
    
    
    //NSMutableArray
    //1. 新增元素.
   NSMutableArray *arr = [NSMutableArray new];
   [arr addObject:@"aa"];
   NSLog(@"%@ count=%lu", arr[0], arr.count);  //aa count=1
    
    //2. 将另外1个数组中的每1个元素添加到可变数组中.
   NSMutableArray *arr = [NSMutableArray new];
   [arr addObject:@"aa"];
   NSArray *temp = @[@"bb", @"cc", @"cc"];
   [arr addObjectsFromArray:temp];
   NSLog(@"%@ count=%lu", arr[1], arr.count);  //bb count=4
    
    //3. 在可变数组中指定的下标出插入1个元素
   NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"cc", nil];
   [arr insertObject:@"bb" atIndex:1];
   NSLog(@"%@ count=%lu", arr[1], arr.count);  //bb count=3
    
    
    //4. 删除可变数组中指定下标的元素
   NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb", @"cc", nil];
   [arr removeObjectAtIndex:1];
   NSLog(@"%@ count=%lu", arr[1], arr.count);  //cc count=2
    
    
    //5. 除可变数组中所有的指定的元素
   NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb", @"cc", nil];
   [arr removeObject:@"bb"];
   NSLog(@"%@ count=%lu", arr[1], arr.count);  //cc count=2
    
    
    //6. 删除指定范围中的所有指定元素
   NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb",@"bb", @"cc", nil];
   [arr removeObject:@"bb" inRange:NSMakeRange(0, 4)];  //表示在数组0 到4长度(arr.count-1)范围中找,
   NSLog(@"count=%ld", arr.count);  //count=2
   
    
    //7. 删除最后1个元素
   NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb", @"cc", nil];
   //[arr removeObjectAtIndex:arr.count-1];   //方式1
   [arr removeLastObject];                    //方式2
   NSLog(@"count=%lu", arr.count);  // count=2

    
    //8. 删除所有的元素
   NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"aa",@"bb", @"cc", nil];
   [arr removeAllObjects];
   NSLog(@"count=%lu", arr.count);  // count=0
    
    
    //NSNumber
    NSNumber *number1 = [NSNumber numberWithFloat:10.1f];
    NSNumber *number2 = [NSNumber numberWithFloat:10.2f];
    NSNumber *number3 = [NSNumber numberWithFloat:10.3f];
    
    //一般方式:
    //NSArray *arr = @[number1,number2,number3];
    
    //简写方式:
    NSArray *arr = @[@10, @20, @30];
    
    for(NSNumber *num in arr){
        NSLog(@"%f",num.floatValue);  //包装的什么类型,就按什么类型取
    }
    
    
    return 0;
}

















