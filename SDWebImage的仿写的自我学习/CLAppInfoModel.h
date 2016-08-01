//
//  CLAppInfoModel.h
//  异步加载图片的再次演练
//
//  Created by Criss on 16/7/31.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLAppInfoModel : NSObject

/**
 *  下载量
 */
@property (copy, nonatomic) NSString *download;
/**
 *  图标地址
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  游戏名字
 */
@property (copy, nonatomic) NSString *name;

@end
