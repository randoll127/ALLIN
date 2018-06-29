#import <Foundation/Foundation.h>

@class ALNetworkCall;
@protocol UserServiceProtocol
//很关键，一定要加，为了防止一些警告
@optional
-(ALNetworkCall*)getVersion:(NSString*)v v:(NSString*)v2 os:(NSString*)os version:(NSString*)version;

-(ALNetworkCall*)getV:(NSString*)v2 os:(NSString*)os version:(NSString*)version;

@end
