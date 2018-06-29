#import <Foundation/Foundation.h>

#define DIR_FORMAT(DIR_PATH) if(![DIR_PATH hasSuffix:@"/"]){DIR_PATH=[DIR_PATH stringByAppendingString:@"/"];}


@interface ALBaseFileHelper : NSObject
/*
 是否存在这个目录，并且可以创建。
 path:创建的文件夹路径
 isCreate:文件夹不存在时，是否创建？
 eg:
 NSString* path=  [NSString stringWithFormat: @"%@%@", TMP_PATH, @"a/b/c/d.html"];
 BOOL isHave = [JVUtility getDirectoryPath:path isCreate:YES];
 */
+(BOOL)getDirectoryPath:path isCreate:(BOOL)isCreate;

/*是否存在该文件路径*/
+(BOOL)isExistFilePath:(NSString*)filePath;



/*
 获取文件的修改时间，如果文件被覆盖，它的时间应该被修改的
 [Utility getFileModifyDate:[NSString stringWithFormat:@"%@%@",TMP_PATH,@"abc/abc.json"]];
 */
+(NSDate*)fileModifyDate:(NSString*)filePath;

/*创建文件，如果有，则覆盖掉原来文件，并写入内容,如果创建的文件的目录不存在，则会先创建目录后，再创建文件*/
+(BOOL)createFileAtDirectory:(NSString*)dir fileName:(NSString*)fileName data:(NSData*)data;
+(BOOL)createFileAtDirectory:(NSString*)dir fileName:(NSString*)fileName content:(NSString*)content;

/*追加内容到对应文件*/
+(BOOL)appendFileAtDirectory:(NSString*)dir fileName:(NSString*)fileName content:(NSString*)content;
+(BOOL)appendFileAtDirectory:(NSString*)dir fileName:(NSString*)fileName data:(NSData*)data;

/*读取内容*/
+(NSString*)readStringFromFilePath:(NSString*)filePath;
+(NSData*)readDataFromFilePath:(NSString*)filePath;

/*返回目录下的文件名*/
+(NSArray*)readFilesFromDir:(NSString*)dir;
/*返回目录下的文件夹名*/
+(NSArray*)readDirsFromDir:(NSString*)dir;
/*清理目录下的所有文件*/
+(NSString*)cleanFilesFromDir:(NSString*)dir;
/*删除一个文件*/
+(void)removeFileByPath:(NSString*)absolutePath;
/*从一个目录copy到另外一个目录*/
+(BOOL)copyFilesFromPath:(NSString*)fromPath toPath:(NSString*)destPath;

//从bundle中获得对应数据
+(NSArray*)arrayFromMainBundleFile:(NSString*)fileName type:(NSString*)extType;
+(NSDictionary*)dicFromMainBundleFile:(NSString*)fileName type:(NSString*)extType;
@end
