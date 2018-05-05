//
//  MeiZhuanBottomCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/3.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "MeiZhuanBottomCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation MeiZhuanBottomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

-(void)drawRect:(CGRect)rect{
    
     [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlString]];
    
}

@end
