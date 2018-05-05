//
//  MeiZhuanMiddleCollectionViewCell.h
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/3.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeiZhuanMiddleCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UILabel *topTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLabel;

@property (copy, nonatomic) NSString *imageUrlString;
@end
