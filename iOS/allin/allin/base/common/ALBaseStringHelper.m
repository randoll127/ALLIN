#import "ALBaseStringHelper.h"


@implementation NSString (ALBaseStringHelper)

- (NSString*)al_encodeBase64
{
    return [ALBaseStringHelper base64StringFromString:self];
}

- (NSString*)al_decodeBase64
{
    return [ALBaseStringHelper decodeFromBase64String:self];
}
@end

@implementation ALBaseStringHelper
#pragma mark (●ﾟωﾟ●) base64转换 (●ﾟωﾟ●)

+(NSString*)base64StringFromString:(NSString*)originStr{
    NSData *nsData =[ALBaseStringHelper dataFromString:originStr];
    NSString *base64Encoded = [nsData base64EncodedStringWithOptions:0];
    return base64Encoded;
}

+(NSString*)base64webSafeStringFromString:(NSString*)originStr{
    NSString* base64Encoded = [ALBaseStringHelper base64StringFromString:originStr];
    base64Encoded = [[base64Encoded stringByReplacingOccurrencesOfString:@"+" withString:@"-"] stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return base64Encoded;
}


+(NSData*)dataFromString:(NSString*)originStr{
    NSData *nsData = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    return nsData;
}

+(NSString*)decodeFromBase64String:(NSString*)base64EncodedStr{
    NSData *nsdataFromBase64String = [[NSData alloc] initWithBase64EncodedString:base64EncodedStr options:0];
    NSString *base64Decoded = [[NSString alloc] initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    return base64Decoded;
}



+(NSString*)decodeFromBase64WebSafeString:(NSString*)base64EncodedStr{
    base64EncodedStr = [[base64EncodedStr stringByReplacingOccurrencesOfString:@"-" withString:@"+"] stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSString *base64Decoded = [ALBaseStringHelper decodeFromBase64String:base64EncodedStr];
    return base64Decoded;
}

#pragma mark (●ﾟωﾟ●) NSDictionary，NSArray和String转换 (●ﾟωﾟ●)
+(NSDictionary*)dictionaryFromJSONString:(NSString*)jsonStr{
    NSError * error = nil;
    NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) {
        return nil;
    }
    NSDictionary* jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if(error||![jsonDic isKindOfClass:[NSDictionary class]]){
        return nil;
    }else{
        return jsonDic;
    }
}

+(id)objectFromJSONString:(NSString*)jsonStr{
    NSError * error = nil;
    NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error){
        return nil;
    }else{
        return jsonObject;
    }
}


+(NSArray*)arrayFromJSONString:(NSString*)jsonStr{
    NSError * error = nil;
    NSData * jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error||![array isKindOfClass:[NSArray class]]){
        return nil;
    }else{
        return array;
    }
}


+(NSString*)stringFromDictionary:(NSDictionary*)dict{
    if (dict == nil || ![dict isKindOfClass:[NSDictionary class]] || dict.count == 0 || ![NSJSONSerialization isValidJSONObject:dict])
        return nil;
    NSError * error = nil;
    NSString* jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict options:0 error:&error]encoding:NSUTF8StringEncoding];
    if(error){
        return nil;
    }else{
        return jsonStr;
    }
}

//NSArray to jsontStr
+(NSString*)stringFromArray:(NSArray*)array{
    NSError * error = nil;
    if (array == nil || ![NSJSONSerialization isValidJSONObject:array]) {
        return nil;
    }
    NSString* jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error]encoding:NSUTF8StringEncoding];
    if(error){
        return nil;
    }else{
        return jsonStr;
    }
}

+(NSString*)stringFromData:(NSData*)data{
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}




+(NSString*)encodeUrlString:(NSString*)url{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              NULL,
                                                              (CFStringRef)@"!*'();@+$,%[]{}",
                                                              kCFStringEncodingUTF8));//@"!*'();:@&=+$,/?%#[]"
    
    return encodedString;
}

+(NSString*)decodeUrlString:(NSString*)encodedUrl{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedUrl,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}




@end
