#import "ALNetworkHttpCall.h"
#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>
#import <allin/ALBaseMacro.h>
#import "ALNetworkHttpSessionFactory.h"
#import "ALNetwork.h"
#import "ALNetworkHelper.h"
#import "ALNetworkPath.h"
#import "ALNetworkConfig.h"
#import "ALNetworkMacro.h"

@interface ALNetworkHttpCall(){
    ALNetworkHttpSessionFactory* sessionFactory;
    NSMutableURLRequest* mRequest;
}
@property ALNetworkConfig* Config;

@end


@implementation ALNetworkHttpCall


+(ALNetworkCall*)intercept:(NSString*)returnType{
    if([returnType isEqualToString:@"Call"]){
        return [self class].new;
    }
    return nil;
}
-(instancetype)init{
    self = [super init];
    sessionFactory = [ALNetworkHttpSessionFactory sharedInstance];
    self.Config = ALNetworkConfig.new;
    return self;
}

- (Config)url{
    return ^(NSString* _url){
        self.Config.url = _url;
        return self;
    };
}

- (Config)headers{
    return ^(NSDictionary* _headers){
        self.Config.headers = _headers;
        return self;
    };
}

-(Config)extendHeaders{
    return ^(NSDictionary* _headers){
        NSDictionary* srcDic = self.Config.headers?:@{};
        [ALNetworkHelper extend:&srcDic target:_headers];
        self.Config.headers = srcDic;
        return self;
    };
}

-(Config)timeout{
    return ^(NSNumber* _timeout){
        self.Config.timeOut = _timeout;
        return self;
    };
}

-(Config)method{
    return ^(NSString* _method){
        self.Config.method = _method;
        return self;
    };
}

-(Config)requestType{
    return ^(NSString* _requestType){
        self.Config.requestType = _requestType;
        return self;
    };
}


-(Config)responseType{
    return ^(NSString* _responseType){
        self.Config.responseType = _responseType;
        return self;
    };
}

-(Config)responseClass{
    return ^(NSString* _responseClass){
        self.Config.responseClass = _responseClass;
        return self;
    };
}

/*
 {
 method = @"GET";
 path = "<ALNetworkPath:>";
 requestHeaders = @{ @"headerKey1":@"headerVal1"}   //header key-value键值对，最后会塞入对应的request中
 requestKey = @[@"key1",@"key2"];                   //请求的key ，来自于 @ParameterKey宏  以及path中的参数形式
 requestValue = @[@"value1",@"value2"]              //请求的value ，来自于实际调用方法的值，声明方法时候要和key 一一对应  以及path中的参数形式
 returnType = @"Call";                              //返回给外部调用者的类 用于发起实际请求，目前默认是Call对应HttpCall
 timeout=@"1000"
 }
 
 */

-(void)buildRequest:(NSDictionary*)dict{
    ALNetwork* center = [ALNetwork sharedInstance];
    AFHTTPRequestSerializer *requestSer = nil;
    AFHTTPResponseSerializer *responseSer = nil;
    //step1: 设置url
    ALNetworkPath* path = dict[kHttpPath];
    NSArray* requestValue = (dict[kHttpParamsVal]?:@[]);
    NSString* realPath = [path parseUrlWithValues:requestValue];
    ALLOG(dict);
    NSString* absoluteUrl = [ALNetworkHelper resolveHttpUrl:realPath host:center.Config.host];
    
    //step2: 设置超时时间
    NSString* timeout = dict[kTimeout];
    NSInteger timeoutinterval = timeout?timeout.integerValue:center.Config.timeOut.integerValue;
    [requestSer setTimeoutInterval:timeoutinterval];
    
    //step3: 设置自定义header
    NSDictionary* headers  = dict[kHttpHeaders]?:@{};
    NSDictionary* defaultHeaders = center.Config.headers;
    [ALNetworkHelper extend:&headers target:defaultHeaders];
    for (NSString *key in headers) {
        [requestSer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
    }
    //step4: 设置httpMethod
    NSString* method = dict[kHttpMethod]?:@"GET";
    
    //step5:requestType
    NSString* requestType = dict[kRequestType]?:@"FORM";
    if([requestType isEqualToString:@"JSON"]){
        requestSer = AFJSONRequestSerializer.new;
    }else{
        requestSer = AFHTTPRequestSerializer.new;
    }
    
    //step6:responseType
    NSString* responseType = dict[kResponseType]?:@"";
    if([responseType isEqualToString:@"JSON"]){
        responseSer = AFJSONResponseSerializer.new;
    }else{
        responseSer = AFHTTPResponseSerializer.new;
    }
    [sessionFactory sessionResponseSer:responseSer];
    
    
    //step7:responseClass
    NSString* responseClass = dict[kResponseClass];
    if(!responseClass||![NSClassFromString(responseClass) isSubclassOfClass:JSONModel.class]){
        responseClass = nil;
    }
    
    
    //step8: 设置实际参数
    self.url(absoluteUrl)
        .timeout(timeout)
        .headers(headers)
        .method(method)
        .requestType(requestType)
        .responseType(responseType)
        .responseClass(responseClass);
    
    //step7: 设置url的parameters
    NSArray* keys = dict[kHttpParamsKey];
    NSInteger offset = path.keyParams.count;
    NSMutableDictionary* parameters = @{}.mutableCopy;
    [keys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx>=offset) [parameters setObject:requestValue[idx] forKey:key] ;
    }];
    
    //step8: 创建serializer -> MutableRequest
    NSError* error;
    mRequest = [requestSer requestWithMethod:self.Config.method URLString:self.Config.url parameters:parameters error:&error];
}



-(NSURLSessionDataTask*) callWithSuccess:(ServiceSuccess)success
                         failure:(ServiceFailure)failure
                         complete:(ServiceComplete)complete{
    ServiceSuccess successHook =success;
    if(self.Config.responseClass){
        __weak NSString* __responseClass = self.Config.responseClass;
        successHook = ^(NSURLResponse * urlResponse, id responseObject){
            responseObject = [[NSClassFromString(__responseClass) alloc]initWithDictionary:responseObject error:nil];
            success(urlResponse,responseObject);
        };
    }
    NSURLSessionDataTask* dataTask = [sessionFactory taskWithRequest:mRequest success:successHook failure:failure complete:complete];
    [dataTask resume];
    return dataTask;
}

ALDEALLOC_LOG
@end
