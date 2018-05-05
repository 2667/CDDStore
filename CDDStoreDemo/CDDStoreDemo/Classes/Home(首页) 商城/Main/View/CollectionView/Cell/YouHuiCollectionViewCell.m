//
//  YouHuiCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/2.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "YouHuiCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation YouHuiCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGoodExceedArray:(NSArray *)goodExceedArray{
    
//    _goodExceedArray = goodExceedArray;
//    _imagesArray = goodExceedArray;
    
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[1]]];
    [_downTopImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[2]]];
    [_downBottomImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[4]]];
    
}

@end
