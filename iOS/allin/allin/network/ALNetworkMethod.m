#import "ALNetworkMethod.h"
#import <objc/runtime.h>


@implementation ALNetworkMethod





#pragma mark PrivateMethod
+(id)annonation:(Class)clazz selectorStr:(NSString*)selectorStr{
    NSDictionary *apiAnnotations = nil;
    NSString* alPrivateSelectorStr = [NSString stringWithFormat:@"al_private_api_%@",[selectorStr stringByReplacingOccurrencesOfString:@":" withString:@"_"]];
    unsigned int count;
    Method *methodLists = class_copyMethodList(object_getClass(clazz), &count);
    for (int i = 0; i < count; i++) {
        NSString* method = NSStringFromSelector(method_getName(methodLists[i]));
        SEL selector = NSSelectorFromString(alPrivateSelectorStr);
        if ([method hasPrefix:alPrivateSelectorStr]) {
            apiAnnotations  = ((NSDictionary*(*)(id, SEL))method_getImplementation(methodLists[i]))(clazz,selector);
            break;
        }
    }
    free(methodLists);
    return apiAnnotations;
    //    switch (analyzeType) {
    //        case AnalyzeTypeAnnatations:{
    //            NSMutableDictionary *mAnnotations = apiAnnotations.mutableCopy;
    //            [mAnnotations removeObjectForKey:kHttpParamsKey];
    //            return [mAnnotations copy];
    //        }
    //            break;
    //        case AnalyzeTypeParameterAnnatation:{
    //            return [apiAnnotations objectForKey:kHttpParamsKey];
    //        }
    //            break;
    //    }
    //    return nil;
}


@end
