

#import "Soldier.h"

@implementation Soldier

//姓名
- (void)setName:(NSString *)name{
    _name = name;
}
- (NSString *)name{
    return _name;
}

//兵种
- (void)setType:(NSString *)type{
    _type = type;
}
- (NSString *)type{
    return _type;
}

//枪
- (void)setGun:(Gun *)gun{
    _gun = gun;
}
- (Gun *)gun{
    return _gun;
}

//开火
- (void)fire{
    NSLog(@"士兵:%@ 预备好了, 请指示!", _name);
    [_gun shoot];
}

@end
