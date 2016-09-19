//
//  CZNumber.m
//  Day10-Foundation框架
//
//  Created by apple on 15/11/13.
//  Copyright © 2015年 ITCAST. All rights reserved.
//

#import "CZNumber.h"

@implementation CZNumber
- (instancetype)initWithIntValue:(int)value
{
    if(self = [super init])
    {
        self.intValue = value;
    }
    return self;
}
+ (instancetype)numberWithIntValue:(int)value
{
    return [[self alloc] initWithIntValue:value];
}
@end
