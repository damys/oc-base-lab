/*
数据持久化  将数组写入文件, 从文件中读取数组
     1. 将数组的信息(数组的元素的值)保存起来.保存在磁盘上. 数据持久化.
     2. plist文件.属性列表文件. 这个文件可以保存数组. 把数组中的元素保存在这个文件中.
     3. 原理:
        1). 将数组写入文件:
         - (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
 
             NSArray *arr = @[@"aa", @"bb", @"cc"];
             BOOL res = [arr writeToFile:@"/Users/damys/Desktop/temp.plist" atomically:NO];
             LogBOOL(res);
     
        2). 从文件中读取数组
         + (nullable NSArray<ObjectType> *)arrayWithContentsOfFile:(NSString *)path;
 
            NSArray *arr = [NSArray arrayWithContentsOfFile:@"/Users/damys/Desktop/temp.plist"];
            for(NSString *item in arr){
                NSLog(@"%@", item);
            }
 
 
 1. NSDictionary
    数组存储方式: 索引数组, 关联数组
    1.1 NSArray与 NSMutableArray 是OC中的数组.
         存储数据的特点:  每1个元素紧密相连.并且每1个元素中都是直接存储的值.
         缺点: 数组元素的下标不固定. 都有可能会发生变化. 无法通过下标来唯一确定数组中的元素.
         希望: 有一种存储数据的方式. 存储到数组中可以快速唯一的确定数组的元素.
         
         这种存储数据的方式就 叫做键值对的存储方式.  Key-Value
         
    1.2 NSDictionary 与 NSMutableDictionary
         它们是数组. 它们就是以键值对的形式存储数据的.
         往这个数组中存储数据的同时. 必须要指定这个数据的别名才可以.
         要找到存储在这个数组中的数据通过别名来找, 而不是通过下标.
 
    1.3 NSDictionary 字典数组
         1). 存储数据的原理.
             a. 以键值对的形式存储数据.
             b. 字典数组一旦创建,其中的元素就无法动态的新增和删除.
             c. 键: 只能是遵守了NSCoping协议的对象. 而NSString就是遵守了这个协议.
             e. 值: 只能是OC对象.
         
         2). 创建字典数组:第一种方式: 这种方式创建出来的字典数组中没有任何元素.所以没有意义.
             NSDictionary *dict1 = [NSDictionary new];
             NSDictionary *dict2 = [[NSDictionary alloc] init];
             NSDictionary *dict3 = [NSDictionary dictionary];
         
         3). 一般创建方式:第二种方式
             + (instancetype)dictionaryWithObjectsAndKeys:(id)firstObject, ...
             将字典数组的值键, 挨个的写在后面初始化.
             NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"jack",@"name", nil];
             NSLog(@"%@", dict);   //{name = jack}
 
         4). 简要创建方式:第三种方式
             NSDictionary *dict = @{键1:值1,键2:值2,键3:值3,........};
             NSDictionary *dict = @{@"name":@"jack", @"age":@"20"};
             NSLog(@"%@", dict);    //{age=20, name=jack}   按键的ASCII码排序
             NSLog(@"%@", dict[@"name"]);  //jack
 
    1.4 使用字典数组
         1) 通过别名去取对应值
             1. 使用中括弧的方式.
             字典数组名[键]; 这样就可以去到字典数组中这个键对应的值.
             NSLog(@"%@",dict[@"name"]); 取出dict字典数组中@"name"这个键对应的值.
             
             2. 调用字典数组对象的方法也可以取出键对应的值.
             - (nullable ObjectType)objectForKey:(KeyType)aKey;
             NSString *s1 = [dict objectForKey:@"age1"];
             如果给定的key在数组中不存在,取到的值是nil, 不会报错.
         
         2) 取到字典数组的键值对的个数.
         @property (readonly) NSUInteger count;
         
         3) 往字典数组中存储键值对的时候 键不允许重复. 如果键重复: 后加的无效
 
    1.5 遍历字典数组
        1). 字典数组中的数据无法使用下标去取, 就不能用for循环遍历下标
        2). 使用for in循环. 遍历出来的是字典数组中所有的键. 再通过键取出对应的值.
            NSDictionary *dict = @{
                @"name":@"rose",
                @"age":@"18"
            };
            //遍历:
            for(id item in dict){
                NSLog(@"%@ = %@",item,dict[item]); //name=rose, age = 18
            }

        3). 使用block遍历.
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop){
            NSLog(@"%@ = %@",key, obj);
        }];
 
    1.6 字典数组存储数据的原理.
        1). 存值
            1. 并不是按照顺序挨个挨个的存储的.
            2. 存储键值对的时候,会根据键和数组的长度做1个哈希算法.算出1个下标. 将这个键值对存储在该下标处.

        2). 取值:
            也是根据键做1个哈希算法.就可以算出这个键值对存储的下标, 然后直接找到这个下标的数据取出就可以了.

        3). 字典数组与NSArray对比
            1. NSArray数组的元素 挨个挨个按照顺序来存储的.
               字典数组中不是挨个挨个的存储的. 存储的下标是算出来的.

            2. 存的效率: 肯定是NSArray要高一些.
                取得的时候: 如果全部取出来. NSArray块一些.
                取值的时候: 只会取数组中指定的几个元素. 字典数组取值更快一些.
                NSArray *arr = @[p1,p2,p3,p4];
                NSDictionary *dict = @{
                    p1.name:p1,
                    p2.name:p2,
                    p3.name:p3,
                    p4.name:p4
                };
                dict[@"小明2"];

        4). 什么时候是有NSArray? 什么时候使用字典数组?
            存储进去之后,一旦要取值.就是全部取出. NSArray
            存储进去之后.取值只会取指定的几个元素. 字典数组.
   
 
2. NSMutableDictionary
    2.1 介绍与创建:
        1). 是NSDictionary的子类.所以NSMutableDictionary也是1个字典数组,也是以键值对的形式存储数据的.
        2). 重点:NSMutableDictionary在父类基础之上做的扩张: 存储在其中的元素可以动态的新增和删除.

        3). 创建可变字典数组.
            //方式1: 长度为0 但是有意义 因为可以动态的新增和删除.
            NSMutableDictionary *dict1 = [NSMutableDictionary new];
            NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] init];
            NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
            
           //方式2: 在创建可变字典数组的同时初始化键值对
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"jack",@"name", nil];
 
        4). 注意:  NSMutableDictionary *dict = @{}; 这样是不行的.

    2.2 新增键值对.
        - (void)setObject:(ObjectType)anObject forKey:(KeyType <NSCopying>)aKey;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"jack",@"name", nil];
        [dict setObject:@"20" forKey:@"age"];
        NSLog(@"%@", dict);               //{age=20, name=jack}
        注意: 如果键重复.后添加的就会替换原有的.

    2.3 删除:
        - (void)removeObjectForKey:(KeyType)aKey; 删除指定的键值对.
        - (void)removeAllObjects; 删除所有的键值对.
 
         NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"jack",@"name", @"20", @"age", nil];
        [dict removeObjectForKey:@"age"]; //删除指定的键值对.
        [dict removeAllObjects];          //删除所有的键值对
        NSLog(@"%@", dict);

    2.4 将字典数组的信息持久化
        1) 将字典数组的信息保存到plist文件中.
        - (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
 
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"jack",@"name",@"20",@"age", nil];
        BOOL res = [dict writeToFile:@"/Users/damys/Desktop/dict.plist" atomically:NO];
        LogBOOL(res);
 
        2) 从plist文件中还原回字典. 从文件中读取数组
        + (nullable NSDictionary<KeyType, ObjectType> *)dictionaryWithContentsOfFile:(NSString *)path;

         NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/Users/damys/Desktop/dict.plist"];
         NSLog(@"%@", dict);   //{age=20, name=jack}
 

3. 集合内存管理
    1) 集合: NSArray集合、NSDictionary字典集合
    2) 在MRC的模式下, 将1个对象存储到集合中, 会不会影响对象的引用计数器.
        将对象存储到集合之中, 会为这个对象的引用计数器+1
        当集合销毁的时候, 就会像存储在集合中的所有的对象发送1条release消息.
         Person *p1 = [Person new];
         NSLog(@"%lu",p1.retainCount);   //1
         NSArray *arr = @[p1];
         NSLog(@"%lu",p1.retainCount);   //2

    3) 使用@[]或者@{}创建的集合已经是被autorelease过了.
        直接调用和类同名的类方法创建的对象, 也是被autorelease过了.
         @autoreleasepool{
             NSArray *arr1 = [NSArray arrayWithObjects:@"jack",@"rose",@"lili",nil];
             NSArray *arr2 = @[@"jack",@"rose"];
         }

    4) 在ARC的模式下. 集合的元素是1个强类型的指针.
            Person *p1 = [Person new];
            NSArray *arr = @[p1];

 
 4. 文件管理员. NSFileManger
    4.1 作用: 用来操作磁盘上的文件 文件夹  对他们进行创建、删除、复制 拷贝 移动.....
    4.2 NSFileManager是1个类.  这个类的对象是以单例模式创建的.
        调用这个类的类方法,defaultManager 就可以得到这个类的单例对象
        NSFileManager *fileManager = [NSFileManager defaultManager];

    4.3 判断方法.
        先创建对象: NSFileManager *manager = [NSFileManager defaultManager];
        
        1). 判断指定的文件或者文件夹在磁盘上是否真实的存在
        - (BOOL)fileExistsAtPath:(NSString *)path;
            NSString *path = @"/Users/damys/Desktop/dict.plist";
            BOOL res = [manager fileExistsAtPath:path];
            LogBOOL(res);
 
        2). 判断指定的路径是否真实的存储在我们的磁盘之上,并且判断这个路径是1个文件夹路径还是1个文件路径.
        - (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory;
        返回值:代表这个路径是否真实存在.
        参数指针: 代表这个路径是否是1个文件夹路径
            NSString *path = @"/Users/damys/Desktop/temp";
            BOOL flag = NO;
            BOOL res = [manager fileExistsAtPath:path isDirectory:&flag];
            if(res == YES){
                NSLog(@"给的路径存在");

                if(flag == YES){
                    NSLog(@"给的路径是一个文件夹");
                }else{
                    NSLog(@"给的路径是一个文件");
            }
            }else{
                NSLog(@"给的路径不存在");
            }

        3). 判断指定的文件夹或者文件是否可以读取.  --存在--可读--可写
        - (BOOL)isReadableFileAtPath:(NSString *)path;
            BOOL res = [manager isReadableFileAtPath:@"/Users/damys/Desktop/dict.plist"];
            LogBOOL(res);

        4). 判断指定的文件夹或者文件是否可以写入.
        - (BOOL)isWritableFileAtPath:(NSString *)path;
            BOOL res = [manager isWritableFileAtPath:@"/Users/damys/Desktop/temp"];
            LogBOOL(res);

        5). 判断指定的文件夹或者文件是否可以删除.
        - (BOOL)isDeletableFileAtPath:(NSString *)path
            BOOL res = [manager isDeletableFileAtPath:@"/Users/damys/Desktop/temp"];
            LogBOOL(res);
 
    4.4 获取信息.
        先创建对象: NSFileManager *manager = [NSFileManager defaultManager];

        1). 获取指定文件或者文件夹的属性信息.
            - (NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error
            返回的是1个字典,如果要拿到特定的信息 通过key
            NSDictionary *dict = [manager attributesOfItemAtPath:@"/Users/damys/Desktop/dict.plist" error:nil];

            NSLog(@"%@", dict);
            NSLog(@"%@", dict[NSFileModificationDate]);   //取单个
            //输出:
            2016-08-07 13:59:39.330 09 Fundation 2[1038:41921] {
                NSFileCreationDate = "2016-08-07 05:02:35 +0000";
                NSFileExtensionHidden = 0;
                NSFileGroupOwnerAccountID = 20;
                NSFileGroupOwnerAccountName = staff;
                NSFileHFSCreatorCode = 0;
                NSFileHFSTypeCode = 0;
                NSFileModificationDate = "2016-08-07 05:02:35 +0000";
                NSFileOwnerAccountID = 501;
                NSFileOwnerAccountName = Damys;
                NSFilePosixPermissions = 420;
                NSFileReferenceCount = 1;
                NSFileSize = 265;
                NSFileSystemFileNumber = 6389600;
                NSFileSystemNumber = 16777220;
                NSFileType = NSFileTypeRegular;
            }


            2).获取指定目录下的所有的文件和目录. 是拿到指定目录下的所有的文件和目录 所有的后代目录和文件.
            子目录的子目录的子目录 所有的都可以拿到.
            - (NSArray *)subpathsAtPath:(NSString *)path;
                NSArray *arr = [manager subpathsAtPath:@"/Users/damys/Desktop/temp"];
                for(NSString *str in arr){
                    NSLog(@"%@", str);
                }
            //输出:
            .DS_Store,
            abc,
            abc/cc.txt,
            test.txt

            3).获取指定目录下的所有的子目录和文件 不保护孙子辈.
            - (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error
                NSArray *arr = [manager contentsOfDirectoryAtPath:@"/Users/damys/Desktop/temp" error:nil];
                for(NSString *str in arr){
                    NSLog(@"%@", str);
                }
            //输出:
            .DS_Store,
            abc,
            test.txt

    4.5 文件/目录的创建
        先创建对象: NSFileManager *manager = [NSFileManager defaultManager];
        1). 在指定的目录创建文件.
            - (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr
            第1个参数: 要创建的文件的路径.
            第2个参数: 这个文件的内容.  要传递这个文件的二进制格式. 使用NSData对象来封装.
                NSData: 将别的格式的数据转换为二进制数据. 将字符串转换为NSData二进制的方式.调用字符串对象的
                - (NSData *)dataUsingEncoding:(NSStringEncoding)encoding
                编码参数: NSUTF8StringEncoding

                如果想创建1个空文件 第2个参数就给nil
            第3个参数: 指定创建的文件的属性.如果想要使用系统的默认值使用nil
                NSString *str = @"hello world";
                NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
                BOOL res = [manager createFileAtPath:@"/Users/damys/Desktop/temp/aa.txt" contents:data attributes:nil];
                LogBOOL(res);
 
        2). 在指定的目录创建文件夹.
            - (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error
            第1个参数: 路径.
            第2个参数: YES,做一路创建. 如果是NO就不会做一路创建.
            第3个参数: 指定属性 nil为系统默认属性.
            第4个参数: 指定属性 nil为系统默认属性.
            BOOL res = [manager createDirectoryAtPath:@"/Users/damys/Desktop/temp/aa" withIntermediateDirectories:YES attributes:nil error:nil];
             LogBOOL(res);
 
        3).拷贝文件. 也可改名子,移动时指定就可以了
             - (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
             BOOL res = [manager copyItemAtPath:@"/Users/damys/Desktop/test.txt" toPath:@"/Users/damys/Desktop/temp/test-temp.txt" error:nil];
             LogBOOL(res);
 
        4).移动文件 剪切 文件的重命名. 重名的原理: 将文件移动到原来的目录并改名.
             - (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
             BOOL res = [manager moveItemAtPath:@"/Users/damys/Desktop/test.txt" toPath:@"/Users/damys/Desktop/temp/temp-move.txt" error:nil];
             LogBOOL(res);
 
        5).删除文件.
             - (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error
             BOOL res = [manager removeItemAtPath:@"/Users/damys/Desktop/temp/temp-move.txt" error:nil];
             LogBOOL(res);


5. 常用结构体
    5.1 定义1个变量来保存按钮在iOS界面上得位置.
        1) 传统方式: 我们定义1个结构体来表示控件在界面上得坐标.
            typedef struct{
                int x;
                int y;
            }CZPoint;
            CZPoint p1 = {20,30};
     
        2) 在Foundation框架中: 已经定义了1个结构体CGPoint.
            struct CGPoint {
                CGFloat x;   //CGFloat类型的实际上就是1个double类型的.
                CGFloat y;
            };
            系统自定义结构体: typedef struct CGPoint CGPoint;
            系统自定义结构体: typedef CGPoint NSPoint;
            CGPoint与NSPoint都是同1个结构体,只不过定义两个名字.
            这个结构体一般情况下是用来表示坐标的. 用来表示控件在界面上得位置.
 
 
        3) 声明CGPoint变量并初始化的方式:
            第1种方式: CGPoint p1;
                      p1.x = 20;
                      p1.y = 30;

            第2种方式: CGPoint p1 = {20,30};
            第3种方式: CGPoint p1 = {.x = 20, .y = 30};
            第4种方式: (推荐)Foundation框架中提供的函数来快速的创建1个CGPoint变量.
                a. CGPointMake(x,y);
                   CGPoint p1 =  CGPointMake(20, 30);

                b. NSMakePoint(x,y);
                   NSPoint p2 =  NSMakePoint(20, 30);
 
             CGPoint p = CGPointMake(10, 20);
             NSLog(@"p.x=%lf, p.y=%lf", p.x, p.y);  //p.x=10.000000, p.y=20.000000
 
 
    5.2 声明1个变量来保存某个控件的大小.
        1) 传统方式: 1个控件的大小,无非就是两个数据. 宽度、高度.
            typedef struct{
                double width;
                double height;
            }CZSize;
            CZSize size = {50,20};

        2) Foundation框架中已经定义好了1个结构体叫做CGSize;
            struct CGSize {
                CGFloat width;
                CGFloat height;
            };
            系统自定义结构体: typedef struct CGSize CGSize;
            系统自定义结构体: typedef CGSize NSSize;
            NSSize和CGSize是同1个结构体,只不过定义了两个名称.
            CGSize结构体一般情况下用来表示控件的大小.
 
        3) CGSize声明并初始化的方式:
            第1种方式: CGSize size;
                      size.width = 100;
                      size.height = 30;
 
            第2种方式: CGSize size = {100,30};
            第3种方式: CGSize size = {.width = 100, .height = 30};
            第4种方式: (推荐)Foundation框架中提供了函数用来快速的得到1个CGSize结构体变量.
                        a. CGSizeMake(width,height);
                            CGSize size0 =  CGSizeMake(100, 30);

                        b. NSMakeSize(w,h);
                            CGSize size1 =  NSMakeSize(100, 30);
 
             CGSize s = CGSizeMake(10, 20);
             NSLog(@"s.w=%lf, s.h=%lf", s.width, s.height);  //p.x=10.000000, p.y=20.000000
 
 
    5.3. CGRect和NSRect  位置和大小
        1) 这是定义在Foundation框架中的1个结构体.
            struct CGRect {
                CGPoint origin;
                CGSize size;
            };
            系统自定义结构体: typedef struct CGRect CGRect;
            系统自定义结构体: typedef CGRect NSRect;
            NSRect和CGRect是一样的.
            所以,这个结构体变量一般情况下存储1个控件的位置和大小.

        2) CGRect的声明和初始化
            第一种方式: CGRect rect;
                rect.origin.x = 20;
                rect.origin.y = 40;
                rect.size.width = 100;
                rect.size.height = 30;

            第二种方式: CGRect rect;
                当结构体作为另外1个结构体或者对象的1个属性的时候,不能直接{}赋值.
                //rect.origin = {10,20};       //这是一个数组还是结构体, 要告诉系统
                rect.origin = (CGPoint){10,20};
                rect.size = (CGSize){100,30};

            第三种方式: 也提供了函数来快速的创建CGRect变量.
                CGRect rect1 = CGRectMake(10, 20, 100, 30);
                CGRect rect2 = NSMakeRect(10, 20, 100, 30);
 
        3) 取值:
                CGRect rect = CGRectMake(10, 20, 100, 30);
                NSLog(@"height=%lf",rect.size.height);  //30.00000

        使用的时候. CGSize NSSize  建议使用CG

 
 6. NSValue
    1. 我们之前学习的结构体.
        NSRange
        CGPoint
        CGSize
        CGRect
        这些都是结构体,它们的变量是无法存储到集合之中.

    2. 解决方案: 先将这写结构体变量存储到OC对象中,再将OC对象存储到集合之中.
    3. NSValue 类的对象就是用来包装结构体变量的.
 
    //CGPoint 方式
        CGPoint p1 = CGPointMake(10, 20);
        CGPoint p2 = CGPointMake(30, 40);

        //NSArray *arr = @[p1,p2];  //不能这样存,p1, p2 不是一个对象, 需要转换

        NSValue *v1 = [NSValue valueWithPoint:p1];
        NSValue *v2 = [NSValue valueWithPoint:p2];

        NSArray *arr1 = @[v1, v2];

        for(NSValue *v1 in arr1){
            NSLog(@"%@", NSStringFromPoint(v1.pointValue));  // {10,20} {30},40
        }

    //CGSize 方式
        CGSize s1 = CGSizeMake(50, 60);
        CGSize s2 = CGSizeMake(70, 80);
        NSValue *v3 = [NSValue valueWithSize:s1];
        NSValue *v4 = [NSValue valueWithSize:s2];

        NSArray *arr2 = @[v3, v4];

        for(NSValue *v2 in arr2){
            NSLog(@"%@", NSStringFromSize(v2.sizeValue)); //{50,60} {70,80}
        }
 
 7. NSDate
    7.1 NSDate 时间处理.
        1). 可以得到当前时间. 创建1个NSDate对象就可以了,将这个对象输出,就是当前时间
            得到的是当前系统的格林威治时间. 0时区的时间. 东8区.
            NSDate *date = [NSDate date];
            NSLog(@"%@",date);

        2). 格式化输出日期. 指定日期输出的格式
            默认的格式 年-月-日 时:分:秒 +时区.
             NSDate *date = [NSDate new];
             NSLog(@"%@", date);    //2016-08-07 08:31:52 +0000    与正常时间相差:+6小时

        /1. 先要创建1个NSDateFormatter对象,这个对象作用:将1个日期转换成1个指定的格式.
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
 
        /2. 告诉这个日期格式化器对象 要把日期转换个什么样子的.
            yyyy: 年份
            MM: 月份.
            mm: 分钟.
            dd: 天.
            hh: 12小时.
            HH: 24小时
            ss: 秒

             NSDate *date = [NSDate new];
             NSDateFormatter *formatter = [NSDateFormatter new];
             formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
             NSString *str = [formatter stringFromDate:date];
             NSLog(@"%@", str);      //2016-08-07 16:40:23
 
        /3. 使用日期格式化器 将指定的日期转换指定格式的字符串.
            NSString *str =[formatter stringFromDate:date];
            NSLog(@"str = %@",str);

            - (NSString *)stringFromDate:(NSDate *)date; //将日期类型换换为字符串
            - (NSDate *)dateFromString:(NSString *)string;//将字符串转换为日期对象.

            注意: NSDate取到的时间是格林威治的时间.
            NSDateFormatter转换成字符串以后 会转换为当前系统的时区的时间.
 
            NSDate *date = [NSDate new];
            NSString *strDate = @"2020/10/11 12:13:14";
            //创建一个日期格式化对象
            NSDateFormatter *formatter = [NSDateFormatter new];
            //指定格式
            formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
            NSDate *newDate = [formatter dateFromString:strDate];
            NSLog(@"%@", newDate);    //2020-10-11 04:13:14 +0000     //+8小时
 
    7.2 计算时间.
        1). 想得到明天此时此刻的时间:
            在当前的时间的基础之上,新增指定的秒.后的时间
            + (instancetype)dateWithTimeIntervalSinceNow:(NSTimeInterval)secs;
                NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-4000];
                NSLog(@"%@", date);
 
            得到东八区的时间:
            NSDate *d1 =[NSDate dateWithTimeIntervalSinceNow:8*60*60];
            传入1个负数 就是在当前时间的基础之上减指定的秒数.

        2). 求两个时间之间的差:
            - (NSTimeInterval)timeIntervalSinceDate:(NSDate *)anotherDate;
                NSString *str = @"";
                NSDate *startDate = [NSDate date];

                for(int i=0; i<30000; i++){
                    str = [NSString stringWithFormat:@"%@%d", str, i];
                }

                NSDate *endDate = [NSDate date];
                double date = [endDate timeIntervalSinceDate:startDate];
                NSLog(@"%lf", date);   //1.346381
 
        3). 可以自定义分类完成获取单独:year,month
 
 
 8. Copy
    1. 无论在MRC还是ARC下,如果属性的类型是NSString类型的. @property参数使用copy.
    2. copy 复制
        1). copy是1个方法. 定义在NSObject类之中. 作用:拷贝对象.
            NSString *str1 = @"aa";
            NSString *str2 = [str1 copy];
            NSString        --> copy --> 不可变字符串, 没有产生新对象, 而是直接将对象本身的地址返回. 这种拷贝叫做浅拷贝
            
            NSMutableString *str1 = [NSMutableString stringWithFormat:@"aa"];
            NSString *str2 = [str1 copy];
            NSMutableString --> copy --> 不可变字符串. 有产生1个新对象. 这样的拷贝叫做深拷贝.

        2). mutableCopy 定义在NSObject类之中. 作用:拷贝对象.
            NSString *str1 = @"aa";
            NSMutableString *str2 = [str1 mutableCopy];
            NSString        --> mutableCopy --> 可变字符串对象. 深拷贝.
 
            NSMutableString *str1 = [NSMutableString stringWithFormat:@"aa"];
            NSMutableString *str2 = [str1 mutableCopy];
            NSMutableString --> mutableCopy --> 可变字符串对象. 深拷贝.
            
           这是字符串的对象拷贝特点.

    3. 字符串对象拷贝的引用计数器的问题.
        1). 若字符串对象存储在常量区中. 存储在常量区的数据是不允许被回收的.
            所以存储在常量区的字符串对象的引用计数器是1个超大的数.并且retain和release无效.
 
        2). 若字符串存储在堆区. 这个字符串对象和普通的对象一样的.引用计数器默认是1.
            NSString *str = [NSString stringWithFormat:@"aa"]; //存在堆区,默认是在常量区
            NSLog(@"%u", str.reatinCount);   //1
 
        3). 字符串对象如果是浅拷贝. 会将对象的引用计数器+1
            NSString *str1 = [NSString stringWithFormat:@"aa"]; //存在堆区,默认是在常量区
            NSLog(@"%u", str1.retainCount);   //1
            NSString *str2 = [str1 copy];
            NSLog(@"%u", str1.retainCount);   //2
 
            字符串对象如果是深拷贝. 原来的对象的引用计数器不变.新拷贝出来的对象的引用计数器为1.
            NSMutableString *str1 = [NSMutableString stringWithFormat:@"aa"]; //存在堆区,默认是在常量区
            NSLog(@"%u", str1.retainCount);   //1
            NSString *str2 = s[tr1 copy];
            NSLog(@"%u", str1.retainCount);   //1
            NSLog(@"%u", str2.retainCount);   //1
 
    4. copy方法的确是定义在NSObject类中的1个方法.
        copy方法的内部调用了另外1个方法. copyWithZone: 这个方法是定义在NSCoping协议之中的.
 
        因为我们的类没有遵守NSCoping协议,那么我们的类中就没有 copyWithZone:这个方法.
        所以,当我们自定义的类调用copy方法的时候就会出错

    2. 如果我们想要让我们自己的类具备对象拷贝的能力.那么就让我们的类遵守NSCoping协议
        并实现copyWithZone:这个方法.

        如果想要实现深拷贝:那么就重新创建1个对象.并将对象的属性的值复制.返回.
        如果想要实现浅拷贝:那么就直接返回self
 
 
9. 单例模式:
    1个类的对象,无论在何时创建也无论在什么地方创建 也无论创建多少次.创建出来的都是同1个对象.
         
    2. 无论如何创建对象,最终都会调用alloc方法来创建对象.
         1). alloc方法的内部. 其实什么都没有做,只是调用了allocWithZone:方法.
         2). 实际上真正申请空间 创建对象的事情是allocWithZone:方法在做.
         
    3. 要实现单例模式.
         重写+ allocWithZone:
         + (instancetype)allocWithZone:(struct _NSZone *)zone{
             static id instance = nil;
             if(instance == nil){
                 instance = [super allocWithZone:zone];
             }
             
             return instance;
         }
 
    4. 单例模式的规范:
         如果类是1个单例模式.要求为类提供1个类方法.来返回这个单例对象.
         类方法的名称必须以 shared类名; default类名;
 
    5. 什么时候要把类搞成单例.
         单例的特点
         无论何时、何地、创建对象,也不管创建多少次对象,得到都是同1个对象.
         单例对象可以被共享. 存储在单例对象中的数据可以被共享.
         也就是无论在什么地方创建单例对象 访问的都是同1个对象.
 
    6. 如果数据需要被整个程序所共享. 将数据以属性的方式存储在单例对象中.
 
 
 */
#import <Foundation/Foundation.h>
#define LogBOOL(var) NSLog(@"%@",var==YES?@"YES":@"NO")

@interface Person : NSObject
@end
@implementation Person
@end

//copy
@interface Student : NSObject{
    NSString *_name;
}
- (void)setName:(NSString *)name;
- (NSString *)name;

//只要深copy一份就行了: 一行搞定
@property(nonatomic, copy)NSString *class;
@end

@implementation Student
- (void)setName:(NSString *)name{
    //_name = name;
    _name =[name copy];   
}
- (NSString *)name{
    return _name;
}
@end


//copy 自定义类实现对象的拷贝
@interface Person1 : NSObject <NSCopying>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)int age;
@end

@implementation Person1
- (id)copyWithZone:(NSZone *)zone{
    //1.如果要做深拷贝.你就重新创建1个对象.
    //  把对象的属性的值 复制 到新对象中 将新对象返回.
    
    //    Person *p1 = [Person new];
    //    p1.name = _name;
    //    p1.age = _age;
    //    return p1;
    
    //浅拷贝
    return self;
    
}
@end




//单例
@interface Person2 : NSObject
@property(nonatomic,assign)int width;
@property(nonatomic,assign)int height;

+ (instancetype)sharedPerson;
+ (instancetype)defaultPerson;

@end

@implementation Person2
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static id instance = nil;
    if(instance == nil){
        instance = [super allocWithZone:zone];
    }
    return instance;
}

+ (instancetype)sharedPerson{
    return [self new];
}
+ (instancetype)defaultPerson{
    return [self new];
}
@end

int main(int argc, const char * argv[]) {
    
    //将数组写入文件
   NSArray *arr = @[@"aa", @"bb", @"cc"];
   BOOL res = [arr writeToFile:@"/Users/damys/Desktop/temp.plist" atomically:NO];
   LogBOOL(res);
    
    //从文件中读取数组
   NSArray *arr = [NSArray arrayWithContentsOfFile:@"/Users/damys/Desktop/temp.plist"];
   for(NSString *item in arr){
       NSLog(@"%@", item);
   }
    
    
    //NSDictionary 字典数组
   NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"jack",@"name", nil];
   NSLog(@"%@", dict);   //{name = jack}
    
    //快捷方式:
   NSDictionary *dict = @{@"name":@"jack", @"age":@"20"};
   NSLog(@"%@", dict);    //{age=20, name=jack}
    
    //使用字典数组
   NSDictionary *dict = @{@"name":@"jack", @"age":@"20"};
   NSLog(@"%@", dict[@"name"]);  //jack
    
    //字典数组
   NSDictionary *dict = @{
       @"name":@"rose",
       @"age":@"18"
   };
    //遍历1
   for(id item in dict){
       NSLog(@"%@ = %@",item,dict[item]); //name=rose, age = 18
   }
    //遍历2: block
   [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       NSLog(@"%@=%@", key, obj);      //name=rose, age = 18
   }];
    
    
    
    //NSMutableDictionary
    //创建,即赋值
   NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"jack",@"name", nil];
   
   //新增键值对
   [dict setObject:@"20" forKey:@"age"];
   NSLog(@"%@", dict);
   
   //删除
   [dict removeObjectForKey:@"age"];
   [dict removeAllObjects];
   NSLog(@"%@", dict);
    
    
    //将字典数组存于文件
   NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"jack",@"name",@"20",@"age", nil];
   BOOL res = [dict writeToFile:@"/Users/damys/Desktop/dict.plist" atomically:NO];
   LogBOOL(res);
   
    //从文件中读取数组
   NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/Users/damys/Desktop/dict.plist"];
   NSLog(@"%@", dict);   //{age=20, name=jack}
    
    
    
    //集合内存管理: 要切换MRC
   Person *p1 = [Person new];
   NSLog(@"%lu",p1.retainCount);   //1
   NSArray *arr = @[p1];
   NSLog(@"%lu",p1.retainCount);   //2
    
    
    //文件管理员. NSFileManger  --判断
   NSFileManager *manager = [NSFileManager defaultManager];
    
   1). 判断指定的文件或者文件夹在磁盘上是否真实的存在
   - (BOOL)fileExistsAtPath:(NSString *)path;
   NSString *path = @"/Users/damys/Desktop/dict.plist";
   BOOL res = [manager fileExistsAtPath:path];
   LogBOOL(res);

   2).判断指定的路径是否真实的存储在我们的磁盘之上,并且判断这个路径是1个文件夹路径还是1个文件路径.
   - (BOOL)fileExistsAtPath:(NSString *)path isDirectory:(BOOL *)isDirectory;
   返回值:代表这个路径是否真实存在.
   参数指针: 代表这个路径是否是1个文件夹路径
   NSString *path = @"/Users/damys/Desktop/temp";
   BOOL flag = NO;
   BOOL res = [manager fileExistsAtPath:path isDirectory:&flag];
   if(res == YES){
       NSLog(@"给的路径存在");
       
       if(flag == YES){
           NSLog(@"给的路径是一个文件夹");
       }else{
           NSLog(@"给的路径是一个文件");
       }
   }else{
       NSLog(@"给的路径不存在");
   }
    
   3). 判断指定的文件夹或者文件是否可以读取.  --存在--可读--可写
   - (BOOL)isReadableFileAtPath:(NSString *)path;
   BOOL res = [manager isReadableFileAtPath:@"/Users/damys/Desktop/dict.plist"];
   LogBOOL(res);
    
   4). 判断指定的文件夹或者文件是否可以写入.
   - (BOOL)isWritableFileAtPath:(NSString *)path;
   BOOL res = [manager isWritableFileAtPath:@"/Users/damys/Desktop/temp"];
   LogBOOL(res);
    
   5). 判断指定的文件夹或者文件是否可以删除.
   - (BOOL)isDeletableFileAtPath:(NSString *)path
   BOOL res = [manager isDeletableFileAtPath:@"/Users/damys/Desktop/temp"];
   LogBOOL(res);
   
    
    

    //文件管理员. NSFileManger  --获取信息
   NSFileManager *manager = [NSFileManager defaultManager];
    
   1).获取指定文件或者文件夹的属性信息.
   - (NSDictionary *)attributesOfItemAtPath:(NSString *)path error:(NSError **)error
   返回的是1个字典,如果要拿到特定的信息 通过key
   NSDictionary *dict = [manager attributesOfItemAtPath:@"/Users/damys/Desktop/dict.plist" error:nil];
   
   NSLog(@"%@", dict);
   NSLog(@"%@", dict[NSFileModificationDate]);   //取单个
    /*
     2016-08-07 13:59:39.330 09 Fundation 2[1038:41921] {
     NSFileCreationDate = "2016-08-07 05:02:35 +0000";
     NSFileExtensionHidden = 0;
     NSFileGroupOwnerAccountID = 20;
     NSFileGroupOwnerAccountName = staff;
     NSFileHFSCreatorCode = 0;
     NSFileHFSTypeCode = 0;
     NSFileModificationDate = "2016-08-07 05:02:35 +0000";
     NSFileOwnerAccountID = 501;
     NSFileOwnerAccountName = Damys;
     NSFilePosixPermissions = 420;
     NSFileReferenceCount = 1;
     NSFileSize = 265;
     NSFileSystemFileNumber = 6389600;
     NSFileSystemNumber = 16777220;
     NSFileType = NSFileTypeRegular;
     }
     */

   2).获取指定目录下的所有的文件和目录. 是拿到指定目录下的所有的文件和目录 所有的后代目录和文件.
   子目录的子目录的子目录 所有的都可以拿到.
   - (NSArray *)subpathsAtPath:(NSString *)path;
   NSArray *arr = [manager subpathsAtPath:@"/Users/damys/Desktop/temp"];
   for(NSString *str in arr){
       NSLog(@"%@", str);
   }
    /*
     .DS_Store,
     abc,
     abc/cc.txt,
     test.txt
     */
  
   3).获取指定目录下的所有的子目录和文件 不保护孙子辈.
   - (NSArray *)contentsOfDirectoryAtPath:(NSString *)path error:(NSError **)error
   NSArray *arr = [manager contentsOfDirectoryAtPath:@"/Users/damys/Desktop/temp" error:nil];
   for(NSString *str in arr){
       NSLog(@"%@", str);
   }
    /*
     .DS_Store,
     abc,
     test.txt
     */
    
    

    //文件管理员. NSFileManger  文件/目录的创建
   NSFileManager *manager = [NSFileManager defaultManager];
    //在指定的目录创建文件
   NSString *str = @"hello world";
   NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
   BOOL res = [manager createFileAtPath:@"/Users/damys/Desktop/temp/aa.txt" contents:data attributes:nil];
   LogBOOL(res);
    
    //在指定的目录创建文件夹
   BOOL res = [manager createDirectoryAtPath:@"/Users/damys/Desktop/temp/aa" withIntermediateDirectories:YES attributes:nil error:nil];
   LogBOOL(res);
    
    
//    3).拷贝文件. 也可改名子
   - (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
   BOOL res = [manager copyItemAtPath:@"/Users/damys/Desktop/test.txt" toPath:@"/Users/damys/Desktop/temp/test-temp.txt" error:nil];
   LogBOOL(res);
    
    
//    4).移动文件 剪切 文件的重命名. 重名的原理: 将文件移动到原来的目录并改名.
   - (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
   BOOL res = [manager moveItemAtPath:@"/Users/damys/Desktop/test.txt" toPath:@"/Users/damys/Desktop/temp/temp-move.txt" error:nil];
   LogBOOL(res);
    
    
//    5).删除文件.
   - (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error
   BOOL res = [manager removeItemAtPath:@"/Users/damys/Desktop/temp/temp-move.txt" error:nil];
   LogBOOL(res);
    
    
    //文件终结者
   while(1){
       NSFileManager *fileManager = [NSFileManager defaultManager];
       NSString *path = @"/Users/damys/Desktop/temp1/";
       NSArray *arr = [fileManager contentsOfDirectoryAtPath:path error:nil];
       
       //文件夹下有文件,可以执行操作
       if(arr.count > 0){
           for(NSString *file in arr){
               //要拼接文件所在完整路径:目录+文件
               NSString *newPath = [NSString stringWithFormat:@"%@%@", path, file];
               
               if([fileManager isDeletableFileAtPath:newPath]){
                   [fileManager removeItemAtPath:newPath error:nil];
               }
           }
       }
   
       NSLog(@"扫描完成");
       
       [NSThread sleepForTimeInterval:3];  //CPU暂停指定的时间:3秒
   }

    
    //结构体
    //控件的位置
   CGPoint p = CGPointMake(10, 20);
   NSLog(@"p.x=%lf, p.y=%lf", p.x, p.y);  //p.x=10.000000, p.y=20.000000
    
    //控件的大小
   CGSize s = CGSizeMake(10, 20);
   NSLog(@"s.w=%lf, s.h=%lf", s.width, s.height);  //p.x=10.000000, p.y=20.000000
    
    //控件的位置/大小
   CGRect rect = CGRectMake(10, 20, 100, 30);
   NSLog(@"height=%lf",rect.size.height);  //30.00000
    
    

    //NSValue - CGPoint 方式
   CGPoint p1 = CGPointMake(10, 20);
   CGPoint p2 = CGPointMake(30, 40);
   
   //NSArray *arr = @[p1,p2];  //不能这样存,p1, p2 不是一个对象, 需要转换
   
   NSValue *v1 = [NSValue valueWithPoint:p1];
   NSValue *v2 = [NSValue valueWithPoint:p2];

   NSArray *arr1 = @[v1, v2];
   
   for(NSValue *v1 in arr1){
       NSLog(@"%@", NSStringFromPoint(v1.pointValue));  // {10,20} {30},40
   }
   
   //NSValue - CGSize 方式
   CGSize s1 = CGSizeMake(50, 60);
   CGSize s2 = CGSizeMake(70, 80);
   NSValue *v3 = [NSValue valueWithSize:s1];
   NSValue *v4 = [NSValue valueWithSize:s2];
   
   NSArray *arr2 = @[v3, v4];
   
   for(NSValue *v2 in arr2){
       NSLog(@"%@", NSStringFromSize(v2.sizeValue)); //{50,60} {70,80}
   }
    
    
    
    //NSDate
    //1. 默认方式:
   NSDate *date = [NSDate new];
   NSLog(@"%@", date);    //2016-08-07 08:31:52 +0000    与正常时间相差:+8小时
    
    //2. 格式化:
   NSDate *date = [NSDate new];
   NSDateFormatter *formatter = [NSDateFormatter new];
   formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
   NSString *str = [formatter stringFromDate:date];
   NSLog(@"%@", str);      //2016-08-07 16:40:23
    
    //3. 使用日期格式化器 将指定的日期转换指定格式的字符串
   NSDate *date = [NSDate new];
   NSString *strDate = @"2020/10/11 12:13:14";
   //1. 创建一个日期格式化对象
   NSDateFormatter *formatter = [NSDateFormatter new];
   //2. 指定格式
   formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
   NSDate *newDate = [formatter dateFromString:strDate];
   NSLog(@"%@", newDate);    //2020-10-11 04:13:14 +0000     //+8小时
    
    //4. 计算时间
   NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-4000];
   NSLog(@"%@", date);
    
    //5. 求两个时间之间的差-可以测试系统的性能
   NSString *str = @"";
   NSDate *startDate = [NSDate date];
   
   for(int i=0; i<30000; i++){
       str = [NSString stringWithFormat:@"%@%d", str, i];
   }
   
   NSDate *endDate = [NSDate date];
   double date = [endDate timeIntervalSinceDate:startDate];
   NSLog(@"%lf", date);   //1.346381
    
    //6. 取出单独日期--一般取法
   NSDate *date = [NSDate new];
   NSDateFormatter *formatter = [NSDateFormatter new];
   formatter.dateFormat = @"yyyy";  //MM
   NSString *str = [formatter stringFromDate:date];
   NSLog(@"时间:%d", str.intValue);   //2016
    
    //取出单独日期--使用日历
   NSDate *date = [NSDate new];
   //1. 创建一个日历对象, 是一个单例模式
   NSCalendar *calendar = [NSCalendar currentCalendar];
   //2. 让日历对象从日期对象中取出日期的各个部分
   NSDateComponents *com = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
   NSLog(@"%ld-%ld-%lu", com.year, com.month, com.day);  //2016-8-7
    
    
    //copy
   Student *stu = [Student new];
   NSMutableString *str = [NSMutableString stringWithFormat:@"jack"];
   stu.name = str;
   [str appendString:@"rose"];
   NSLog(@"stu.name:%@", stu.name);   //jack
    /*
     - (void)setName:(NSString *)name{
         //_name = name;                  //这样写就会输出:jackrose
         _name = [name copy];             //只要深copy一份就行了
     */
    
    
    //copy 自定义类实现对象的拷贝
   Person1 *p1 = [Person1 new];
   p1.name = @"jack";
   p1.age = 18;
   
   Person1 *p2 =  [p1 copy];
   
   NSLog(@"p1 = %p",p1);  //0x100103ab0
   NSLog(@"p2 = %p",p2);  //0x100103ab0
    
    
    //单例
    Person2 *p1 = [Person2 sharedPerson];
    Person2 *p2 = [Person2 sharedPerson];
    
    NSLog(@"%p", p1);  //0x100104930
    NSLog(@"%p", p2);  //0x100104930
    
    
    
    return 0;
}























