//
//  ChaoWanSecondCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/4.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "ChaoWanSecondCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@implementation ChaoWanSecondCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGoodExceedArray:(NSArray *)goodExceedArray{
    _goodExceedArray = goodExceedArray;
    
    [_bottomImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[1]]];
    
}


@end
