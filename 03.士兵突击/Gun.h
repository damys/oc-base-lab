/*
 
 2.枪类: Gun
     属性:型号,射程,子弹数量
     行为:射击

 
 */

#import <Foundation/Foundation.h>
#import "Danjia.h"

@interface Gun : NSObject{
    NSString *_model;
    Danjia *_danjia;
}

//型号
- (void)setModel:(NSString *)model;
- (NSString *)model;

//子弹数量
- (void)setDanjia:(Danjia *)danjia;
- (Danjia *)danjia;

//射击
- (void)shoot;
@end
