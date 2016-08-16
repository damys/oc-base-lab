//
//  Killer.h
//  oc base
//
//  Created by damys on 16/7/24.
//  Copyright © 2016年 damys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Killer : NSObject

//可以杀所有人
- (void)killWith:(Person *)per;

@end
