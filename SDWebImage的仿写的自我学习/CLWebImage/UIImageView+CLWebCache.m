//
//  UIImageView+CLWebCache.m
//  SDWebImage的仿写的自我学习
//
//  Created by Criss on 16/8/1.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import "CLDownloadManager.h"
#import "UIImageView+CLWebCache.h"

@implementation UIImageView (CLWebCache)

- (void)cl_setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)image {
    [[CLDownloadManager sharedManager] downloadImageWithUrlString:urlString completion:^(UIImage *image) {

        self.image = image;
    }];
}

@end
