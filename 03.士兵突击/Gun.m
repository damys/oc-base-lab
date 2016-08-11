
#import "Gun.h"

@implementation Gun

//型号
- (void)setModel:(NSString *)model{
    _model = model;
}
- (NSString *)model{
    return _model;
}

//子弹数量
- (void)setDanjia:(Danjia *)danjia{
    _danjia = danjia;
}
- (Danjia *)danjia{
    return _danjia;
}

//射击:在有子弹的情况下可以射击
- (void)shoot{
    if([_danjia bulletCount] > 0){
        NSLog(@"开火....");
        int count = [_danjia bulletCount];  //记录当前弹夹的中子弹的数量
        count--;
        [_danjia setBulletCount:count];     //调用一次,减少1发子弹
        NSLog(@"剩余的子弹数量为:%d", count);
    }else{
        NSLog(@"没子弹了");
    }
    
}

@end
