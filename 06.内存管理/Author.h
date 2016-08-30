
#import <Foundation/Foundation.h>
#import "Book.h"

@interface Author : NSObject
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) Book *book;

- (void)read;
@end
