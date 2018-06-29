//
//  ALNetworkHttpCall.h
//  allin
//
//  Created by 冯超 on 2018/6/26.
//

#import "ALNetworkCall.h"

@class ALNetworkHttpCall;
typedef ALNetworkHttpCall*(^Config)(id param);

@interface ALNetworkHttpCall : ALNetworkCall

-(Config)url;
-(Config)headers;
-(Config)extendHeaders;
-(Config)method;
-(Config)requestType;
-(Config)responseType;
-(Config)responseClass;
-(Config)timeout;


@end
