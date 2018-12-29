//
//  UIImageView+download.h
//  RGWebImageDemo
//
//  Created by yangrui on 2018/12/29.
//  Copyright © 2018年 yangrui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>


@interface UIImageView (download)

-(void)RG_setOriginImage:(NSString *)originImageUrl
          thumbnailImage:(NSString *)thumbnailImageUrl
             placeholder:(UIImage *)placeholder
                complete:(SDExternalCompletionBlock)complete;
@end
