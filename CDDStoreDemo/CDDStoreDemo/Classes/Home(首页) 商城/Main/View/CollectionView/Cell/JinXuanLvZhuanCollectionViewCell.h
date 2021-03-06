//
//  JinXuanLvZhuanCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/3.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JinXuanLvZhuanCollectionViewCell : UICollectionViewCell

/* 推荐图片数组 */
@property (copy , nonatomic)NSArray *goodExceedArray;

/* collectionView */
//@property (strong , nonatomic)UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;


@property (weak, nonatomic) IBOutlet UIImageView *rightTopImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightDownImageView;



@end
