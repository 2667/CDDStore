//
//  GuessGoodsYouLikeCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/5.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuessGoodsYouLikeCollectionViewCell : UICollectionViewCell

/* 推荐图片数组 */
@property (copy , nonatomic)NSArray *goodExceedArray;

/* collectionView */
//@property (strong , nonatomic)UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
