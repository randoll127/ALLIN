#import "ALBaseFileHelper.h"
#import "ALBaseStringHelper.h"
@implementation ALBaseFileHelper
+(BOOL)getDirectoryPath:dirPath isCreate:(BOOL)isCreate{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    BOOL ret=NO;
    BOOL isDirectory = NO;
    if (![fileManager fileExistsAtPath: dirPath isDirectory: &isDirectory]) {
        if(isCreate){
            NSError* error;
            [fileManager createDirectoryAtPath: dirPath withIntermediateDirectories: YES attributes: nil error: &error];
            if(!error){
                ret=YES;
            }
        }
    }else{
        if(isDirectory){
            ret = YES;
        }
    }
    return ret;
}

+(BOOL)isExistFilePath:(NSString*)filePath{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    BOOL ret=NO;
    BOOL isDirectory = NO;
    if (![fileManager fileExistsAtPath: filePath isDirectory: &isDirectory]) {
        ret=NO;
    }else{
        if(isDirectory){
            ret = NO;
        }else{
            ret = YES;
        }
    }
    return ret;
}

+(NSArray*)readDirsFromDir:(NSString*)dir{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray* __fileList = [self readFilesFromDir:dir];
    NSMutableArray* dirArray = [[NSMutableArray alloc] init];
    BOOL isDir = NO;
    for (NSString *fileName in __fileList) {
        NSString *path = [dir stringByAppendingPathComponent:fileName];
        [fileManager fileExistsAtPath:path isDirectory:(&isDir)];
        if (isDir) {
            [dirArray addObject:fileName];
        }
        isDir = NO;
    }
    return dirArray;
}

+(NSArray*)readFilesFromDir:(NSString*)dir{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:dir error:NULL];
    return contents;
}

+(NSString*)cleanFilesFromDir:(NSString*)dir{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray* contents = [self readFilesFromDir:dir];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        [fileManager removeItemAtPath:[dir stringByAppendingPathComponent:filename] error:NULL];
    }
    return [contents componentsJoinedByString:@"###"];
}

+(void)removeFileByPath:(NSString*)absolutePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:absolutePath error:NULL];
}



+(NSDate*)fileModifyDate:(NSString*)filePath{
    //日期格式化
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    //获取文件属性
    __autoreleasing NSError* error;
    NSDictionary *fileAttributes =[fileManager attributesOfItemAtPath:filePath error:&error];
    if(error){
        return nil;
    }
    //获取文件的创建日期
    NSDate *modificationDate = (NSDate*)[fileAttributes objectForKey: NSFileModificationDate];
    return modificationDate;
}



+(BOOL)createFileAtDirectory:(NSString*)dir fileName:(NSString*)fileName content:(NSString*)content{
    DIR_FORMAT(dir);
    if([self getDirectoryPath:dir isCreate:YES]){
        NSString* filePath = [NSString stringWithFormat:@"%@%@",dir,fileName];
        __autoreleasing NSError* error;
        [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if(error){
            return NO;
        }
    }else{
        return NO;
    }
    return YES;
}
+(BOOL)createFileAtDirectory:(NSString*)dir fileName:(NSString*)fileName data:(NSData*)data{
    DIR_FORMAT(dir);
    if([self getDirectoryPath:dir isCreate:YES]){
        NSString* filePath = [NSString stringWithFormat:@"%@%@",dir,fileName];
        __autoreleasing NSError* error;
        [data writeToFile:filePath options:NSDataWritingAtomic  error:&error];
        if(error){
            return NO;
        }
    }else{
        return NO;
    }
    return YES;
}


/*appendFile*/
+(BOOL)appendFileAtDirectory:(NSString*)dir fileName:(NSString*)fileName content:(NSString*)content{
    NSData* data = [ALBaseStringHelper dataFromString:content];
    return [self appendFileAtDirectory:dir fileName:fileName data:data];
}

+(BOOL)appendFileAtDirectory:(NSString*)dir fileName:(NSString*)fileName data:(NSData*)data{
    DIR_FORMAT(dir);
    NSString* filePath = [NSString stringWithFormat:@"%@%@",dir,fileName];
    if(![self isExistFilePath:filePath]){
        if(![self createFileAtDirectory:dir fileName:fileName content:@""]){
            return NO;
        }
    }
    NSFileHandle *logFile= [NSFileHandle fileHandleForWritingAtPath:filePath];
    //    unsigned long long len = [logFile seekToEndOfFile];
    [logFile seekToEndOfFile];
    [logFile writeData:data];
    [logFile synchronizeFile];
    return YES;
}


/*
 NSString* string =[Utility stringFromFilePath:[NSString stringWithFormat:@"%@%@",TMP_PATH,@"abc/abc.json" ]];
 NSData *data=[Utility dataFromFilePath:[NSString stringWithFormat:@"%@%@",TMP_PATH,@"abc/abc.json" ]];
 */
#pragma mark  读取文件
+(NSString*)readStringFromFilePath:(NSString*)filePath{
    __autoreleasing NSError* error;
    NSString* content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if(error){
        return nil;
    }
    return content;
}

+(NSData*)readDataFromFilePath:(NSString*)filePath{
    __autoreleasing NSError* error;
    NSData* data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    if(error){
        return nil;
    }
    return data;
}

+(BOOL)copyFilesFromPath:(NSString*)fromPath toPath:(NSString*)destPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError* error;
    BOOL isOK=NO;
    if([self getDirectoryPath:destPath isCreate:YES]&&[fileManager removeItemAtPath:destPath error:nil]){
        
        isOK = [fileManager copyItemAtPath:fromPath toPath:destPath error:&error];
    }
    return isOK;
    
}


+(NSArray*)arrayFromMainBundleFile:(NSString*)fileName type:(NSString*)extType{
    NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:extType];
    if (![[NSFileManager defaultManager] fileExistsAtPath:bundleFilePath]) {
        return nil;
    }
    NSString* content = [self readStringFromFilePath:bundleFilePath];
    NSArray *moduleList = [ALBaseStringHelper arrayFromJSONString:content];
    return moduleList;
}
+(NSDictionary*)dicFromMainBundleFile:(NSString*)fileName type:(NSString*)extType{
    NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:extType];
    if (![[NSFileManager defaultManager] fileExistsAtPath:bundleFilePath]) {
        return nil;
    }
    NSString* content = [self readStringFromFilePath:bundleFilePath];
    NSDictionary *moduleDic = [ALBaseStringHelper dictionaryFromJSONString:content];
    return moduleDic;
}

@end

