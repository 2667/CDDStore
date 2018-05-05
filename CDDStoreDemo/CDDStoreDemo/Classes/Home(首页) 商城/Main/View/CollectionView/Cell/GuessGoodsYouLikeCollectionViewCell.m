//
//  GuessGoodsYouLikeCollectionViewCell.m
//  CDDStoreDemo
//
//  Created by 曦胜 on 2018/5/5.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "GuessGoodsYouLikeCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "GuessYouLikeCollectionViewCell.h"
#import "ELCVFlowLayout.h"

@interface GuessGoodsYouLikeCollectionViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


/* 头部ImageView */
@property (strong , nonatomic)UIImageView *headImageView;
/* 图片数组 */
@property (copy , nonatomic)NSArray *imagesArray;

@end

static NSString *GuessYouLikeCellID = @"GuessYouLikeCellID";

@implementation GuessGoodsYouLikeCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
//    self.collectionView;
    
    [self setUpCollectionView];
    
    // Initialization code
}


#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    //    if (!_collectionView) {
    ELCVFlowLayout *layout = [[ELCVFlowLayout alloc]init];
//    layout.itemSize = CGSizeMake(ScreenW/3, ScreenW/3);
        layout.itemSize = CGSizeMake(ScreenW/3, 200);
    
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
    
    //注册代码定义的cell
//    [_collectionView registerClass:[GuessYouLikeCollectionViewCell class] forCellWithReuseIdentifier:GuessYouLikeCellID];
    //注册xib自定义的cell
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GuessYouLikeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:GuessYouLikeCellID];
    //    }
    return _collectionView;
}

//在用的
-(void)setUpCollectionView{
    //横向滚动
    ELCVFlowLayout *horizontalLayout = [[ELCVFlowLayout alloc] init];
    
    _collectionView.collectionViewLayout = horizontalLayout;
    horizontalLayout.itemSize = CGSizeMake(ScreenW/3.0, 200);
    
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.pagingEnabled = YES;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = YES;
    _collectionView.bounces = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册代码定义的cell
    //    [_collectionView registerClass:[GuessYouLikeCollectionViewCell class] forCellWithReuseIdentifier:GuessYouLikeCellID];
    //注册xib自定义的cell
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GuessYouLikeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:GuessYouLikeCellID];
//    return _collectionView;
    
}


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
    GuessYouLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GuessYouLikeCellID forIndexPath:indexPath];
//构造数据
    NSMutableArray *array1 = [NSMutableArray arrayWithArray:_goodExceedArray];
    [array1 addObject:_goodExceedArray[0]];
    [array1 addObject:_goodExceedArray[1]];
    [array1 addObject:_goodExceedArray[2]];
    NSArray *arra2 = [NSArray arrayWithObject:array1[indexPath.row]];
    cell.goodExceedArray = arra2;
//    NSLog(@"_goodExceedArray内容是%@",_goodExceedArray);
//    NSLog(@"array1内容是%@",array1);
    return cell;
}


#pragma mark - Setter Getter Methods
- (void)setGoodExceedArray:(NSArray *)goodExceedArray
{
    _goodExceedArray = goodExceedArray;
//    _imagesArray = goodExceedArray;
//    
//    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
//    [_rightTopImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[1]]];
//    [_rightDownImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[2]]];
}


@end
