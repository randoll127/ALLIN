#import "ALBaseWebHelper.h"

@implementation ALBaseWebHelper
+ (void)changeWebviewUA:(NSString*)ua
{
    NSDictionary * regDic = @{@"UserAgent":ua};
    [[NSUserDefaults standardUserDefaults] registerDefaults:regDic];
}

@end
