#import "ALNetworkPath.h"
#import <allin/ALBaseMacro.h>
@interface ALNetworkPath(){}
@end

@implementation ALNetworkPath

- (instancetype)initWithPath:(NSString *)path{
    if (self = [super init]) {
        self.pathStr = path;
    }
    return self;
}

- (NSArray*)parseParams{
    NSScanner *scanner = [NSScanner scannerWithString:self.pathStr];
    NSMutableArray* params = @[].mutableCopy;
    while (![scanner isAtEnd]) {
        NSString* valueStr = nil;
        [scanner scanUpToString:@"{" intoString:nil];
        [scanner scanUpToString:@"}" intoString:&valueStr];
        if(valueStr&&valueStr.length>0){
            [params addObject:[valueStr substringFromIndex:1]];
        }
    }
    self.keyParams=params.copy;
    return self.keyParams;
}

-(NSString*)parseUrlWithValues:(NSArray*)values{
    NSString* realPath =self.pathStr.copy;
    for(NSInteger i=0;i<self.keyParams.count;i++){
        id value = values[i];
        realPath= [realPath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}",self.keyParams[i]] withString:[value isKindOfClass:[NSNumber class]]?[NSString stringWithFormat:@"%@",value]:value];
        
    }
    return realPath;
}

ALDEALLOC_LOG
@end
