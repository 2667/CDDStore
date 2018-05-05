//
//  ThreeImageCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/4.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThreeImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UIImageView *righttopImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightbottomImageView;
/* 推荐图片数组 */
@property (copy , nonatomic)NSArray *goodExceedArray;


@end
