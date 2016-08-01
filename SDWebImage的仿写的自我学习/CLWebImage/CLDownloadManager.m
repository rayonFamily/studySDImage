//
//  CLDownloadManager.m
//  SDWebImage的仿写的自我学习
//
//  Created by Criss on 16/7/31.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import "CLDownloadManager.h"
#import "CLDownloadOperation.h"
#import "NSString+path.h"

@interface CLDownloadManager ()

/**
 *  图片内存缓存
 */
@property (nonatomic, strong) NSMutableDictionary *imageCache;

/**
 *  操作缓存
 */
@property (nonatomic, strong) NSMutableDictionary *operationCache;

/**
 *  队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation CLDownloadManager

+ (instancetype)sharedManager {
    static CLDownloadManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageCache = [NSMutableDictionary dictionary];
        self.operationCache = [NSMutableDictionary dictionary];
        self.queue = [[NSOperationQueue alloc] init];

        //注册内存警告
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

//
- (void)downloadImageWithUrlString:(NSString *)urlString completion:(void (^)(UIImage *))completion {
    NSAssert(completion != nil, @"必须传入回调的block");

    // 从内存中加载图片
    UIImage *cacheImage = self.imageCache[urlString];
    if (cacheImage) {
        completion(cacheImage);
        return;
    }

    // 从沙盒中加载数据
    NSString *sanBoxPath = [urlString appendCachePath];
    cacheImage = [UIImage imageWithContentsOfFile:sanBoxPath];
    if (cacheImage) {
        NSLog(@"从沙盒中加载");
        // 如果沙盒中有数据，那么就再内存中再写一份
        [self.imageCache setObject:cacheImage forKey:urlString];

        completion(cacheImage);
        return;
    }

    // 如果操作存在，这不添加操作
    if (self.operationCache[urlString]) {
        return;
    }

    CLDownloadOperation *op = [CLDownloadOperation operationWithUrlString:urlString];

    __weak typeof(op) weakSelf = op;
    [op setCompletionBlock:^{

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{

            UIImage *image = weakSelf.image;
            // 将图片添加到内存中
            [self.imageCache setObject:image forKey:urlString];

            // 图片添加完成后，将操作从缓存中删除
            [self.operationCache removeObjectForKey:urlString];

            completion(image);

        }];
    }];

    [self.operationCache setObject:op forKey:urlString];
    [self.queue addOperation:op];
}

/**
 *  接收到内存警告的通知之后要做的事情
 */
- (void)memoryWarning {
    NSLog(@"收到内存警告");
    // 1. 清除图片
    [self.imageCache removeAllObjects];
    // 2. 清除操作
    [self.operationCache removeAllObjects];
    // 3. 取消队列中所有的操作
    [self.queue cancelAllOperations];
}

@end
