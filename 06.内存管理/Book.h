#import <Foundation/Foundation.h>
@class Author;

@interface Book : NSObject
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) Author *author;

- (void)msg;
@end
