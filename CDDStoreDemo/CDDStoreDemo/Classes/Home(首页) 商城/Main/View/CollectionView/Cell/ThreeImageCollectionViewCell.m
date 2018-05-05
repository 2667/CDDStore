//
//  ThreeImageCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/4.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "ThreeImageCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@implementation ThreeImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setGoodExceedArray:(NSArray *)goodExceedArray{
    _goodExceedArray = goodExceedArray;
//    _imagesArray = goodExceedArray;
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
    [_righttopImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[1]]];
    [_rightbottomImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[2]]];
    
    
}

@end
