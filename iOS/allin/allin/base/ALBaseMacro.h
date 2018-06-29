#import "ALBase.h"

#define APP_SCREEN_BOUNDS       [UIScreen mainScreen].bounds
#define APP_HEIGHT              [UIScreen mainScreen].bounds.size.height
#define APP_WIDTH               [UIScreen mainScreen].bounds.size.width
#define APP_SIZE_IN_PIXEL       [JVUtility deviceSizeInPixels]
#define APP_HEIGHT_IN_PIXEL     APP_SIZE_IN_PIXEL.height
#define APP_WIDTH_IN_PIXEL      APP_SIZE_IN_PIXEL.width


/*
 DEBUG define
 */
#ifdef DEBUG
#define ALLOG_FUN             NSLog(@"#####%s#####", __FUNCTION__);
#define ALLOG(CON)            NSLog(@"%@",CON)
#define ALLOG_FORMAT(fmt, ...)      NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define ALDEALLOC_LOG        -(void)dealloc{NSLog(@"%@ is dealloc",NSStringFromClass([self class]));}
#define ALShowAlert(TITLE,MSG) [[[UIAlertView alloc] initWithTitle:TITLE message:MSG delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]
#else
#define ALLOG_FUN
#define ALLOG(CON)
#define ALLOG_FORMAT(fmt, ...)
#define ALDEALLOC_LOG
#define ALShowAlert(TITLE,MSG)
#endif


#pragma mark 常用方法--转换类型
#define DATA_FROM_STRING(__STR__)         [__STR__ dataUsingEncoding:NSUTF8StringEncoding]
#define STRING_FROM_DATA(__DATA__)        [[NSString alloc]initWithData:__DATA__ encoding:NSUTF8StringEncoding]
#define JSON_DIC_FROM_STRING(__STR__)   [ALBaseStringHelper dictionaryFromJSONString:__STR__]
#define JSON_ARRAY_FROM_STRING(__STR__)   [ALBaseStringHelper arrayFromJSONString:__STR__]
#define JSON_OBJ_FROM_STRING(__STR__)   [ALBaseStringHelper objectFromJSONString:__STR__]
#define JSON_STRING_FROM_DIC(__DIC__)   [ALBaseStringHelper stringFromDictionary:__DIC__]
#define JSON_STRING_FROM_ARRAY(__ARRAY__)   [ALBaseStringHelper stringFromArray:__ARRAY__]

#if defined(__cplusplus)
#define AL_EXTERN extern "C"
#else
#define AL_EXTERN extern
#endif

#pragma mark----宏操作常用方法

#if DEBUG
#define allin_keywordify autoreleasepool {}
#else
#define allin_keywordify try {} @catch (...) {}
#endif

#define AL_CONCAT(a,b) __CONCAT(a,b)
