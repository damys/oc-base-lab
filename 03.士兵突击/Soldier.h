/*
 
 1.士兵类:
     属性:姓名,兵种
     行为:开火
 
 
 */
#import <Foundation/Foundation.h>
#import "Gun.h"

@interface Soldier : NSObject{
    NSString *_name;
    NSString *_type;
    Gun *_gun;
}

//姓名
- (void)setName:(NSString *)name;
- (NSString *)name;

//兵种
- (void)setType:(NSString *)type;
- (NSString *)type;

//枪
- (void)setGun:(Gun *)gun;
- (Gun *)gun;

//开火
- (void)fire;

@end
