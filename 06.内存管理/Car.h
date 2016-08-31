//
//  Car.h
//  oc base
//
//  Created by damys on 16/7/30.
//  Copyright © 2016年 damys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject{
    int _speed;
}

- (void)setSpeed:(int)speed;
- (int)speed;

- (void)run;
@end
