#import "ALBaseViewHelper.h"

@implementation ALBaseViewHelper
//根据view发现view所在viewcontroller
+(UIViewController *)findViewController:(UIView*)view
{
    id responder = view;
    while (responder){
        if ([responder isKindOfClass:[UIViewController class]]){
            return responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}
@end
