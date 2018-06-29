#import "ALNetworkSessionFactory.h"
#import "ALNetworkCall.h"
#import <AFNetworking/AFNetworking.h>
@interface ALNetworkHttpSessionFactory : ALNetworkSessionFactory
-(NSURLSessionDataTask*) taskWithRequest:(NSMutableURLRequest*)request
                                 success:(ServiceSuccess)success
                                 failure:(ServiceFailure)failure
                                complete:(ServiceComplete)completion;

-(void)sessionSecurityPolicy:(AFSecurityPolicy*)policy;
-(void)sessionResponseSer:(AFHTTPResponseSerializer*)responseSerializer;
@end
