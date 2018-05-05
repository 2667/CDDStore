//
//  MeiZhuanTopCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/3.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "MeiZhuanTopCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MeiZhuanTopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSLog(@"123_imageUrlString内容是%@",_imageUrlString);
//    NSString *string = @"http://gfs17.gomein.net.cn/T1cRbvBmWv1RCvBVdK_400.jpg";
    
    
    // Initialization code
}

-(void)drawRect:(CGRect)rect{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlString]];
    
}

//-(instancetype)initWithFrame:(CGRect)frame{
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:_AimageUrlString]];
////    NSString *number1 = @"1";
//    return self;
//}

@end
