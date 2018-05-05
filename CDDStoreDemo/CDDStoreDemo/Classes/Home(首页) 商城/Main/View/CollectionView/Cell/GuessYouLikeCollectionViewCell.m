//
//  GuessYouLikeCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/5.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "GuessYouLikeCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation GuessYouLikeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGoodExceedArray:(NSArray *)goodExceedArray{
    _goodExceedArray = goodExceedArray;
    
    [_ImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
   
    
}

@end
