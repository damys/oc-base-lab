//
//  NSString+numCount.m
//  oc base
//
//  Created by damys on 16/7/31.
//  Copyright © 2016年 damys. All rights reserved.
//

#import "NSString+numCount.h"

@implementation NSString (numCount)
- (int)numberCount{
    
    int count=0;
    for (int i=0; i<self.length; i++) {
        unichar ch = [self characterAtIndex:i];
        if(ch >='0' && ch <='9'){
            count++;
        }
    }
    return count;
}
@end
