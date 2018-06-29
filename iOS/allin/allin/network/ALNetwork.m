#import "ALNetwork.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "ALNetworkMacro.h"
#import "ALNetworkCall.h"
#import "ALNetworkConfig.h"
#import <ReactiveObjC/ReactiveObjC.h>
@implementation ALNetwork
+ (ALNetwork *)sharedInstance{
    static ALNetwork *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
    });
    return sharedInstance;
}

-(instancetype)init{
    self = [super init];
    self.Config = ALNetworkConfig.new;
    return self;
}

- (ConfigSetting)baseURL{
    return ^(NSString* host){
        self.Config.host = host;
        return self;
    };
}
- (ConfigSetting)requestTimeOut{
    return ^(NSNumber *time){
        self.Config.timeOut = time;
        return self;
    };
}

- (ConfigSetting)headers{
    return ^(NSDictionary *headers){
        self.Config.headers=headers;
        return self;
    };
}


- (ConfigSetting)callFactories{
    return ^(NSArray *callFactories){
        self.callAdapters = callFactories;
        return self;
    };
}
-(ALNetwork*(^)(ALSecurityPolicy))securityPolicy{
    @weakify(self)
    return ^(ALSecurityPolicy block){
        @strongify(self)
        self.securityPolicyBlock = block;
        return self;
    };
}

//- (ConfigSetting)requestAdaptorFactories{
//    return ^(NSArray<id<ORRequestAdaptorFactoryProtocol>> *adaptorFactories){
//        self.requestFactories = adaptorFactories;
//        return self;
//    };
//}
//
//- (ConfigSetting)responseAdaptorFactories{
//    return ^(NSArray<id<ORResponseAdaptorFactoryProtocol>> *adaptorFactories){
//        self.responseFactories = adaptorFactories;
//        return self;
//    };
//}





//
//- (ConfigSetting)sessionTaskFactory{
//    return ^(OrtroSessionTaskFactory *taskFactory){
//        self.taskFactory = taskFactory;
//        return self;
//    };
//}


//-(void)







+(void)exportServiceAPI:(Class)clazz{
    unsigned int count;
    unsigned int num;
    swizzleForwardInvocation(clazz);
    Protocol * __unsafe_unretained *serviceList = class_copyProtocolList([clazz class], &count);//获取某个class的所有protocol
    for (int i = 0; i < count; i++) {
        Protocol *pro = serviceList[i];
        struct objc_method_description* methodList = protocol_copyMethodDescriptionList(pro, NO, YES, &num);//获取某个protocol下所有的方法
        for(int j= 0; j < num; j++){
            struct objc_method_description methodDescription = methodList[j];
            ALLOG_FORMAT(@"Method #%d: %@", i, NSStringFromSelector(methodDescription.name));
            ALLOG_FORMAT(@"Method #%d: %@", i, [NSString stringWithCString:methodDescription.types encoding:NSUTF8StringEncoding]);
            class_replaceMethod(clazz,methodDescription.name, (IMP)getMsgForwardIMP(methodDescription.types, methodDescription.name),methodDescription.types);
            
        }
        free(methodList);
    }
    free(serviceList);
}

static void swizzleForwardInvocation(Class klass) {
    class_replaceMethod(klass, @selector(forwardInvocation:), (IMP)__BEGIN_FORWARD_INVOCATION_CALLED__, "v@:@");
}

static IMP getMsgForwardIMP(const char *encoding, SEL selector) {
    IMP msgForwardIMP = _objc_msgForward;
#if !defined(__arm64__)
//    Method method = class_getInstanceMethod(self.class, selector);
//    const char *encoding = method_getTypeEncoding(method);
    BOOL methodReturnsStructValue = encoding[0] == _C_STRUCT_B;
    if (methodReturnsStructValue) {
        @try {
            NSUInteger valueSize = 0;
            NSGetSizeAndAlignment(encoding, &valueSize, NULL);

            if (valueSize == 1 || valueSize == 2 || valueSize == 4 || valueSize == 8) {
                methodReturnsStructValue = NO;
            }
        } @catch (__unused NSException *e) {}
    }
    if (methodReturnsStructValue) {
        msgForwardIMP = (IMP)_objc_msgForward_stret;
    }
#endif
    return msgForwardIMP;
}

//selector is forwardInvocation:  invocation.selector is API getUser:
static void __BEGIN_FORWARD_INVOCATION_CALLED__(__unsafe_unretained NSObject *self, SEL selector, NSInvocation *invocation) {
    Class clazz = [self class];
    Method method  = class_getInstanceMethod(clazz, invocation.selector);
    NSMethodSignature *methodSignature =[NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
    //1. 获得注解的参数配置
    NSDictionary* dic = [ALNetwork annonation:clazz selectorStr:NSStringFromSelector(invocation.selector)];
    NSMutableArray *parameterValue = [NSMutableArray array];
    NSMutableDictionary* requestAllParams = dic.mutableCopy;
    //2. 获取对应的参数value
    for (int i = 2; i < [methodSignature numberOfArguments]; i++) {
        id __weak value;
        [invocation getArgument:&value atIndex:i];
        ALLOG_FORMAT(@"%@",value);
        [parameterValue addObject:value?:[NSNull null]];
    }
    [requestAllParams setValue:parameterValue forKey:kHttpParamsVal];
    
    
   id __autoreleasing newRet = [[ALNetwork sharedInstance] adapterCall:requestAllParams];
    [invocation setReturnValue:&newRet];
//
//    id  ret = nil;
//    [invacationHandler invokeWith:realMethod params:[parameterValues copy] result:&ret];
//    id __autoreleasing newRet = ret;
//    id __autoreleasing newRet = requestAllParams;
    
    
    
    
//    [invocation retainArguments];
}


+(id)annonation:(Class)clazz selectorStr:(NSString*)selectorStr{
    NSDictionary *apiAnnotations = nil;
    NSString* alPrivateSelectorStr = [NSString stringWithFormat:@"al_private_api_%@",[selectorStr stringByReplacingOccurrencesOfString:@":" withString:@"_"]];
    unsigned int count;
    Method *methodLists = class_copyMethodList(object_getClass(clazz), &count);
    for (int i = 0; i < count; i++) {
        NSString* method = NSStringFromSelector(method_getName(methodLists[i]));
        SEL selector = NSSelectorFromString(alPrivateSelectorStr);
        if ([method hasPrefix:alPrivateSelectorStr]) {
            apiAnnotations  = ((NSDictionary*(*)(id, SEL))method_getImplementation(methodLists[i]))(clazz,selector);
            break;
        }
    }
    free(methodLists);
    
    return apiAnnotations;
    //    switch (analyzeType) {
    //        case AnalyzeTypeAnnatations:{
    //            NSMutableDictionary *mAnnotations = apiAnnotations.mutableCopy;
    //            [mAnnotations removeObjectForKey:kHttpParamsKey];
    //            return [mAnnotations copy];
    //        }
    //            break;
    //        case AnalyzeTypeParameterAnnatation:{
    //            return [apiAnnotations objectForKey:kHttpParamsKey];
    //        }
    //            break;
    //    }
    //    return nil;
}

-(ALNetworkCall*)adapterCall:(NSDictionary*)params{
    for(Class adapter in self.callAdapters){
        ALNetworkCall* call  = [adapter intercept:[params objectForKey:kReturnType]];
        [call buildRequest:params];
        if(call) return call;
    }
    return nil;
}
ALDEALLOC_LOG
@end
