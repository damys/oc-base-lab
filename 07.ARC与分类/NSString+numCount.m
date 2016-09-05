
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
