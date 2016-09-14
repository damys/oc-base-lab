//
//  CZNumber.h
//  Day10-Foundation框架
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 ITCAST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZNumber : NSObject

@property(nonatomic,assign)int intValue;

- (instancetype)initWithIntValue:(int)value;
+ (instancetype)numberWithIntValue:(int)value;

@end
