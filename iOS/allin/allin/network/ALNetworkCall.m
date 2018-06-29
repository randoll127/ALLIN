#import "ALNetworkCall.h"
#import "AFHTTPSessionManager.h"

@interface ALNetworkCall(){
    AFHTTPSessionManager* session;
}

@end

@implementation ALNetworkCall
+(ALNetworkCall*)intercept:(NSString*)returnType{
    return nil;
}

-(void)buildRequest:(NSDictionary*)dict{
    @throw [NSException exceptionWithName:@"SubClass error" reason:@"buildRequest: need to be implemented by subclass" userInfo:nil];
}

-(NSURLSessionDataTask*) callWithSuccess:(ServiceSuccess)success
                                 failure:(ServiceFailure)failure
                                complete:(ServiceComplete)complete{
    @throw [NSException exceptionWithName:@"SubClass error" reason:@"callWithSuccess:failure:complete need to be implemented by subclass" userInfo:nil];
}


@end
