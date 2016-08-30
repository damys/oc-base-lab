//
//  Author.h
//  oc base
//
//  Created by damys on 16/7/30.
//  Copyright © 2016年 damys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface Author : NSObject
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) Book *book;

- (void)read;
@end
