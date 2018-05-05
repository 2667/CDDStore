//
//  YouXuanCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/4.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "YouXuanCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@implementation YouXuanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGoodExceedArray:(NSArray *)goodExceedArray{
    _goodExceedArray = goodExceedArray;
    
    [_leftTopImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
    [_rightTopImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[1]]];
    [_leftBottomImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[2]]];
    [_rightBottomImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[3]]];
    
}


@end
