#import <UIKit/UIKit.h>

@interface ALBaseColorHelper : NSObject
+(UIColor*)colorWithRed:(float)red green:(float)green blue:(float)blue;
+ (UIColor *)colorWithHex:(NSString *)hexColor;
+ (UIColor *)colorWithHex:(NSString *)hexColor alpha:(CGFloat)a;
+ (UIColor*)randomMetroUIColor;



@end
