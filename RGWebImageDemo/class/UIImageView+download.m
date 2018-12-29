//
//  UIImageView+download.m
//  RGWebImageDemo
//
//  Created by yangrui on 2018/12/29.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import "UIImageView+download.h"
#import <AFNetworkReachabilityManager.h>


@implementation UIImageView (download)


-(void)RG_setOriginImage:(NSString *)originImageUrl
          thumbnailImage:(NSString *)thumbnailImageUrl
             placeholder:(UIImage *)placeholder
                complete:(SDExternalCompletionBlock)complete{
    
    
    NSURL *imageUrl = nil;
    // 获取原图(sdwebImage 的图片是图片的url 作为key)
    if ([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageUrl] != nil) { // 原图已经被下载
        imageUrl = [NSURL URLWithString:originImageUrl];
    }
    else{ // 原图未被下载
        AFNetworkReachabilityManager *netMgr = [AFNetworkReachabilityManager sharedManager];
        if(netMgr.isReachableViaWiFi){ // wifi 环境下载原图
             imageUrl =[NSURL URLWithString:originImageUrl];
        }
        else if(netMgr.isReachableViaWWAN){// 3G 4G
            
            BOOL canDownloadWhen3G4G = YES;
            if(canDownloadWhen3G4G == YES){ //3G 4G 允许下载原图
               imageUrl =[NSURL URLWithString:originImageUrl];
            }
            else{ ////3G 4G 不允许下载原图
               imageUrl = [NSURL URLWithString:thumbnailImageUrl];
            }
        }
        else{// 没有网络
            
            if([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageUrl] != nil){
                imageUrl = [NSURL URLWithString:thumbnailImageUrl];
            }
        }
    }
    
    [self sd_setImageWithURL:imageUrl
            placeholderImage:placeholder
                   completed:complete];

}


//-(void)RG_setOriginImage:(NSString *)originImageUrl
//          thumbnailImage:(NSString *)thumbnailImageUrl
//             placeholder:(UIImage *)placeholder
//                complete:(SDExternalCompletionBlock)complete{
//
//    // 获取原图(sdwebImage 的图片是图片的url 作为key)
//    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageUrl];
//
//    if (originImage != nil) { // 原图已经被下载
//        // 错误写法(没有取消上一个请求)
////        self.image = originImage;
////        completedBlock(originImage, nil, 0, [NSURL URLWithString:originImageUrl]);
//
//        //正确的写法( 有取消上一个请求)
//        [self sd_setImageWithURL:[NSURL URLWithString:originImageUrl]
//                placeholderImage:placeholder
//                       completed:complete];
//
//    }
//    else{ // 原图未被下载
//        AFNetworkReachabilityManager *netMgr = [AFNetworkReachabilityManager sharedManager];
//        if(netMgr.isReachableViaWiFi){ // wifi 环境下载原图
//            [self sd_setImageWithURL:[NSURL URLWithString:originImageUrl]
//                    placeholderImage:placeholder
//                           completed:complete];
//        }
//        else if(netMgr.isReachableViaWWAN){// 3G 4G
//
//            BOOL canDownloadWhen3G4G = YES;
//            if(canDownloadWhen3G4G == YES){ //3G 4G 允许下载原图
//                [self sd_setImageWithURL:[NSURL URLWithString:originImageUrl]
//                        placeholderImage:placeholder
//                               completed:complete];
//            }
//            else{ ////3G 4G 不允许下载原图
//                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrl]
//                        placeholderImage:placeholder
//                               completed:complete];
//            }
//
//        }
//        else{// 没有网络
//
//            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageUrl];
//            if(thumbnailImage != nil){
//                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrl]
//                        placeholderImage:placeholder
//                               completed:complete];
//            }
//            else{ //没下载过任何图片
//                // 使用占位图片
//                [self sd_setImageWithURL:nil
//                        placeholderImage:placeholder
//                               completed:complete];
//            }
//        }
//    }
//
//}

@end
