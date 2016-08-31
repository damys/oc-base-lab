

#import <Foundation/Foundation.h>

@interface Car : NSObject{
    int _speed;
}

- (void)setSpeed:(int)speed;
- (int)speed;

- (void)run;
@end
