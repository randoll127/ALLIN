#import <Foundation/Foundation.h>

//@protocol ALNetworkCallProtocol<NSObject>
//+(id<ALNetworkCallProtocol>)intercept:(NSString*)returnType;
//@end

typedef void(^ServiceSuccess)(NSURLResponse * urlResponse, id responseObject);
typedef void(^ServiceFailure)(NSURLResponse * urlResponse, id responseObject, NSError *error);
typedef void(^ServiceComplete)(NSURLResponse * urlResponse, id responseObject, NSError *error);

@interface ALNetworkCall : NSObject


+(ALNetworkCall*)intercept:(NSString*)returnType;
-(void)buildRequest:(NSDictionary*)dict;
-(NSURLSessionDataTask*) callWithSuccess:(ServiceSuccess)success
                                 failure:(ServiceFailure)failure
                                complete:(ServiceComplete)complete;
@end
