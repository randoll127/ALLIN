#import "ALBaseNavigationHelper.h"


@implementation ALBaseNavigationHelper

+(void)push:(UINavigationController*)naviController controller:(UIViewController*)controller{
    [naviController pushViewController:controller animated:YES];
}
+(void)push:(UINavigationController*)naviController controller:(UIViewController*)controller isAnimated:(BOOL)isAnimated{
   [naviController pushViewController:controller animated:isAnimated];
}

+(void)pop:(UINavigationController*)naviController{
    [naviController popViewControllerAnimated:YES];
}
+(void)pop:(UINavigationController*)naviController isAnimated:(BOOL)isAnimated{
    [naviController popViewControllerAnimated:isAnimated];
}



@end
