//
//  CLDownloadOperation.m
//  SDWebImage的仿写的自我学习
//
//  Created by Criss on 16/7/31.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import "CLDownloadOperation.h"
#import "NSString+path.h"

@interface CLDownloadOperation ()

@property (copy, nonatomic) NSString *urlString;

@end

@implementation CLDownloadOperation

+ (instancetype)operationWithUrlString:(NSString *)urlString {
    //初始化
    CLDownloadOperation *op = [[CLDownloadOperation alloc] init];

    op.urlString = urlString;

    return op;
}

/**
 *  会自动调用
 */
- (void)main {
    // 1. 通过地址字符初始化NSURL
    NSURL *url = [NSURL URLWithString:self.urlString];
    // 2. 通过 URL 获取二进制数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 3. 将二进制数据转成 UIImage
    UIImage *image = [UIImage imageWithData:data];

    // 4. 将二进制数据写入沙盒
    [data writeToFile:[self.urlString appendCachePath] atomically:true];

    self.image = image;
}

@end
