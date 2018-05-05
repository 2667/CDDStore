//
//  DCHandPickViewController.m
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCHandPickViewController.h"

// Controllers
#import "DCNavigationController.h"
#import "DCGoodsSetViewController.h"
#import "DCCommodityViewController.h"
#import "DCMyTrolleyViewController.h"
#import "DCGoodDetailViewController.h"
#import "DCGMScanViewController.h"
// Models
#import "DCGridItem.h"
#import "DCRecommendItem.h"
// Views
#import "DCNavSearchBarView.h"
#import "DCHomeTopToolView.h"
/* cell */
#import "DCGoodsCountDownCell.h" //倒计时商品
#import "DCNewWelfareCell.h"     //新人福利
#import "DCGoodsHandheldCell.h"  //掌上专享
#import "DCExceedApplianceCell.h"//不止
#import "DCGoodsYouLikeCell.h"   //猜你喜欢商品
#import "DCGoodsGridCell.h"      //10个选项
/* head */
#import "DCSlideshowHeadView.h"  //轮播图
#import "DCCountDownHeadView.h"  //倒计时标语
#import "DCYouLikeHeadView.h"    //猜你喜欢等头部标语
/* foot */
#import "DCTopLineFootView.h"    //热点
#import "DCOverFootView.h"       //结束
#import "DCScrollAdFootView.h"   //底滚动广告
// Vendors
#import "DCHomeRefreshGifHeader.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
// Categories
#import "UIBarButtonItem+DCBarButtonItem.h"
// Others
#import "CDDTopTip.h"
#import "NetworkUnit.h"
#import "YouHuiCollectionViewCell.h"
#import "JinXuanLvZhuanCollectionViewCell.h"
#import "MeiZhuanTopCollectionViewCell.h"
#import "MeiZhuanMiddleCollectionViewCell.h"
#import "MeiZhuanBottomCollectionViewCell.h"
#import "ThreeImageCollectionViewCell.h"
#import "ChaoWanSecondCollectionViewCell.h"
#import "YouXuanCollectionViewCell.h"
#import "GuessGoodsYouLikeCollectionViewCell.h"
@interface DCHandPickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;
/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *youLikeItem;
/* 顶部工具View */
@property (nonatomic, strong) DCHomeTopToolView *topToolView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;

@end
/* cell */
static NSString *const DCGoodsCountDownCellID = @"DCGoodsCountDownCell";
static NSString *const DCNewWelfareCellID = @"DCNewWelfareCell";
static NSString *const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";
static NSString *const JinXuanLvZhuanCellID = @"JinXuanLvZhuanCellID";
static NSString *const DCGoodsYouLikeCellID = @"DCGoodsYouLikeCell";
static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
static NSString *const youhuiCellID = @"youhuiCellID";
static NSString *const DCExceedApplianceCellID = @"DCExceedApplianceCell";
/* head */
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const DCCountDownHeadViewID = @"DCCountDownHeadView";
static NSString *const DCYouLikeHeadViewID = @"DCYouLikeHeadView";
/* foot */
static NSString *const DCTopLineFootViewID = @"DCTopLineFootView";
static NSString *const DCOverFootViewID = @"DCOverFootView";
static NSString *const DCScrollAdFootViewID = @"DCScrollAdFootView";
static NSString *const meizhuantopcellID = @"meizhuantopcellID";
static NSString *const MeiZhuanMiddleCellID = @"MeiZhuanMiddleCellID";
static NSString *const MeiZhuanBottomCellID = @"MeiZhuanBottomCellID";
static NSString *const ThreeImageCellID = @"ThreeImageCellID";
static NSString *const CaoWanSecondCellID = @"CaoWanSecondCellID";
static NSString *const YouXuanCellID = @"YouXuanCellID";
static NSString *const GuessGoodsYouLikeCellID = @"GuessGoodsYouLikeCellID";


@implementation DCHandPickViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        NSLog(@"DCBottomTabH内容是%f",DCBottomTabH);
        
        //适配iphonex的导航栏和tabbar高度
        if (KIsiPhoneX) {
            _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH-34);
        }else{
          _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH);
            
        }
//        _collectionView.frame = CGRectMake(0, 0, ScreenW, ScreenH - DCBottomTabH*2);
        _collectionView.showsVerticalScrollIndicator = NO;

        //注册
        //下面的商品统计
        [_collectionView registerClass:[DCGoodsCountDownCell class] forCellWithReuseIdentifier:DCGoodsCountDownCellID];
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YouHuiCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:youhuiCellID];
//        手拿的商品
        [_collectionView registerClass:[DCGoodsHandheldCell class] forCellWithReuseIdentifier:DCGoodsHandheldCellID];
        
        
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([JinXuanLvZhuanCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:JinXuanLvZhuanCellID];
        
        //你喜欢的商品
        [_collectionView registerClass:[DCGoodsYouLikeCell class] forCellWithReuseIdentifier:DCGoodsYouLikeCellID];
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MeiZhuanTopCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:meizhuantopcellID];
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MeiZhuanMiddleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:MeiZhuanMiddleCellID];
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MeiZhuanBottomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:MeiZhuanBottomCellID];
        
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ThreeImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ThreeImageCellID];
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ChaoWanSecondCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:CaoWanSecondCellID];
        
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([YouXuanCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:YouXuanCellID];
        //xib自定义的cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GuessGoodsYouLikeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:GuessGoodsYouLikeCellID];
        
        //格子
        [_collectionView registerClass:[DCGoodsGridCell class] forCellWithReuseIdentifier:DCGoodsGridCellID];
//        超出的家用电器
        [_collectionView registerClass:[DCExceedApplianceCell class] forCellWithReuseIdentifier:DCExceedApplianceCellID];
        //新福利
        [_collectionView registerClass:[DCNewWelfareCell class] forCellWithReuseIdentifier:DCNewWelfareCellID];
        
//        顶部foot线, 手机潮品 嗨购不停那个广告和下面的国美头条广告
        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID];
//         结束footview
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID];
//        滚动广告FootView  3个图那个滚动广告
        [_collectionView registerClass:[DCScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID];
//        你喜欢的HeadView
        [_collectionView registerClass:[DCYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID];
//        幻灯展示HeadView
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID];
        //下面统计headview   限时秒杀那个headview
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpBase];
    
    [self setUpNavTopView];
    
    [self setUpGoodsData];
    
    [self setUpScrollToTopView];
    
    [self setUpGIFRrfresh];
    
    [self getNetwork];
}

#pragma mark - initialize
- (void)setUpBase
{
    self.collectionView.backgroundColor = DCBGColor;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


#pragma mark - 获取网络
- (void)getNetwork
{
    if ([[NetworkUnit getInternetStatus] isEqualToString:@"notReachable"]) { //网络
        [CDDTopTip showTopTipWithMessage:@"您现在暂无可用网络"];
    }
}


#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    self.collectionView.mj_header = [DCHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
}

#pragma mark - 刷新
- (void)setUpRecData
{
    WEAKSELF
    [DCSpeedy dc_callFeedback]; //触动
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}

#pragma mark - 加载数据
- (void)setUpGoodsData
{
    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}

#pragma mark - 滚回顶部
- (void)setUpScrollToTopView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 110, 40, 40);
}

#pragma mark - 导航栏处理
- (void)setUpNavTopView
{
    //适配iphonex的导航栏和tabbar高度
    if (KIsiPhoneX) {

         _topToolView = [[DCHomeTopToolView alloc] initWithFrame:CGRectMake(0,0, ScreenW, 64+24)];
    }else{
          _topToolView = [[DCHomeTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
        
    }

    WEAKSELF
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了首页扫一扫");
        DCGMScanViewController *dcGMvC = [DCGMScanViewController new];
        [weakSelf.navigationController pushViewController:dcGMvC animated:YES];
    };
    _topToolView.rightItemClickBlock = ^{
        NSLog(@"点击了首页分类");
        DCCommodityViewController *dcComVc = [DCCommodityViewController new];
        [weakSelf.navigationController pushViewController:dcComVc animated:YES];
    };
    _topToolView.rightRItemClickBlock = ^{
        NSLog(@"点击了首页购物车");
        DCMyTrolleyViewController *shopCarVc = [DCMyTrolleyViewController new];
        shopCarVc.isTabBar = YES;
        shopCarVc.title = @"购物车";
        [weakSelf.navigationController pushViewController:shopCarVc animated:YES];
    };
    _topToolView.searchButtonClickBlock = ^{
        NSLog(@"点击了首页搜索");
    };
    _topToolView.voiceButtonClickBlock = ^{
        NSLog(@"点击了首页语音");
    };
    [self.view addSubview:_topToolView];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 9;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //10属性
        return _gridItem.count;
    }
    if (section == 1 || section == 2 || section == 3) { //广告福利  倒计时  掌上专享
        return 1;
    }
    if (section == 4) { //推荐  精选女装
//        return GoodsHandheldImagesArray.count;
        return 1;
        
    }
    if (section == 5) {
        //猜你喜欢/时尚美妆/国美精选
//        return _youLikeItem.count;
        return 7;
    }
    if (section == 6) {
        //猜你喜欢/时尚美妆/国美精选
        //        return _youLikeItem.count;
        return 6;
    }
    if (section == 7) {
        //猜你喜欢/时尚美妆/国美精选
        //        return _youLikeItem.count;
        return 4;
    }
    if (section == 8) {
        //猜你喜欢/时尚美妆/国美精选
        //        return _youLikeItem.count;
        return 1;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//10
        DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
        
    }else if (indexPath.section == 1) {
        //广告福利 商城热点/国美头条下面的4个cell
        DCNewWelfareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCNewWelfareCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 2) {//倒计时  限时秒杀
        DCGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsCountDownCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 3) {//掌上专享 尖货峰慧/冬季洁净行 品牌狂欢购 cell里面有4个图片
        //1个上面的cell 加6个下面的cell
//        DCExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCExceedApplianceCellID forIndexPath:indexPath];
//        cell.goodExceedArray = GoodsRecommendArray;
//        gridcell = cell;
        
        
        YouHuiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:youhuiCellID forIndexPath:indexPath];
        cell.goodExceedArray = GoodsRecommendArray;
        gridcell = cell;
        //添加点击事件
        [self addTapGesture:cell];

    }
    else if (indexPath.section == 4) {
        //推荐  //精选女装/优质家电
//        DCGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsHandheldCellID forIndexPath:indexPath];
//        NSArray *images = GoodsHandheldImagesArray;
//        cell.handheldImage = images[indexPath.row];
//        gridcell = cell;
        
        JinXuanLvZhuanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JinXuanLvZhuanCellID forIndexPath:indexPath];
//        NSArray *images = GoodsHandheldImagesArray;
        NSMutableArray *array1 = [NSMutableArray arrayWithArray:GoodsHandheldImagesArray];
        [array1 addObjectsFromArray:array1];
        [array1 addObjectsFromArray:array1];
        cell.goodExceedArray = array1;
//        cell.goodExceedArray = GoodsHandheldImagesArray;
        gridcell = cell;
        
        
        
        
    }
    else if (indexPath.section == 5) {
        if (indexPath.row==0 || indexPath.row == 1) {
            //猜你喜欢/国美精选/时尚美妆
            MeiZhuanTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:meizhuantopcellID forIndexPath:indexPath];
//            cell.lookSameBlock = ^{
//                NSLog(@"点击了第%zd商品的找相似",indexPath.row);
//            };
            
            cell.imageUrlString = _youLikeItem[indexPath.row].image_url;
            
            gridcell = cell;
//            cell.AimageUrlString = @"http://gfs17.gomein.net.cn/T1cRbvBmWv1RCvBVdK_400.jpg";
        }else if (indexPath.row==2 || indexPath.row == 3){
//        //猜你喜欢/国美精选/时尚美妆
        MeiZhuanMiddleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MeiZhuanMiddleCellID forIndexPath:indexPath];
            cell.imageUrlString = _youLikeItem[indexPath.row].image_url;
            cell.bottomTitleLabel.text =_youLikeItem[indexPath.row].main_title;
            cell.topTitleLabel.text =_youLikeItem[indexPath.row].goods_title;
//             cell.imageUrlString = @"http://gfs17.gomein.net.cn/T1cRbvBmWv1RCvBVdK_400.jpg";
//        cell.lookSameBlock = ^{
//            NSLog(@"点击了第%zd商品的找相似",indexPath.row);
//        };
//        cell.youLikeItem = _youLikeItem[indexPath.row];
        gridcell = cell;
       
        }else if (indexPath.row==4 || indexPath.row == 5 || indexPath.row == 6){
        //猜你喜欢/国美精选/时尚美妆
            MeiZhuanBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MeiZhuanBottomCellID forIndexPath:indexPath];
            cell.imageUrlString = _youLikeItem[indexPath.row].image_url;
            cell.bottomTitleLabel.text =_youLikeItem[indexPath.row].main_title;
            cell.topTitleLabel.text =_youLikeItem[indexPath.row].goods_title;
            
//            cell.imageUrlString = @"http://gfs17.gomein.net.cn/T1cRbvBmWv1RCvBVdK_400.jpg";
            
            //        cell.lookSameBlock = ^{
            //            NSLog(@"点击了第%zd商品的找相似",indexPath.row);
            //        };
            //        cell.youLikeItem = _youLikeItem[indexPath.row];
            gridcell = cell;
            
        }
        
    }else if (indexPath.section == 6) {
        if (indexPath.row==0) {
            // /潮玩数码
            ThreeImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ThreeImageCellID forIndexPath:indexPath];
            cell.goodExceedArray = GoodsHandheldImagesArray;
            //            cell.lookSameBlock = ^{
            //                NSLog(@"点击了第%zd商品的找相似",indexPath.row);
            //            };
            
//            cell.imageUrlString = _youLikeItem[indexPath.row].image_url;
            
            gridcell = cell;
            //            cell.AimageUrlString = @"http://gfs17.gomein.net.cn/T1cRbvBmWv1RCvBVdK_400.jpg";
        }else if (indexPath.row==1 || indexPath.row == 2){
            //section == 6
            ChaoWanSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CaoWanSecondCellID forIndexPath:indexPath];
            NSString *urlStr = _youLikeItem[indexPath.row].image_url;
            cell.goodExceedArray = @[urlStr,urlStr];
            cell.subTitleLabel.text =_youLikeItem[indexPath.row].main_title;
            cell.mainTitleLabel.text =_youLikeItem[indexPath.row].goods_title;
         
            //        cell.lookSameBlock = ^{
            //            NSLog(@"点击了第%zd商品的找相似",indexPath.row);
            //        };
            //        cell.youLikeItem = _youLikeItem[indexPath.row];
            gridcell = cell;
            
        }else if (indexPath.row==3 || indexPath.row == 4 || indexPath.row == 5){
//            section == 6 潮玩数码
            MeiZhuanBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MeiZhuanBottomCellID forIndexPath:indexPath];
            cell.imageUrlString = _youLikeItem[indexPath.row].image_url;
            cell.bottomTitleLabel.text =_youLikeItem[indexPath.row].main_title;
            cell.topTitleLabel.text =_youLikeItem[indexPath.row].goods_title;

            
            //        cell.lookSameBlock = ^{
            //            NSLog(@"点击了第%zd商品的找相似",indexPath.row);
            //        };
            //        cell.youLikeItem = _youLikeItem[indexPath.row];
            gridcell = cell;
            
        }
        
    }else if (indexPath.section == 7) {
//        if (indexPath.row==0) {
            // /潮玩数码
            YouXuanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YouXuanCellID forIndexPath:indexPath];
            cell.goodExceedArray = GoodsHandheldImagesArray;
            //            cell.lookSameBlock = ^{
            //                NSLog(@"点击了第%zd商品的找相似",indexPath.row);
            //            };
            
            cell.biaoYuLabel.text = _youLikeItem[indexPath.row].goods_title;
        cell.shopNameLabel.text = _youLikeItem[indexPath.row].main_title;
        
            gridcell = cell;
            //            cell.AimageUrlString = @"http://gfs17.gomein.net.cn/T1cRbvBmWv1RCvBVdK_400.jpg";
    }else if (indexPath.section == 8) {
        //        if (indexPath.row==0) {
        // /潮玩数码
        GuessGoodsYouLikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GuessGoodsYouLikeCellID forIndexPath:indexPath];
        cell.goodExceedArray = GoodsHandheldImagesArray;
        //            cell.lookSameBlock = ^{
        //                NSLog(@"点击了第%zd商品的找相似",indexPath.row);
        //            };
        
//        cell.biaoYuLabel.text = _youLikeItem[indexPath.row].goods_title;
//        cell.shopNameLabel.text = _youLikeItem[indexPath.row].main_title;
        
        gridcell = cell;
        //            cell.AimageUrlString = @"http://gfs17.gomein.net.cn/T1cRbvBmWv1RCvBVdK_400.jpg";
    }
    
    
    return gridcell;
}

//在这个方法里面返回SectionHeader和sectionfooter
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
            headerView.imageGroupArray = GoodsHomeSilderImagesArray;
            reusableview = headerView;
        }else if (indexPath.section == 2){
            DCCountDownHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }else if (indexPath.section == 4){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs7.gomein.net.cn/T1WudvBm_T1RCvBVdK.png"]];
            reusableview = headerView;
        }else if (indexPath.section == 5){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs5.gomein.net.cn/T16LLvByZj1RCvBVdK.png"]];
            reusableview = headerView;
        }else if (indexPath.section == 6){
            //本应显示"优选店铺"
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs5.gomein.net.cn/T16LLvByZj1RCvBVdK.png"]];
            reusableview = headerView;
        }else if (indexPath.section == 7){
            //本应显示"优选店铺"
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs5.gomein.net.cn/T16LLvByZj1RCvBVdK.png"]];
            reusableview = headerView;
        }else if (indexPath.section == 8){
            //本应显示"猜你喜欢"
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            [headerView.likeImageView sd_setImageWithURL:[NSURL URLWithString:@"http://gfs5.gomein.net.cn/T16LLvByZj1RCvBVdK.png"]];
            reusableview = headerView;
        }

    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            DCTopLineFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID forIndexPath:indexPath];
            reusableview = footview;
//        }else if (indexPath.section == 3){
        }else if (indexPath.section == 4){
            //3个滚动图那个广告
            DCScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID forIndexPath:indexPath];
            reusableview = footerView;
        }else if (indexPath.section == 5) {
//            显示"看完喽，下次在逛吧"的这个view
//            DCOverFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID forIndexPath:indexPath];
//            reusableview = footview;
            
            
            //3个滚动图那个广告
            DCScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID forIndexPath:indexPath];
            reusableview = footerView;
        }else if (indexPath.section == 6) {
            //            显示"看完喽，下次在逛吧"的这个view
            //            DCOverFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID forIndexPath:indexPath];
            //            reusableview = footview;
            
            
            //3个滚动图那个广告
            DCScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID forIndexPath:indexPath];
            reusableview = footerView;
        }
        
        
        
    }

    return reusableview;
}


//为cell里面的4个图片添加点击事件
-(void)addTapGesture:(YouHuiCollectionViewCell*)cell{
     cell.userInteractionEnabled = YES;
    cell.topImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topImageViewTapped:)];
    [cell.topImageView addGestureRecognizer:singleTap1];
    
    cell.topImageView.userInteractionEnabled=YES;
    
    
    cell.leftImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftImageViewTapped:)];
    [cell.leftImageView addGestureRecognizer:singleTap2];
    
    cell.leftImageView.userInteractionEnabled=YES;
    
    cell.downTopImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* singleTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(downTopImageViewTapped:)];
    [cell.downTopImageView addGestureRecognizer:singleTap3];
    
    cell.downTopImageView.userInteractionEnabled=YES;
    
    cell.downBottomImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer* singleTap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(downBottomImageViewTapped:)];
    [cell.downBottomImageView addGestureRecognizer:singleTap4];
    
    cell.downBottomImageView.userInteractionEnabled=YES;
}
#pragma mark 优惠cell里面4个图片的点击事件
-(void)topImageViewTapped:(UIImageView*)imageView{
    
    
    
}
//cell里面4个图片的点击事件
-(void)leftImageViewTapped:(UIImageView*)imageView{
    
    
    
}
//cell里面4个图片的点击事件
-(void)downTopImageViewTapped:(UIImageView*)imageView{
    
    
    
}
//cell里面4个图片的点击事件
-(void)downBottomImageViewTapped:(UIImageView*)imageView{
    
    
    
}



//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {//9宫格组
        return CGSizeMake(ScreenW/5 , ScreenW/5 + DCMargin);
    }
    if (indexPath.section == 1) {//广告
        return CGSizeMake(ScreenW, 180);
    }
    if (indexPath.section == 2) {//计时
        return CGSizeMake(ScreenW, 150);
    }
    if (indexPath.section == 3) {//掌上 尖货峰慧
//        return CGSizeMake(ScreenW,ScreenW * 0.35 + 120);
          return CGSizeMake(ScreenW,260);
    }
    if (indexPath.section == 4) {//推荐组 精选女装
//        return [self layoutAttributesForItemAtIndexPath:indexPath].size;
        //10是底部灰色分割view的高度
        return CGSizeMake(ScreenW,200+ScreenW/3+10);
    }
    if (indexPath.section == 5) {//猜你喜欢/时尚美妆
//        return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 40);
       
         return [self layoutAttributesForItemAtIndexPath:indexPath].size;
        
    }
    if (indexPath.section == 6) {//潮玩数码
        //        return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 40);
        
        return [self layoutAttributesForItemAtIndexPath:indexPath].size;
        
    }
    if (indexPath.section == 7) {//潮玩数码
        //        return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 40);
          return CGSizeMake((ScreenW-10)/2,(ScreenW-10)/2);
//        return [self layoutAttributesForItemAtIndexPath:indexPath].size;
        
    }
    if (indexPath.section == 8) {//推荐组 精选女装
        //        return [self layoutAttributesForItemAtIndexPath:indexPath].size;
        //10是底部灰色分割view的高度
        return CGSizeMake(ScreenW,200);
    }
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    if (indexPath.section == 4) {
//        if (indexPath.row == 0) {
//            layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.38);
//        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
//            layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.24);
//        }else{
//            layoutAttributes.size = CGSizeMake(ScreenW * 0.25, ScreenW * 0.35);
//        }
//    }
    
//    if (indexPath.section == 4) {
//                if (indexPath.row == 0) {
//                    layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.38);
//                }else if (indexPath.row == 1 ){
//                    layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.48);
//                }else if (indexPath.row == 2 || indexPath.row == 3){
//                    layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.15);
//                }
//                else{
//
//                    layoutAttributes.size = CGSizeMake(ScreenW/5, ScreenW * 0.35);
//                }
//            }
    
    if (indexPath.section == 5) {
                if (indexPath.row == 0 || indexPath.row == 1) {
                    layoutAttributes.size = CGSizeMake(ScreenW/2, ScreenW/2);
                }else if (indexPath.row == 2 || indexPath.row == 3 ){
                    layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.20);
                }else{
                    layoutAttributes.size = CGSizeMake(ScreenW /3, ScreenW * 0.45);
                }
            }
    
    if (indexPath.section == 6) {
        //潮玩数码
        if (indexPath.row == 0 ) {
            layoutAttributes.size = CGSizeMake(ScreenW, 200);
        }else if (indexPath.row == 1 || indexPath.row == 2 ){
            layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.35);
        }else{
            layoutAttributes.size = CGSizeMake(ScreenW /3, ScreenW * 0.45);
        }
    }
    
    
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return CGSizeMake(ScreenW, 230); //图片滚动的宽高
    }
    if (section == 4 || section == 5 || section == 6 || section == 7 || section == 8) {//猜你喜欢的宽高
        return CGSizeMake(ScreenW, 40);  //推荐适合的宽高
    }
    
    if (section == 2) {
        //限时秒杀的宽高
        return CGSizeMake(ScreenW, 75);
        
    }
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        //显示手机潮品嗨购不停的那一行
        return CGSizeMake(ScreenW, 180);  //Top头条的宽高
//        return CGSizeMake(ScreenW, 90);
    }
//    if (section == 3) {
    if (section == 4) {
        return CGSizeMake(ScreenW, 100); // 滚动广告
    }
    if (section == 5) {
//        return CGSizeMake(ScreenW, 40); // 结束
        return CGSizeMake(ScreenW, 100); // 结束
    }
    if (section == 6) {
        //        return CGSizeMake(ScreenW, 40); // 结束
        return CGSizeMake(ScreenW, 100); // 结束
    }
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 7) ? 10 : 0;
//    return 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 7) ? 10 : 0;
//    return  0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//10
        
        DCGoodsSetViewController *goodSetVc = [[DCGoodsSetViewController alloc] init];
        goodSetVc.goodPlisName = @"ClasiftyGoods.plist";
        [self.navigationController pushViewController:goodSetVc animated:YES];
        NSLog(@"点击了10个属性第%zd",indexPath.row);
    }else if (indexPath.section == 5){
        NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
        
        DCGoodDetailViewController *dcVc = [[DCGoodDetailViewController alloc] init];
        dcVc.goodTitle = _youLikeItem[indexPath.row].main_title;
        dcVc.goodPrice = _youLikeItem[indexPath.row].price;
        dcVc.goodSubtitle = _youLikeItem[indexPath.row].goods_title;
        dcVc.shufflingArray = _youLikeItem[indexPath.row].images;
        dcVc.goodImageView = _youLikeItem[indexPath.row].image_url;
        
        [self.navigationController pushViewController:dcVc animated:YES];
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;//判断回到顶部按钮是否隐藏
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;//判断顶部工具View的显示和隐形
    
    if (scrollView.contentOffset.y > DCNaviH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        [[NSNotificationCenter defaultCenter]postNotificationName:SHOWTOPTOOLVIEW object:nil];
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        [[NSNotificationCenter defaultCenter]postNotificationName:HIDETOPTOOLVIEW object:nil];
    }
}

#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - 消息
- (void)messageItemClick
{

}
@end
