#import "ALBaseMathHelper.h"

@implementation ALBaseMathHelper

//[from,to)
+(int)getRandomNumber:(int) from to:(int)to{
    return (int)(from + (arc4random() % (to -from)));
}

@end
