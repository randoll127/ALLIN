//
//  ALNetworkHelper.h
//  allin
//
//  Created by 冯超 on 2018/6/21.
//

#import <Foundation/Foundation.h>

@interface ALNetworkHelper : NSObject
+(void)extend:(NSDictionary**)origin target:(NSDictionary*) target;
+(NSString*)resolveHttpUrl:(NSString*)url host:(NSString*)host;
@end
