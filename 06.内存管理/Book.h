//
//  Book.h
//  oc base
//
//  Created by damys on 16/7/30.
//  Copyright © 2016年 damys. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Author;

@interface Book : NSObject
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) Author *author;

- (void)msg;
@end
