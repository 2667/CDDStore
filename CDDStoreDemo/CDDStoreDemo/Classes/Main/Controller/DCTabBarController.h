//
//  DCTabBarController.h
//  CDDMall
//
//  Created by apple on 2017/5/26.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger ,DCTabBarControllerType){
//    DCTabBarControllerMeiXin = 0,  //美信
//    DCTabBarControllerHome = 1, //首页
//    DCTabBarControllerMediaList = 2,  //美媚榜
//    DCTabBarControllerBeautyStore = 3, //美店
//    DCTabBarControllerPerson = 4, //个人中心
    
       DCTabBarControllerHome = 0, //首页/首页
    DCTabBarControllerMeiXin = 1,  //美信/分类
 
    DCTabBarControllerMediaList = 2,  //美媚榜/搜索
    DCTabBarControllerBeautyStore = 3, //美店/购物车
    DCTabBarControllerPerson = 4, //个人中心
    
};

@interface DCTabBarController : UITabBarController

/* 控制器type */
@property (assign , nonatomic)DCTabBarControllerType tabVcType;

@end
