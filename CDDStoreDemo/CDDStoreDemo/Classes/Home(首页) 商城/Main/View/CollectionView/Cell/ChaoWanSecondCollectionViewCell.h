//
//  ChaoWanSecondCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/4.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChaoWanSecondCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

/* 推荐图片数组 */
@property (copy , nonatomic)NSArray *goodExceedArray;

@end
