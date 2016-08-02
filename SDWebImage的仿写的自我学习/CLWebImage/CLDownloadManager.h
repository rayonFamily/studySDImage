//
//  CLDownloadManager.h
//  SDWebImage的仿写的自我学习
//
//  Created by Criss on 16/7/31.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLDownloadManager : NSObject

// 给外界提供一个全局访问点
+ (instancetype)sharedManager;

// 提供给外界一个下载图片的方法
// 异步操作是不能直接给当前方法提供返回值的，需要使用block进行回调

/**
 *  通过图片地址，下载图片，并且使用block将异步下载的图片进行回调
 */
- (void)downloadImageWithUrlString:(NSString *)urlString completion:(void (^)(UIImage *image))compeletion;

/**
 *  取消上一次的操作
 */
- (void)cancelOperationWithUrlString:(NSString *)urlString;
 @end
