#import "ALNetworkHttpSessionFactory.h"
#import "ALNetwork.h"
#import <AFNetworking/AFNetworking.h>
@interface ALNetworkHttpSessionFactory(){
    AFHTTPSessionManager* sessionManager;
}
@end

@implementation ALNetworkHttpSessionFactory
+ (instancetype)sharedInstance{
    static ALNetworkHttpSessionFactory *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    sessionManager =[[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://"]];
    if([ALNetwork sharedInstance].securityPolicyBlock){
        AFSecurityPolicy* policy = [ALNetwork sharedInstance].securityPolicyBlock();
        if(policy){
            [sessionManager setSecurityPolicy:policy];
        }
    }
   
    return self;
}

-(void)sessionSecurityPolicy:(AFSecurityPolicy*)policy{
    [sessionManager setSecurityPolicy:policy];
}

-(void)sessionResponseSer:(AFHTTPResponseSerializer*)responseSerializer{
    [sessionManager setResponseSerializer:responseSerializer];
}



-(NSURLSessionDataTask*) taskWithRequest:(NSMutableURLRequest*)request
                                 success:(ServiceSuccess)success
                                 failure:(ServiceFailure)failure
                                complete:(ServiceComplete)completion{
    NSURLSessionDataTask *dataTask = nil;
    dataTask = [sessionManager dataTaskWithRequest:request
                                    uploadProgress:nil
                                  downloadProgress:nil
                                 completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                     if (error) {
                                         failure(response,responseObject,error);
                                     } else {
                                         success(response,responseObject);
                                     }
                                     if (completion) {
                                         completion(response, responseObject, error);
                                     }
                                 }];
    return dataTask;
}


@end
