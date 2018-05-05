//
//  DCScrollAdFootView.m
//  CDDMall
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCScrollAdFootView.h"

#import <SDCycleScrollView.h>

@interface DCScrollAdFootView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;

@end

@implementation DCScrollAdFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
//    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, self.dc_height) delegate:self placeholderImage:nil];
    // 10是下面灰色分割view的高度
//       _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, self.dc_height-10) delegate:self placeholderImage:nil];
    
    // 10是下面灰色分割view的高度
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 10, ScreenW, self.dc_height-20) delegate:self placeholderImage:nil];
    
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.imageURLStringsGroup = GoodsFooterImagesArray;
    
    [self addSubview:_cycleScrollView];
    
    //底部分割线view
    UIView *fengeview = [[UIView alloc]initWithFrame:CGRectMake(0, self.dc_height-10, ScreenW, 10)];
    fengeview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:fengeview];
    
    //顶部分割线view
    UIView *topfengeview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    topfengeview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:topfengeview];
    
}

#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods

@end
