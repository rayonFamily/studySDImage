//
//  CLDownloadOperation.h
//  SDWebImage的仿写的自我学习
//
//  Created by Criss on 16/7/31.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLDownloadOperation : NSOperation

@property (strong, nonatomic) UIImage *image;

/**
 *  通过一个urlString创建一个操作
 */

+ (instancetype)operationWithUrlString:(NSString *)urlString;

@end
