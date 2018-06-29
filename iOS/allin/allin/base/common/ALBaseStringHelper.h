#import <Foundation/Foundation.h>

@interface NSString (ALBaseStringHelper)
- (NSString*)al_encodeBase64;
- (NSString*)al_decodeBase64;
@end

@interface ALBaseStringHelper : NSObject
// base64编码
+(NSString*)base64StringFromString:(NSString*)originStr;
+(NSString*)base64webSafeStringFromString:(NSString*)originStr;
+(NSData*)dataFromString:(NSString*)originStr;
+(NSString*)decodeFromBase64String:(NSString*)originStr;
+(NSString*)decodeFromBase64WebSafeString:(NSString*)base64EncodedStr;
+(NSString*)stringFromData:(NSData*)data;

//Dictionary互转
+(NSDictionary*)dictionaryFromJSONString:(NSString*)jsonStr;
+(NSArray*)arrayFromJSONString:(NSString*)jsonStr;
+(id)objectFromJSONString:(NSString*)jsonStr;
+(NSString*)stringFromDictionary:(NSDictionary*)dict;
+(NSString*)stringFromArray:(NSArray*)array;

//url编码解码
+(NSString*)encodeUrlString:(NSString*)url;
+(NSString*)decodeUrlString:(NSString*)encodedUrl;

@end
