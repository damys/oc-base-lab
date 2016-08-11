

#import "Danjia.h"

@implementation Danjia
//弹夹容量
- (void)setMaxCapact:(int)maxCapacity{
    
    _maxCapacity = maxCapacity;
}
- (int)maxCapacity{
    return _maxCapacity;
}


//实际装弹量:要做约束:大于0 小于弹夹容量, 否则只有2发
- (void)setBulletCount:(int)bulletCount{
    if(bulletCount >= 0 && bulletCount <= _maxCapacity){
        _bulletCount = bulletCount;
    }else{
        _bulletCount = 2;
    }
}
- (int)bulletCount{
    return _bulletCount;
}

@end
