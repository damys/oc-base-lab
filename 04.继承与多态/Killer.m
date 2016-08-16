//
//  Killer.m
//  oc base
//
//  Created by damys on 16/7/24.
//  Copyright © 2016年 damys. All rights reserved.
//

#import "Killer.h"

@implementation Killer

//可以杀所有人
- (void)killWith:(Person *)per{
    NSLog(@"有人要取你性命,赶紧呼救");
    
    [per help];
}

@end
