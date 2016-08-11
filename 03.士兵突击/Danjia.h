/*
 
 3.子弹类
     属性:弹夹容量,实际装弹量
 
 */

#import <Foundation/Foundation.h>

@interface Danjia : NSObject{
    int _maxCapacity;
    int _bulletCount;
}

//弹夹容量
- (void)setMaxCapact:(int)maxCapacity;
- (int)maxCapacity;

//实际装弹量
- (void)setBulletCount:(int)bulletCount;
- (int)bulletCount;

@end
