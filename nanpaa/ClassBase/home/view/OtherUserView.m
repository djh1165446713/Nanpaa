//
//  OtherUserView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/9.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "OtherUserView.h"

@implementation OtherUserView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    ______WS();
    
    _bgView = [[UIView alloc] init];
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 8;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf).offset(0);
        make.bottom.equalTo(wSelf).offset(0);
        make.top.equalTo(wSelf.mas_top).offset(42);
        make.right.equalTo(wSelf).offset(0);
    }];
    
    
    _headImgBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _headImgBtn.layer.masksToBounds = YES;
    _headImgBtn.layer.cornerRadius = 40;
    //        [_headImgBtn addTarget:self action:@selector(setHeadImgAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_headImgBtn ];
    [_headImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(80);
        make.centerY.equalTo(wSelf.bgView.mas_top).offset(0);
        make.left.equalTo(wSelf).offset(16);
    }];
    
    _userNameLab = [[UILabel alloc] init];
    _userNameLab.font = [UIFont systemFontOfSize:12];
    _userNameLab.textColor = [UIColor blackColor];
    _userNameLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_userNameLab];
    [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.headImgBtn.mas_bottom).offset(8);
        make.height.offset(13);
        make.width.offset(kScreenWidth);
        make.centerX.equalTo(wSelf.headImgBtn);
        
    }];
    
    
    _shareIcon = [[UIImageView alloc] init];
    _shareIcon.image = [UIImage imageNamed:@"share_one"];
    _shareIcon.userInteractionEnabled = YES;
    [self addSubview:_shareIcon];
    [_shareIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.bgView.mas_top).offset(13);
        make.height.offset(35);
        make.width.offset(35);
        make.right.equalTo(wSelf.mas_right).offset(-22);
    }];
    
    
    // 关注
    _pointCoin = [[UIImageView alloc] init];
    _pointCoin.image = [UIImage imageNamed:@"followHis"];
    _pointCoin.userInteractionEnabled = YES;
    [self addSubview:_pointCoin];
    [_pointCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.headImgBtn.mas_centerY).offset(84);
        make.height.offset(14);
        make.width.offset(14);
        make.left.equalTo(wSelf).offset(23);
    }];
    
    self.pointLab = [[UILabel alloc] init];
    self.pointLab.textColor = RGB(102, 102, 102);
    self.pointLab.font = [UIFont systemFontOfSize:10];
    self.pointLab.userInteractionEnabled = YES;
    self.pointLab.text = @"follower";
    [self addSubview:self.pointLab];
    [self.pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.pointCoin.mas_right).offset(7);
        make.centerY.equalTo(wSelf.pointCoin).offset(0);
        make.width.offset(50);
        make.height.offset(11);
    }];
    
    
    self.pointNum = [[UILabel alloc] init];
    self.pointNum.textColor = RGB(212, 39, 82);
    self.pointNum.font = [UIFont systemFontOfSize:15];
    self.pointNum.userInteractionEnabled = YES;
    self.pointNum.text = @"0";
    [self addSubview:self.pointNum];
    [self.pointNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.pointLab.mas_right).offset(20);
        make.centerY.equalTo(wSelf.pointCoin).offset(0);
        make.width.offset(180);
        make.height.offset(16);
    }];
    
    
    _incomeCoin = [[UIImageView alloc] init];
    _incomeCoin.image = [UIImage imageNamed:@"followingHis"];
    _incomeCoin.userInteractionEnabled = YES;
    [self addSubview:_incomeCoin];
    [_incomeCoin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.pointCoin.mas_bottom).offset(12);
        make.height.offset(14);
        make.width.offset(14);
        make.left.equalTo(wSelf).offset(23);
    }];
    
    // 粉丝
    self.incomeLab = [[UILabel alloc] init];
    self.incomeLab.textColor = RGB(102, 102, 102);
    self.incomeLab.text = @"following";
    self.incomeLab.font = [UIFont systemFontOfSize:10];
    self.incomeLab.userInteractionEnabled = YES;
    [self addSubview:self.incomeLab];
    [self.incomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.incomeCoin.mas_right).offset(7);
        make.centerY.equalTo(wSelf.incomeCoin).offset(0);
        make.width.offset(50);
        make.height.offset(11);
    }];
    
    
    self.incomeNum = [[UILabel alloc] init];
    self.incomeNum.textColor = RGB(212, 39, 82);
    self.incomeNum.font = [UIFont systemFontOfSize:15];
    self.incomeNum.userInteractionEnabled = YES;
    self.incomeNum.text = @"0";
    [self addSubview:self.incomeNum];
    [self.incomeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.incomeLab.mas_right).offset(20);
        make.centerY.equalTo(wSelf.incomeCoin).offset(0);
        make.width.offset(180);
        make.height.offset(16);
    }];
    
    _friendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _friendBtn.layer.masksToBounds = YES;
    _friendBtn.layer.cornerRadius = 6;
    _friendBtn.backgroundColor = RGB(212, 39, 82);
//    [_buyBtn setTitle:@"Buy Point" forState:(UIControlStateNormal)];
    [_friendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    //        [_buyBtn addTarget:self action:@selector(invitaAciton) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_friendBtn ];
    [_friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.pointLab.mas_top).offset(0);
        make.bottom.equalTo(wSelf.incomeLab.mas_bottom).offset(0);
        make.width.offset(112);
        make.right.equalTo(wSelf.mas_right).offset(-33);
    }];
    
    
    // 已关注
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = RGB(153, 153, 153);
    _lineView.hidden = YES;
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.mas_bottom).offset(-12);
        make.centerX.equalTo(wSelf);
        make.height.offset(30);
        make.width.offset(1);
    }];

    // 未关注
    _line2View = [[UIView alloc] init];
    _line2View.backgroundColor = RGB(238, 238, 238);
    _line2View.hidden = YES;
    [self addSubview:_line2View];
    [_line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.mas_bottom).offset(-43);
        make.centerX.equalTo(wSelf);
        make.height.offset(1);
        make.left.equalTo(wSelf).offset(0);
        make.right.equalTo(wSelf.mas_right).offset(0);
    }];
    

    // 已关注
    _sendMessageBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _sendMessageBtn.titleLabel.font = [UIFont systemFontOfSize:12];;
    [_sendMessageBtn setTitle:@"Send Message" forState:(UIControlStateNormal)];
    [_sendMessageBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    _sendMessageBtn.hidden = YES;
    [self addSubview:_sendMessageBtn ];
    [_sendMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30);
        make.left.equalTo(wSelf.mas_left).offset(24);
        make.right.equalTo(wSelf.lineView.mas_left).offset(-24);
        make.centerY.equalTo(wSelf.lineView);

    }];


    _giftPointsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _giftPointsBtn.hidden = YES;
    [_giftPointsBtn setTitle:@"Gift Nanpaa Points" forState:(UIControlStateNormal)];
    _giftPointsBtn.titleLabel.font = [UIFont systemFontOfSize:12];;
    [_giftPointsBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self addSubview:_giftPointsBtn];
    [_giftPointsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(30);
        make.left.equalTo(wSelf.lineView.mas_right).offset(24);
        make.right.equalTo(wSelf.mas_right).offset(-24);
        make.centerY.equalTo(wSelf.lineView);
    }];
    
    // 未关注
    _giftAndPointsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _giftAndPointsBtn.hidden = YES;
    [_giftAndPointsBtn setTitle:@"Gift & Point" forState:(UIControlStateNormal)];
    _giftAndPointsBtn.titleLabel.font = [UIFont systemFontOfSize:15];;
    [_giftAndPointsBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [self addSubview:_giftAndPointsBtn];
    [_giftAndPointsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(43);
        make.left.equalTo(wSelf.mas_left).offset(0);
        make.right.equalTo(wSelf.mas_right).offset(0);
        make.centerY.equalTo(wSelf.lineView);
    }];

}

@end
