#import "ALBaseCookieHelper.h"


@implementation ALBaseCookieHelper {
    HTTPDNSCookieFilter cookieFilter;
}

+ (instancetype)sharedInstance {
    static id singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!singletonInstance) {
            singletonInstance = [[super allocWithZone:NULL] init];
        }
    });
    return singletonInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return self;
}

- (void)setCookieFilter:(HTTPDNSCookieFilter)filter {
    if (filter != nil) {
        cookieFilter = filter;
    }
}

//NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//[cookieProperties setObject:@"username" forKey:NSHTTPCookieName];
//[cookieProperties setObject:@"rainbird" forKey:NSHTTPCookieValue];
//[cookieProperties setObject:@"cnrainbird.com" forKey:NSHTTPCookieDomain];
//[cookieProperties setObject:@"cnrainbird.com" forKey:NSHTTPCookieOriginURL];
//[cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//[cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];

//NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//[[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];


- (NSArray<NSHTTPCookie *> *)handleHeaderFields:(NSDictionary *)headerFields forURL:(NSURL *)URL {
    NSArray *cookieArray = [NSHTTPCookie cookiesWithResponseHeaderFields:headerFields forURL:URL];
    if (cookieArray != nil) {
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *cookie in cookieArray) {
            if (cookieFilter(cookie, URL)) {
                NSLog(@"Add a cookie: %@", cookie);
                [cookieStorage setCookie:cookie];
            }
        }
    }
    return cookieArray;
}

- (NSString *)getRequestCookieHeaderForURL:(NSURL *)URL {
    NSArray *cookieArray = [self searchAppropriateCookies:URL];
    if (cookieArray != nil && cookieArray.count > 0) {
        NSDictionary *cookieDic = [NSHTTPCookie requestHeaderFieldsWithCookies:cookieArray];
        if ([cookieDic objectForKey:@"Cookie"]) {
            return cookieDic[@"Cookie"];
        }
    }
    return nil;
}

- (NSArray *)searchAppropriateCookies:(NSURL *)URL {
    NSMutableArray *cookieArray = [NSMutableArray array];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        if (cookieFilter(cookie, URL)) {
            NSLog(@"Search an appropriate cookie: %@", cookie);
            [cookieArray addObject:cookie];
        }
    }
    return cookieArray;
}

- (NSArray *)displayAllCookie{
    NSMutableArray *cookieArray = [NSMutableArray array];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
            NSLog(@"Search an appropriate cookie: %@", cookie);
            [cookieArray addObject:cookie];
    }
    return cookieArray;
}


- (NSInteger)deleteCookieForURL:(NSURL *)URL {
    int delCount = 0;
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [cookieStorage cookies]) {
        if (cookieFilter(cookie, URL)) {
            NSLog(@"Delete a cookie: %@", cookie);
            [cookieStorage deleteCookie:cookie];
            delCount++;
        }
    }
    return delCount;
}


@end
