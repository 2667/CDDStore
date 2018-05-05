//
//  YouXuanCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/4.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouXuanCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftTopImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightTopImageView;

@property (weak, nonatomic) IBOutlet UIImageView *leftBottomImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightBottomImageView;
//店名
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
//标语
@property (weak, nonatomic) IBOutlet UILabel *biaoYuLabel;

/* 优选图片数组 */
@property (copy , nonatomic)NSArray *goodExceedArray;

@end
