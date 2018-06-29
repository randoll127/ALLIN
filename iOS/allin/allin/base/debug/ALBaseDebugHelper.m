#import "ALBaseDebugHelper.h"
#import <Foundation/Foundation.h>
//#define NOW_TIME_INTERVAL [[NSDate date] timeIntervalSince1970]*1000*1000
#define NOW_TIME_INTERVAL CACurrentMediaTime()*1000*1000

@interface ALBaseDebugHelper(){
    NSMutableArray<NSNumber*>* cache;
    long lastInterval;
}
@end

@implementation ALBaseDebugHelper

-(instancetype)init{
    self = [super init];
    cache = [[NSMutableArray alloc]init];
    return self;
}
#ifdef DEBUG
-(void)reset{
    [cache removeAllObjects];
}

-(void)start{
    [self reset];
//    lastInterval = CACurrentMediaTime();
    lastInterval = NOW_TIME_INTERVAL;
    NSLog(@"%ld",lastInterval);
}
-(void)point{
//    long now =  CACurrentMediaTime();
    long now = NOW_TIME_INTERVAL;
    long period = now-lastInterval;
    [cache addObject:[NSNumber numberWithLong:period]];
    lastInterval=now;
}
-(void)end{
    [self point];
    for(NSInteger i = 0 ; i<cache.count;i++){
        NSNumber* point = cache[i];
        NSLog(@"第%ld个点:%@",i+1,point);
    }
    [self reset];
}
#else
-(void)reset{};
-(void)start{};
-(void)point{};
-(void)end{};
#endif

@end
