//
//  Author.m
//  oc base
//
//  Created by damys on 16/7/30.
//  Copyright © 2016年 damys. All rights reserved.
//

#import "Author.h"
#import "Book.h"

@implementation Author
-(void) dealloc{
    NSLog(@"Auther over~");
    [_name release];
    [_book release];
    [super dealloc];
}

- (void)read{
    NSLog(@"author is reading~");
    [_book msg];
}
@end
