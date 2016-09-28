//
//  HLLCleanCache.m
//  imageViewScrollerDemo1
//
//  Created by Apple on 15/11/13.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "HLLCleanCache.h"
#import "SDImageCache.h"

@interface HLLCleanCache ()

@property (nonatomic, copy) ClearCompleteBlock clearCompleteBlock;

@end

@implementation HLLCleanCache

#pragma mark 清理缓存部分
+ (HLLCleanCache *)cacheManager{
    static HLLCleanCache *sharedCacheInstance;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedCacheInstance = [[HLLCleanCache alloc] init];
    });
    return sharedCacheInstance;
}

///计算缓存文件的大小
- (NSString *) cacheSizeAtPath{
    
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager* manager = [NSFileManager defaultManager];
    CGFloat cacheSize = 0;
    NSString *cacheSizeStr;
    
    if ([manager fileExistsAtPath:cachPath]) {
        NSArray *childerFiles=[manager subpathsAtPath:cachPath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[cachPath stringByAppendingPathComponent:fileName];
            cacheSize += [[manager attributesOfItemAtPath:absolutePath error:nil] fileSize];
        }
        NSLog(@"cache = %.2f", cacheSize);
        
        //SDWebImage框架自身计算缓存的实现
        cacheSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    }
    
    NSLog(@"cache = %.2f", cacheSize);
    
    if (cacheSize < 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"0.0 KB"];
    } else if (cacheSize >= 1024 && cacheSize < 1024 * 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"%.1f KB", cacheSize / 1024.0];
    } else if (cacheSize >= 1024 * 1024 && cacheSize < 1024 * 1024 * 1024) {
        cacheSizeStr = [NSString stringWithFormat:@"%.1f MB", cacheSize / (1024 * 1024.0)];
    } else {
        cacheSizeStr = [NSString stringWithFormat:@"%.1f GB", cacheSize / (1024 * 1024 * 1024.0)];
    }
    
    NSLog(@"cacheSizeStr = %@", cacheSizeStr);
    NSLog(@"cache = %.2f", cacheSize);
    return cacheSizeStr;
}

//清理缓存
- (void)clearTmpWithClearCompleteBlock:(ClearCompleteBlock)clearCompleteBlock
{
    _clearCompleteBlock = clearCompleteBlock;
    
    [self clear];
    NSLog(@"clear disk");
    
    NSString *clearCacheName = [self cacheSizeAtPath];
    NSLog(@"clearCacheName = %@", clearCacheName);
}

//清理
- (void)clear
{
    //  清理cache文件夹里的数据
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
    
    //清理SDImageCache的缓存
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
}

//清理成功
-(void)clearCacheSuccess
{
    NSLog(@"清理成功");
    if (_clearCompleteBlock) {
        _clearCompleteBlock();
    }
}



@end
