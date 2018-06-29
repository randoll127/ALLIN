#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ALBaseNavigationHelper : NSObject
+(void)push:(UINavigationController*)naviController controller:(UIViewController*)controller;
+(void)push:(UINavigationController*)naviController controller:(UIViewController*)controller isAnimated:(BOOL)isAnimated;
+(void)pop:(UINavigationController*)naviController;
+(void)pop:(UINavigationController*)naviController isAnimated:(BOOL)isAnimated;
@end
