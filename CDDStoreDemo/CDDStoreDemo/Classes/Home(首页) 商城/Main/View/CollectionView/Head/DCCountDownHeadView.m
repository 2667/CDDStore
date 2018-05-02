//
//  DCCountDownHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCountDownHeadView.h"

// Controllers

// Models

// Views
#import "DCZuoWenRightButton.h"
// Vendors

// Categories

// Others

@interface DCCountDownHeadView ()

/* 红色块 */
@property (strong , nonatomic)UIView *redView;
/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;
/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;

/* 更多 */
@property (strong , nonatomic)DCZuoWenRightButton *quickButton;
@end

@implementation DCCountDownHeadView

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
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = [UIColor redColor];
    [self addSubview:_redView];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"限时秒杀";
//    _timeLabel.backgroundColor = [UIColor redColor];
    _timeLabel.textAlignment =NSTextAlignmentCenter;
    _timeLabel.font = PFR16Font;
    [self addSubview:_timeLabel];
    
    _countDownLabel = [[UILabel alloc] init];
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.text = @"05 : 58 : 33";
    _countDownLabel.font = PFR14Font;
    [self addSubview:_countDownLabel];
    
    _quickButton = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = PFR12Font;
//    _quickButton.titleLabel.font = PFR20Font;
    [_quickButton setImage:[UIImage imageNamed:@"shouye_icon_jiantou"] forState:UIControlStateNormal];
    [_quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_quickButton setTitle:@"更多" forState:UIControlStateNormal];
    [self addSubview:_quickButton];
    
    //底部分割线view
    CGFloat heightFenGeView = 0.5;
    UIView *fenGeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.dc_height-heightFenGeView, self.dc_width, heightFenGeView)];
    fenGeView.backgroundColor = [UIColor lightGrayColor];
     [self addSubview:fenGeView];

}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    _redView.frame = CGRectMake(0, 10, 8, 20);
     _redView.frame = CGRectMake(0, 0, 0, 0);
    _timeLabel.frame = CGRectMake(0, 0, 80, self.dc_height);
    _countDownLabel.frame = CGRectMake(CGRectGetMaxX(_timeLabel.frame), 0, 100, self.dc_height);
//    _quickButton.frame = CGRectMake(self.dc_width - 70, 0, 70, self.dc_height);
     _quickButton.frame = CGRectMake(self.dc_width - 50, 0, 40, self.dc_height);
}


#pragma mark - Setter Getter Methods


@end
