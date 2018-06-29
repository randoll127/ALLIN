//
//  ALNetworkHelper.m
//  allin
//
//  Created by 冯超 on 2018/6/21.
//

#import "ALNetworkHelper.h"
#import <objc/runtime.h>
@implementation ALNetworkHelper


+(void)extend:(NSDictionary**)origin target:(NSDictionary*) target{
    NSMutableDictionary* muteOrigin =  (*origin).mutableCopy;
    [muteOrigin addEntriesFromDictionary:target];
    *origin = muteOrigin.copy;
}

+(NSString*)resolveHttpUrl:(NSString*)url host:(NSString*)host{
    if([url hasPrefix:@"http"]){
        return url;
    }else{
        if(![url hasPrefix:@"/"]){
            url=[NSString stringWithFormat:@"/%@",url];
        }
        return [NSString stringWithFormat:@"%@%@",host,url];
    }
}

// 1. 根据protocol获取接口方法
+(void)exportServiceAPI:(Class)clazz{
    unsigned int count;
    unsigned int num;
    Protocol * __unsafe_unretained *serviceList = class_copyProtocolList([clazz class], &count);//获取某个class的所有protocol
    for (int i = 0; i < count; i++) {
        Protocol *pro = serviceList[i];
        struct objc_method_description* methodList = protocol_copyMethodDescriptionList(pro, YES, YES, &num);//获取某个protocol下所有的方法
        for(int j= 0; j < num; j++){
            struct objc_method_description methodDescription = methodList[j];
            NSLog(@"Method #%d: %@", i, NSStringFromSelector(methodDescription.name));
            NSLog(@"Method #%d: %@", i, [NSString stringWithCString:methodDescription.types encoding:NSUTF8StringEncoding]);
        }
        free(methodList);
    }
    free(serviceList);
}

@end
