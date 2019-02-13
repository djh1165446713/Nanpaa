
//
//  MyinformationView.m
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/17.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import "MyinformationView.h"

@implementation MyinformationView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
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
        
        
        _pointCoin = [[UIImageView alloc] init];
        _pointCoin.image = [UIImage imageNamed:@"myMomny"];
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
        self.pointLab.text = @"point";
        [self addSubview:self.pointLab];
        [self.pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.pointCoin.mas_right).offset(7);
            make.centerY.equalTo(wSelf.pointCoin).offset(0);
            make.width.offset(40);
            make.height.offset(11);
        }];
        
        
        self.pointNum = [[UILabel alloc] init];
        self.pointNum.textColor = RGB(212, 39, 82);
        self.pointNum.font = [UIFont systemFontOfSize:15];
        self.pointNum.userInteractionEnabled = YES;
        self.pointNum.text = @"0";
        [self addSubview:self.pointNum];
        [self.pointNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.pointLab.mas_right).offset(14);
            make.centerY.equalTo(wSelf.pointCoin).offset(0);
            make.width.offset(180);
            make.height.offset(15);
        }];
        
  
        _incomeCoin = [[UIImageView alloc] init];
        _incomeCoin.image = [UIImage imageNamed:@"income-5"];
        _incomeCoin.userInteractionEnabled = YES;
        [self addSubview:_incomeCoin];
        [_incomeCoin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.pointCoin.mas_bottom).offset(12);
            make.height.offset(14);
            make.width.offset(14);
            make.left.equalTo(wSelf).offset(23);
        }];
        
        self.incomeLab = [[UILabel alloc] init];
        self.incomeLab.textColor = RGB(102, 102, 102);
        self.incomeLab.text = @"income";
        self.incomeLab.font = [UIFont systemFontOfSize:10];
        self.incomeLab.userInteractionEnabled = YES;
        [self addSubview:self.incomeLab];
        [self.incomeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.incomeCoin.mas_right).offset(7);
            make.centerY.equalTo(wSelf.incomeCoin).offset(0);
            make.width.offset(40);
            make.height.offset(11);
        }];
        
        
        self.incomeNum = [[UILabel alloc] init];
        self.incomeNum.textColor = RGB(212, 39, 82);
        self.incomeNum.font = [UIFont systemFontOfSize:14];
        self.incomeNum.userInteractionEnabled = YES;
        self.incomeNum.text = @"0";
        [self addSubview:self.incomeNum];
        [self.incomeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.incomeLab.mas_right).offset(14);
            make.centerY.equalTo(wSelf.incomeCoin).offset(0);
            make.width.offset(180);
            make.height.offset(15);
        }];
        
        _buyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _buyBtn.layer.masksToBounds = YES;
        _buyBtn.layer.cornerRadius = 6;
        _buyBtn.backgroundColor = RGB(212, 39, 82);
        [_buyBtn setTitle:@"Buy Point" forState:(UIControlStateNormal)];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
//        [_buyBtn addTarget:self action:@selector(invitaAciton) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_buyBtn ];
        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.pointLab.mas_top).offset(0);
            make.bottom.equalTo(wSelf.incomeLab.mas_bottom).offset(0);
            make.width.offset(112);
            make.right.equalTo(wSelf.mas_right).offset(-33);
        }];
        
        
        self.gzLab = [[UILabel alloc] init];
//        self.gzLab 
        self.gzLab.textColor = RGB(102, 102, 102);
        self.gzLab.text = @"follow";
        self.gzLab.textAlignment = NSTextAlignmentCenter;
        self.gzLab.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.gzLab];
        [self.gzLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(73);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-52);
            make.width.offset(40);
            make.height.offset(11);
        }];
        
        
        _gzBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _gzBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _gzBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _gzBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_gzBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [_gzBtn addTarget:self action:@selector(gzAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_gzBtn ];
        [_gzBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(21);
            make.centerX.equalTo(wSelf.gzLab);
            make.width.offset(100);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-26);
        }];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(153, 153, 153);
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wSelf.mas_bottom).offset(-26);
            make.centerX.equalTo(wSelf);
            make.height.offset(30);
            make.width.offset(1);
        }];

        
        self.fsLab = [[UILabel alloc] init];
        self.fsLab.textColor = RGB(102, 102, 102);
        self.fsLab.font = [UIFont systemFontOfSize:10];
        self.fsLab.textAlignment = NSTextAlignmentCenter;
        self.fsLab.text = @"following";
        [self addSubview:self.fsLab];
        [self.fsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.mas_right).offset(-73);
            make.centerY.equalTo(wSelf.gzLab);
            make.width.offset(55);
            make.height.offset(11);
        }];
        

        _fsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _fsBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _fsBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _fsBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_fsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[_gzBtn addTarget:self action:@selector(gzAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_fsBtn ];
        [_fsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.offset(21);
            make.centerY.equalTo(wSelf.gzBtn);
            make.width.offset(100);
            make.centerX.equalTo(wSelf.fsLab);
        }];
        
        
    }
    return self;
}
@end
