#import <Foundation/Foundation.h>

@interface ALNetworkPath : NSObject
@property (nonatomic,strong) NSString* pathStr;
@property (nonatomic,strong) NSArray* keyParams;

- (instancetype)initWithPath:(NSString *)path;
- (NSArray *)parseParams;
- (NSString*)parseUrlWithValues:(NSArray*)values;
@end
