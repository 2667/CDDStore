//
//  YouHuiCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/2.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouHuiCollectionViewCell : UICollectionViewCell

/* 推荐图片数组 */
@property (copy , nonatomic)NSArray *goodExceedArray;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UIImageView *downTopImageView;

@property (weak, nonatomic) IBOutlet UIImageView *downBottomImageView;

@end
