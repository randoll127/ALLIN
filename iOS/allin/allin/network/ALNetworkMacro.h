#import "ALBaseMacro.h"
#import "ALNetworkPath.h"
#ifndef ALNetworkMacro_h
#define ALNetworkMacro_h

/*
 {
     method = @"GET";
     path = "<ALNetworkPath:>";
     requestHeaders = @{ @"headerKey1":@"headerVal1"}   //header key-value键值对，最后会塞入对应的request中
     requestKey = @[@"key1",@"key2"];                   //请求的key ，来自于 @ParameterKey宏  以及path中的参数形式
     requestValue = @[@"value1",@"value2"]              //请求的value ，来自于实际调用方法的值，声明方法时候要和key 一一对应  以及path中的参数形式
     returnType = @"Call";                              //返回给外部调用者的类 用于发起实际请求，目前默认是Call对应HttpCall
 }
 
 */


#define kHttpPath @"path"
#define kHttpMethod @"method"           // GET;POST
#define kTimeout @"timeout"
#define kHttpHeaders @"requestHeaders"

#define kRequestType @"requestType"  //FORM default; JSON
#define kResponseType @"responseType"
#define kResponseClass @"responseClass"
#define kHttpParamsKey @"requestKey"
#define kHttpParamsVal @"requestValue"
#define kReturnType @"returnType"


#define BEGIN \
NSMutableDictionary *apiParams = [NSMutableDictionary dictionary]; \
NSMutableArray *requestParams = [NSMutableArray array]; \
NSMutableDictionary *requestHeaders = [NSMutableDictionary dictionary]; 

#define END \
[apiParams setValue:requestParams forKey:kHttpParamsKey]; \
[apiParams setValue:requestHeaders forKey:kHttpHeaders]; \
return [apiParams copy];

#define RequestType(type) \
allin_keywordify \
[apiParams setValue:@__STRING(type) forKey:kRequestType];

#define ResponseType(type) \
allin_keywordify \
[apiParams setValue:@__STRING(type) forKey:kResponseType];

#define ResponseClass(type) \
allin_keywordify \
[apiParams setValue:@__STRING(type) forKey:kResponseClass];\
[apiParams setValue:@__STRING(JSON) forKey:kResponseType];


#define ReturnType(type) \
allin_keywordify \
[apiParams setValue:@__STRING(type) forKey:kReturnType];

#define Method(type) \
allin_keywordify \
[apiParams setValue:@__STRING(type) forKey:kHttpMethod];

#define Timeout(timeout) \
allin_keywordify \
[apiParams setValue:@__STRING(timeout) forKey:kTimeout];

#define Path(path) \
allin_keywordify \
ALNetworkPath *orPath = [[ALNetworkPath alloc] initWithPath:@__STRING(path)]; \
[apiParams setValue:orPath forKey:kHttpPath]; \
for (NSString *comp in [orPath parseParams]) { \
[requestParams addObject:comp];\
} \



#define ParameterKey(paramName) \
allin_keywordify \
[requestParams addObject:@__STRING(paramName)];

#define Header(key,value) \
allin_keywordify \
[requestHeaders setValue:@__STRING(value) forKey:@__STRING(key)]; \


//可以不使用lineNumber，但是考虑之后可以串联
#define EXPORT_API(selName) \
class ALNetwork; \
+(NSDictionary *)AL_CONCAT(AL_CONCAT(al_private_api_,selName),__LINE__) \



#endif /* ALNetworkMacro_h */
