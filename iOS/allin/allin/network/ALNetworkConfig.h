//
//  ALNetworkConfig.h
//  allin
//
//  Created by 冯超 on 2018/6/27.
//

#import <Foundation/Foundation.h>

@interface ALNetworkConfig : NSObject
@property (nonatomic, strong) NSString *host;  // domain地址
@property (nonatomic, strong) NSDictionary *headers; //通用headers
@property (nonatomic, strong) NSNumber *timeOut;

@property (nonatomic, strong) NSString *url;  // url请求地址
@property (nonatomic, strong) NSString *method;  //方法
@property (nonatomic, strong) NSString *requestType;  //请求的类型
@property (nonatomic, strong) NSString *responseType;  //返回类型
@property (nonatomic, strong) NSString *responseClass;  //返回具体的Class映射，并且强制设置responseType=JSON
@end
