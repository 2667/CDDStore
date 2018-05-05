//
//  GuessYouLikeCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/5.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuessYouLikeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;


//商品名
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
//价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

/* 优选图片数组 */
@property (copy , nonatomic)NSArray *goodExceedArray;

@end
