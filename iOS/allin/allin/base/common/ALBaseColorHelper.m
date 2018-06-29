#import "ALBaseColorHelper.h"
#import "ALBaseMathHelper.h"

@implementation ALBaseColorHelper
static NSArray* metroColor;
+(void)initialize{
    metroColor = @[@"252525",@"006AC1",@"691BB8",@"F4B300",@"78BA00",@"2673EC",@"AE113D",@"632F00",@"2E1700",@"199900",@"004A00",@"00C13F",@"159924",@"FF981D",@"1B58B8",@"56C5FF",@"E1B700",@"FF76BC",@"B81B1B",@"00A4A4"];
}

+(UIColor*)colorWithRed:(float)red green:(float)green blue:(float)blue{
    return [UIColor colorWithRed:red/255.0f green:green/255.0 blue:blue/255.0 alpha:1];
}

+ (UIColor *)colorWithHex:(NSString *)hexColor
{
    return [self colorWithHex:hexColor alpha:1.0f];
}

+ (UIColor *)colorWithHex:(NSString *)hexColor alpha:(CGFloat)a
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:a];
}



+(UIColor*)randomMetroUIColor{
    NSInteger randIdx = [ALBaseMathHelper getRandomNumber:0 to:(int)metroColor.count];
    return [self colorWithHex:metroColor[randIdx]];
}



@end
