
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
