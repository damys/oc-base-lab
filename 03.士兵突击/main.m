/*
 分析: 有三个类:士兵类,枪类,子弹 他们之间的关系是关联关系
      1.士兵类:
           属性:姓名,兵种
           行为:开火
      2.枪类: Gun
          属性:型号,子弹数量
          行为:射击
      3.子弹类 Danjia
          属性:弹夹容量,实际装弹量

 */

#import <Foundation/Foundation.h>
#import "Soldier.h"

int main(int argc, const char * argv[]) {
    //3. 子弹类
    Danjia *dj = [Danjia new];
    [dj setMaxCapact:10];    //弹夹容量
    [dj setBulletCount:5];   //装弹量
    
    //2. 枪类
    Gun *ak47 = [Gun new];
    [ak47 setModel:@"AK47"];  //型号
    [ak47 setDanjia:dj];      //依赖子弹类
    
    //士兵类
    Soldier *tom = [Soldier new];
    [tom setName:@"汤姆"];   //姓名
    [tom setType:@"火箭军"]; //兵种
    [tom setGun:ak47];       //依赖枪类
    
    for(int i=0; i<10; i++){
        [tom fire];
    }
    
    
    

    return 0;
}
