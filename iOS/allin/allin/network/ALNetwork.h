#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>


@class ALNetwork;
@class ALNetworkCall;
@class ALNetworkConfig;

typedef ALNetwork*(^ConfigSetting)(id param);
typedef AFSecurityPolicy*(^ALSecurityPolicy)(void);


@interface ALNetwork : NSObject

@property (nonatomic, strong) ALNetworkConfig *Config;
@property (nonatomic, strong) NSArray<ALNetworkCall*>* callAdapters;
@property ALSecurityPolicy securityPolicyBlock;

//@property (nonatomic, strong) NSArray *requestFactories;
//@property (nonatomic, strong) NSArray *responseFactories;

//@property (nonatomic, strong) OrtroSessionTaskFactory *taskFactory;


//@property (nonatomic, strong) NSMutableDictionary *serviceMethodCache;//???



+ (ALNetwork *)sharedInstance;

- (ConfigSetting)baseURL;
- (ConfigSetting)headers;
- (ConfigSetting)requestTimeOut;
- (ConfigSetting)callFactories;
- (ALNetwork*(^)(ALSecurityPolicy))securityPolicy;


//- (ConfigSetting)requestAdaptorFactories;
//
//- (ConfigSetting)responseAdaptorFactories;
//
//- (ConfigSetting)sessionTaskFactory;
//






//+(id)annonation:(Class)clazz selectorStr:(NSString*)selectorStr;

+(void)exportServiceAPI:(Class)clazz;
@end
