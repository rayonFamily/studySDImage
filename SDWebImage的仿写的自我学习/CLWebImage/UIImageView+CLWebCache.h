//
//  UIImageView+CLWebCache.h
//  SDWebImage的仿写的自我学习
//
//  Created by Criss on 16/8/1.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CLWebCache)

- (void)cl_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)image;

@end
