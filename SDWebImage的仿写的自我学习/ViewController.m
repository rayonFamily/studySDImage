//
//  ViewController.m
//  SDWebImage的仿写的自我学习
//
//  Created by Criss on 16/7/31.
//  Copyright © 2016年 Criss. All rights reserved.
//

#import "AFNetworking.h"
#import "CLAppInfoCell.h"
#import "CLAppInfoModel.h"
#import "CLDownloadManager.h"
#import "NSString+path.h"
#import "ViewController.h"
#import "UIImageView+CLWebCache.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *appInfos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadAppInfoFromInternet];
}

- (void)loadAppInfoFromInternet {
    NSString *urlString = @"https://raw.githubusercontent.com/VamCriss/MyDB/master/app.json";

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {

        NSArray *appInfo = responseObject;

        for (NSDictionary *dict in appInfo) {
            CLAppInfoModel *appInfoModel = [[CLAppInfoModel alloc] init];
            [appInfoModel setValuesForKeysWithDictionary:dict];
            [self.appInfos addObject:appInfoModel];
        }

        [self.tableView reloadData];
    }
        failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {

            NSLog(@"数据加载错误");
        }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appInfos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLAppInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];

    CLAppInfoModel *appInfo = self.appInfos[indexPath.row];
    cell.nameLabel.text = appInfo.name;
    cell.downloadLabel.text = appInfo.name;
    cell.iconView.image = nil;
    
    [cell.iconView cl_setImageWithUrlString:appInfo.icon placeholderImage:[UIImage imageNamed:@"black_005"]];

//    [[CLDownloadManager sharedManager] downloadImageWithUrlString:appInfo.icon completion:^(UIImage *image) {
//
//        cell.iconView.image = image;
//    }];
    return cell;
}

#pragma mark-- 懒加载
- (NSMutableArray *)appInfos {
    if (!_appInfos) {
        _appInfos = [NSMutableArray array];
    }
    return _appInfos;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)test {
    //    cell.iconView.image = nil;
    //
    //    // 从内存中加载图片
    //    UIImage *cacheImage = self.imageCache[appInfo.icon];
    //    if (cacheImage) {
    //        cell.iconView.image = cacheImage;
    //        return cell;
    //    }
    //
    //    // 从沙盒中加载数据
    //    NSString *sanBoxPath = [appInfo.icon appendCachePath];
    //    cacheImage = [UIImage imageWithContentsOfFile:sanBoxPath];
    //    if (cacheImage) {
    //        // 如果沙盒中有数据，那么就再内存中再写一份
    //        [self.imageCache setObject:cacheImage forKey:appInfo.icon];
    //
    //        cell.iconView.image = cacheImage;
    //        return cell;
    //    }
    //
    //    // 如果操作存在，这不添加操作
    //    if (self.operationCache[appInfo.icon]) {
    //        return cell;
    //    }
    //
    //    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
    //
    //        NSURL *url = [NSURL URLWithString:appInfo.icon];
    //        NSData *data = [NSData dataWithContentsOfURL:url];
    //        UIImage *image = [UIImage imageWithData:data];
    //
    //        // 将图片数据写入沙盒中
    //        NSString *cachePath = [appInfo.icon appendCachePath];
    //        [data writeToFile:cachePath atomically:YES];
    //
    //        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //
    //            // 将图片添加到内存中
    //            if (image != nil)
    //                [self.imageCache setObject:image forKey:appInfo.icon];
    //
    //            // 图片添加完成后，将操作从缓存中删除
    //            [self.operationCache removeObjectForKey:appInfo.icon];
    //
    //            // 刷新一行的数据-- 第一次加载的时候，由于内存，沙盒都么有数据，当吧数据加载到内存中后，要重新加载一下数据以显示数据
    //            [tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationMiddle];
    //
    //        }];
    //    }];
    //
    //    [self.operationCache setObject:op forKey:appInfo.icon];
    //    [self.queue addOperation:op];
}

@end