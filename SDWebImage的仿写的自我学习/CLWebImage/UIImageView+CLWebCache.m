//
//  UIImageView+CLWebCache.m
//  SDWebImage的仿写的自我学习
//
//  Created by Criss on 16/8/1.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import "CLDownloadManager.h"
#import "UIImageView+CLWebCache.h"
#import <objc/runtime.h>

const char *kUrlString = "kUrlString";

@implementation UIImageView (CLWebCache)

- (void)cl_setImageWithUrlString:(NSString *)string placeholderImage:(UIImage *)image {
    // 想要解决快速滚动出现的图片混乱的情况，应该再进行赋值的时候取消上一次加载图片的操作
    if (self.urlString != nil && ![self.urlString isEqualToString:string]) {
        // 取消之前的操作
        NSLog(@"self.urlString : %@",self.urlString);
        [[CLDownloadManager sharedManager] cancelOperationWithUrlString:self.urlString];
    }

    // 保存上一次操作中下载的图片
    self.urlString = string;

    [[CLDownloadManager sharedManager] downloadImageWithUrlString:string completion:^(UIImage *image) {
        NSLog(@"已下载好的image:%@", image);
        self.image = image;

        self.urlString = nil;

    }];
}

- (void)setUrlString:(NSString *)urlString {
    
    // 使用对象关联，是运行时里的东西,应用场景就是再分类中，定义属性，给当前的对象保存值
    objc_setAssociatedObject(self, kUrlString, urlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)urlString {
    return objc_getAssociatedObject(self, kUrlString);
}

@end
