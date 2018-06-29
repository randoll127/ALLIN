//
//  ALAppDelegate.m
//  allin
//
//  Created by 冯超 on 05/31/2018.
//  Copyright (c) 2018 冯超. All rights reserved.
//

#import "ALAppDelegate.h"
#import "UserService.h"
#import "UserServiceProtocol.h"
#import <objc/runtime.h>
#import <allin/ALNetwork.h>
#import <allin/ALNetworkMethod.h>
#import <allin/ALNetworkCall.h>
#import <allin/ALNetworkHttpCall.h>
#import <allin/ALNetworkHelper.h>
#import <allin/ALBaseMacro.h>
#import "MySecurityPolicy.h"
#import "UserModel.h"
@implementation ALAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    NSDictionary* dic = @{@"a":@"1",@"b":@2};
    NSDictionary* dic2 = @{@"a2":@"1",@"b":@3};
    
   
    
    
//    NSMutableDictionary* muteDic =  dic.mutableCopy;
//    [muteDic addEntriesFromDictionary:dic2];
//
//    dic = muteDic.copy;
    
    NSLog(@"%@",dic);
    
//    NSDictionary* dic = @{@"a":@"1",@"b":@2};
//    NSDictionary* dic2 = @{@"a2":@"1",@"b":@3};
//    NSMutableDictionary* originCopy = origin.mutableCopy;
//    [originCopy addEntriesFromDictionary:target];
//    origin =
    
    [ALNetwork exportServiceAPI:[UserService class]];
//    https://ms.lu.com/
    ALNetwork* alNetwork = [ALNetwork sharedInstance]
                    .callFactories(@[ALNetworkHttpCall.class,NSDictionary.class])
                    .baseURL(@"https://ms.lu.com")
                    .securityPolicy(^AFSecurityPolicy*(void){
                    #ifndef DEBUG
                            AFSecurityPolicy* securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
                            [securityPolicy setAllowInvalidCertificates:YES];
                            [securityPolicy setValidatesDomainName:NO];
                    #else
                            //MySecurityPolicy 要读取到自己主项目的bundle的cer要继承实现一个
                            MySecurityPolicy* securityPolicy = [MySecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
                            [securityPolicy setAllowInvalidCertificates:NO];
                            [securityPolicy setValidatesDomainName:YES];
                    #endif
                            return securityPolicy;
                    });
//    v=5.1.5.1&os=iOS&version=5.1.5.1
    id<UserServiceProtocol> service = UserService.new;
    [[service getV:@"5.1.5.1" os:@"iOS" version:@"5.1.5.1"] callWithSuccess:^(NSURLResponse *urlResponse, UserModel* responseObject) {
        ALLOG(responseObject);
    } failure:^(NSURLResponse *urlResponse, id responseObject, NSError *error) {
        NSLog(@"2");
    } complete:^(NSURLResponse *urlResponse, id responseObject, NSError *error) {
        NSLog(@"3");
    }];
    
    
//    [call reload];
//    [service method2];
//    NSString* s =  [service method1:@"123"];
//    NSLog(@"%@",s);
    
//   NSDictionary* dic =  [ALNetworkMethod annonation:NSClassFromString(@"UserService") selectorStr:@"getUser:"];
//    NSLog(@"%@",dic2);
    //    [service performSelector:NSSelectorFromString(@"method1")];
    
    
    //    unsigned int count; // 1
    //    unsigned int num;
    //    Protocol * __unsafe_unretained *list = class_copyProtocolList([UserService class], &count); // 2
    //    for (int i = 0; i < count; i++) { // 3
    //        Protocol *pro = list[i]; // 4
    //        struct objc_method_description* methods = protocol_copyMethodDescriptionList(pro, NO, YES, &num);
    //        for(int j=0;j<num;j++){
    //            struct objc_method_description methodDescription = methods[j]; // 4
    //             NSLog(@"Method #%d: %@", i, NSStringFromSelector(methodDescription.name));
    //            NSLog(@"Method #%d: %@", i, [NSString stringWithCString:methodDescription.types encoding:NSUTF8StringEncoding]);
    //
    //        }
    //
    //
    //        NSLog(@"%@", NSStringFromProtocol(pro)); // 5
    //    } // 6
    //    free(list); // 7
    
    
    /*
     2018-06-21 17:53:35.112721+0800 allin_Example[59546:22313032] Method #0: method1:
     2018-06-21 17:53:35.112935+0800 allin_Example[59546:22313032] Method #0: v24@0:8@16
     2018-06-21 17:53:35.113161+0800 allin_Example[59546:22313032] Method #0: method2
     2018-06-21 17:53:35.113328+0800 allin_Example[59546:22313032] Method #0: v16@0:8
     
     2018-06-21 17:59:12.484884+0800 allin_Example[59919:22330898] Method #0: v24@0:8@16
     2018-06-21 17:59:12.485436+0800 allin_Example[59919:22330898] method1:
     2018-06-21 17:59:12.485930+0800 allin_Example[59919:22330898] Method #1: v16@0:8
     2018-06-21 17:59:12.486732+0800 allin_Example[59919:22330898] method2
     */
    
    
    
    //      unsigned int num;
    //    Method *methodList = class_copyMethodList([UserService class], &num);
    //    for (int i = 0; i < num; i++) {
    //        Method method = methodList[i];
    //        SEL selName = method_getName(method);
    //        const char* typeEncoding = method_getTypeEncoding(method);
    //         NSLog(@"Method #%d: %@", i, [NSString stringWithCString:typeEncoding encoding:NSUTF8StringEncoding]);
    //        NSLog(@"%@",NSStringFromSelector(selName));
    //        Method targetMethod = class_getInstanceMethod([UserService class], NSSelectorFromString(@"method2"));
    //        IMP targetMethodIMP = method_getImplementation(targetMethod);
    //        class_replaceMethod([UserService class],selName, targetMethodIMP,typeEncoding);
    ////
    ////        break;
    //    }
    
    //
    //    UserService* service = UserService.new;
    //    [service performSelector:NSSelectorFromString(@"method1")];
    
    
    // Override point for customization after application launch.
//    NSScanner *scanner = [NSScanner scannerWithString:@"hell/{abc}/{def}>/ss"];
//    NSMutableArray* params = @[].mutableCopy;
//    while (![scanner isAtEnd]) {
//        NSString* valueStr = nil;
//        [scanner scanUpToString:@"{" intoString:nil];
//        [scanner scanUpToString:@"}" intoString:&valueStr];
//        if(valueStr&&valueStr.length>0){
//            [params addObject:[valueStr substringFromIndex:1]];
//        }
//    }
//    NSLog(@"%@",params.copy);
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
