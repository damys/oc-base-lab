//
//  Person.m
//  oc base
//
//  Created by damys on 16/7/24.
//  Copyright © 2016年 damys. All rights reserved.
//

#import "Person.h"

@implementation Person

//名子
- (void)setName: (NSString *)name{
    _name = name;
}
- (NSString *)name{
    return _name;
}


//help
- (void)help{
    NSLog(@"help...");
}

- (NSString *)description{
    return [NSString stringWithFormat:@"姓名:%@", _name];
}
@end
