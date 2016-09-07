//
//  SArray.h
//  oc base
//
//  Created by damys on 16/8/2.
//  Copyright © 2016年 damys. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef BOOL (^NewType2)(char *country1, char *country2);

@interface SArray : NSObject
//- (void)sortWithCountries:(char *[])countries andLength:(int)len;

//以block 方式实现自定义
- (void)sortWithCountries:(char *[])countries andLength:(int)len andCompareBlock:(NewType2)compareBlock;
@end
