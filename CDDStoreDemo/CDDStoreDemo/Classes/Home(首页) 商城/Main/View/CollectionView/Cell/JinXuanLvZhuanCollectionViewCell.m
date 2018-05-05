//
//  JinXuanLvZhuanCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/3.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "JinXuanLvZhuanCollectionViewCell.h"
//#import "DCGoodsHandheldCell.h"
#import <UIImageView+WebCache.h>
#import "YouHuiCell.h"

@interface JinXuanLvZhuanCollectionViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


/* 头部ImageView */
@property (strong , nonatomic)UIImageView *headImageView;
/* 图片数组 */
@property (copy , nonatomic)NSArray *imagesArray;

@end

static NSString *youhuiCollectionViewCellID = @"youhuiCollectionViewCellID";
//static NSString *DCGoodsHandheldCellID = @"DCGoodsHandheldCellID";


@implementation JinXuanLvZhuanCollectionViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
     self.collectionView;
    // Initialization code
}


#pragma mark - lazyload
- (UICollectionView *)collectionView
{
//    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
                layout.itemSize = CGSizeMake(ScreenW/3, ScreenW/3);
    
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
//        layout.itemSize = CGSizeMake(100, 200);
        _collectionView.collectionViewLayout = layout;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//        [self addSubview:_collectionView];
//        _collectionView.frame = CGRectMake(0, ScreenW * 0.35 + DCMargin, ScreenW, 200);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[YouHuiCell class] forCellWithReuseIdentifier:youhuiCollectionViewCellID];
//    }
    return _collectionView;
}


#pragma mark - Intial
//- (instancetype)initWithFrame:(CGRect)frame {
//
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.collectionView;
//        [self setUpUI];
//    }
//    return self;
//}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    //上面的那个cell,用一张_headImageView来显示
//    _headImageView = [[UIImageView alloc] init];
//    [self addSubview:_headImageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self);
//        make.left.mas_equalTo(self);
//        make.width.mas_equalTo(self);
//        //上面的那个imageview的高度
//        //        make.height.mas_equalTo(ScreenW * 0.32);
//        make.height.mas_equalTo(ScreenW * 0.35);
//    }];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return _imagesArray.count - 6;
     return 12;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YouHuiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:youhuiCollectionViewCellID forIndexPath:indexPath];
    cell.handheldImage = _imagesArray[indexPath.row + 3];
    return cell;
}


#pragma mark - Setter Getter Methods
- (void)setGoodExceedArray:(NSArray *)goodExceedArray
{
    _goodExceedArray = goodExceedArray;
    _imagesArray = goodExceedArray;
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
    [_rightTopImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[1]]];
    [_rightDownImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[2]]];
}


@end
