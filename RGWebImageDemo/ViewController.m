//
//  ViewController.m
//  RGWebImageDemo
//
//  Created by yangrui on 2018/12/29.
//  Copyright © 2018年 yangrui. All rights reserved.
//  SDWebImage 的正确用法

#import "ViewController.h"
#import "RGImageMode.h"
#import "UIImageView+download.h"

@interface ViewController ()

@property(nonatomic, strong)NSMutableArray<RGImageMode *> *imageModeArrM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageModeArrM.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static  NSString *ID = @"id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    RGImageMode *mode = self.imageModeArrM[indexPath.row];
    
    [cell.imageView RG_setOriginImage:mode.originImageUrl thumbnailImage:mode.thumbnailImageUrl placeholder:[UIImage imageNamed:mode.placeholder] complete:^(UIImage * _Nullable image,NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        // 监控SDWebImage的图片下载情况
        NSLog(@"image: %@, error:%@, cacheType:%d, imageURL:%@",image,error.localizedDescription,cacheType,imageURL);
        
    }];
    
    return cell;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 清除内存缓存 ( 因为 SDWebImage 在滚动时会一直将下载的图片缓存在内存和磁盘中, 为了保证内存的稳定, 需要将不必要的内存数据清掉)
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
