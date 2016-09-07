#import "SArray.h"
#import <string.h>

@implementation SArray
//传统方法实现排序
//- (void)sortWithCountries:(char *[])countries andLength:(int)len{
//    
//    for (int i=0; i<len; i++) {
//        for(int j=0; j<len-1-i; j++){
//            int res = strcmp(countries[j], countries[j+1]);
//            if(res>0){
//                char *temp = countries[j];
//                countries[j]=countries[j+1];
//                countries[j+1]=temp;
//            }
//        }
//    }
//    
//}

//以block 方式实现自定义
- (void)sortWithCountries:(char *[])countries andLength:(int)len andCompareBlock:(NewType2)compareBlock{

    for (int i=0; i<len; i++) {
        for(int j=0; j<len-1-i; j++){
            
            //返回YES,NO
            BOOL res = compareBlock(countries[j], countries[j+1]);
            
            if(res == YES){
                char *temp = countries[j];
                countries[j]=countries[j+1];
                countries[j+1]=temp;
            }
        }
    }

}
@end
