//
//  Book.m
//  oc base
//
//  Created by damys on 16/7/30.
//  Copyright © 2016年 damys. All rights reserved.
//

#import "Book.h"
#import "Author.h"

@implementation Book
- (void)dealloc{
    
    NSLog(@"Book over~");
    [_name release];
    [_author release];
    [super dealloc];
}

- (void)msg{
    NSLog(@"Book msg: name=%@", _name);
}
@end
