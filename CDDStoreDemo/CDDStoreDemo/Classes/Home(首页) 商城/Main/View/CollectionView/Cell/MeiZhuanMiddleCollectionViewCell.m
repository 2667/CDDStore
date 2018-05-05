//
//  MeiZhuanMiddleCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/3.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "MeiZhuanMiddleCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MeiZhuanMiddleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}


//-(void)drawRect:(CGRect)rect{
//    NSLog(@"_imageUrlString内容是%@",_imageUrlString);
//    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlString]];
//
//}

-(void)setImageUrlString:(NSString *)imageUrlString{
    _imageUrlString = imageUrlString;
    NSLog(@"_imageUrlString内容是%@",_imageUrlString);
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlString]];
    
}

@end
