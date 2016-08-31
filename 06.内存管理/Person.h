//
//  Person.h
//  oc base
//
//  Created by damys on 16/7/30.
//  Copyright © 2016年 damys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

@interface Person : NSObject{
    Car *_car;
    NSString *_name;
    int _age;
}

- (void)setCar:(Car *)car;
- (Car *)car;

- (void)setName:(NSString *)name;
- (NSString *)name;

- (void)setAge:(int)age;
- (int)age;

- (void)drive;
@end
