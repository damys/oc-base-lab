
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
