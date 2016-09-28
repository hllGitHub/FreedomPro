//
//  HLLCleanCache.h
//  imageViewScrollerDemo1
//
//  Created by Apple on 15/11/13.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ClearCompleteBlock)(void);

@interface HLLCleanCache : NSObject

/**
 *  单例
 *
 *  @return 单例对象
 */
+ (HLLCleanCache *)cacheManager;

/**
 *  计算缓存大小
 *
 *  @return 缓存大小值
 */
- (NSString *) cacheSizeAtPath;
/**
 *  清除缓存
 *
 *  @param clearCompleteBlock 清除完成回调
 */
- (void)clearTmpWithClearCompleteBlock:(ClearCompleteBlock)clearCompleteBlock;

@end
