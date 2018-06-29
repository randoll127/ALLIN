#import "ALNetworkSessionFactory.h"
#import "ALNetwork.h"
#import <AFNetworking/AFNetworking.h>
@interface ALNetworkSessionFactory(){
    AFURLSessionManager* sessionManager;
}
@end


@implementation ALNetworkSessionFactory
+ (instancetype)sharedInstance{
    static ALNetworkSessionFactory *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    sessionManager =AFURLSessionManager.new;
    return self;
}

- (instancetype)initWithCetner:(ALNetwork*)center{
    self = [super init];
    if (self) {
//        sessionManager = [[AFURLSessionManager alloc] init];
//        alnetwork = center;
//        AFHTTPResponseSerializer *responseSer = [AFHTTPResponseSerializer new];
//        sessionManager = [AFHTTPSessionManager manager];
        //setCommonSecurity
//        [sessionManager setSecurityPolicy:self.securityPolicy];
//        [sessionManager setResponseSerializer:responseSer];
        //setCommonHeader
        
    }
    return self;
}



//-(AFSecurityPolicy*)securityPolicy{
//#ifdef DEBUG
//    AFSecurityPolicy* securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    [securityPolicy setAllowInvalidCertificates:YES];
//    [securityPolicy setValidatesDomainName:NO];
//#else
//    AFSecurityPolicy* securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    [securityPolicy setAllowInvalidCertificates:NO];
//    [securityPolicy setValidatesDomainName:YES];
//#endif
//    return securityPolicy;
//}

//-(NSURLSessionDataTask*) request:(NSString*)url
//                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
//    //Set RequestSerialize
//    AFHTTPRequestSerializer *requestSer = [AFHTTPRequestSerializer new];
//    // 设置超时时间
//    NSTimeInterval timeoutinterval = alnetwork.alTimeOut;
//    [requestSer setTimeoutInterval:timeoutinterval];
//    //自定义header
//    NSDictionary* headers = alnetwork.alHeaders;
//    for (NSString *key in headers) {
//        [requestSer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
//    }
////    NSError *error = nil;
////    NSMutableURLRequest *request = [requestSer requestWithMethod:@"GET" URLString:url parameters:parameters error:&error];
////    if (error) {
////        completion(nil, nil, error);
////        return nil;
////    }
////    NSURLSessionDataTask *dataTask = nil;
////    dataTask = [sessionManager dataTaskWithRequest:request
////                                    uploadProgress:uploadProgress
////                                  downloadProgress:downloadProgress
////                                 completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
////                                     if (error) {
////                                         //                                         if (error.code != NSURLErrorCancelled) { // cancel 不走用失败回调
////                                         completion(dataTask, responseObject, error);
////                                         //                                         }
////                                     } else {
////                                         if (completion) {
////                                             completion(dataTask, responseObject, nil);
////                                         }
////                                     }
////                                 }];
////    return nil;
//}
//
//
//- (NSURLSessionDataTask *)request:(NSString *)url
//                           method:(NSString*)method
//                          headers:(NSDictionary*)headers
//                       parameters:(id)parameters
//                          success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                          failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
//    return [self request:url method:method headers:headers parameters:parameters uploadProgress:^(NSProgress *uploadProgress) {
//    } downloadProgress:^(NSProgress *downloadProgress) {
//    } completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
//        if (error) {
//            if (failure) {
//                failure(task, error);
//            }
//        } else {
//            if (success) {
//                success(task, responseObject);
//            }
//        }
//    }];
//}
//
//
//
//-(NSURLSessionDataTask*) request:(NSString*)url
//                          method:(NSString*)method
//                         headers:(NSDictionary*)headers
//                      parameters:(id)parameters
//                  uploadProgress:(void (^)(NSProgress *uploadProgress)) uploadProgress
//                downloadProgress:(void (^)(NSProgress *downloadProgress)) downloadProgress
//                      completion:(void (^)(NSURLSessionDataTask *task, id responseObject, NSError *error))completion{
//    //Set RequestSerialize
//    AFHTTPRequestSerializer *requestSer = [AFHTTPRequestSerializer new];
//    // 设置超时时间
//    NSInteger timeoutinterval = 15;
//    [requestSer setTimeoutInterval:timeoutinterval];
//    //自定义header
//    //设置请求头部
//    for (NSString *key in headers) {
//        [requestSer setValue:[headers objectForKey:key] forHTTPHeaderField:key];
//    }
//    [sessionManager setRequestSerializer:requestSer];
//    NSError *error = nil;
//    NSMutableURLRequest *request = [sessionManager.requestSerializer requestWithMethod:method URLString:url parameters:parameters error:&error];
//    if (error) {
//        completion(nil, nil, error);
//        return nil;
//    }
//    NSURLSessionDataTask *dataTask = nil;
//    dataTask = [sessionManager dataTaskWithRequest:request
//                                         uploadProgress:uploadProgress
//                                       downloadProgress:downloadProgress
//                                      completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
//                                          if (error) {
//                                              //                                         if (error.code != NSURLErrorCancelled) { // cancel 不走用失败回调
//                                              completion(dataTask, responseObject, error);
//                                              //                                         }
//                                          } else {
//                                              if (completion) {
//                                                  completion(dataTask, responseObject, nil);
//                                              }
//                                          }
//                                      }];
//    [dataTask resume];
//    return dataTask;
//}
@end
