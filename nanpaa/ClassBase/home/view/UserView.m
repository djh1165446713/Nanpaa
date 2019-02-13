//
//  UserView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/2.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "UserView.h"

@implementation UserView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    if ([super initWithFrame:frame]) {
        ______WS();
        self.backgroundColor = RGB(37, 41, 74);
        _headImg = [[UIImageView alloc] init];
        _headImg.layer.masksToBounds = YES;
        _headImg.layer.cornerRadius = 20;
        _headImg.userInteractionEnabled = YES;
        [self addSubview:_headImg];
        [_headImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(5);
            make.centerY.equalTo(wSelf);
            make.width.height.offset(40);
        }];
        
        
        _iconImg = [[UIImageView alloc] init];
        _iconImg.layer.masksToBounds = YES;
        _iconImg.image = [UIImage imageNamed:@"qianvideo"];
        _iconImg.layer.cornerRadius = 12;
        [self addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.headImg.mas_right).offset(5);
            make.centerY.equalTo(wSelf);
            make.width.height.offset(24);
        }];
        
        _lockBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _lockBtn.backgroundColor = [UIColor clearColor];
        [_lockBtn setTitleColor:RGB(212, 39, 82) forState:(UIControlStateNormal)];
        [self addSubview:_lockBtn];
        [_lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.iconImg.mas_right).offset(5);
            make.centerY.equalTo(wSelf);
            make.width.offset(194);
            make.height.offset(20);
        }];
        
        
        
        _coinLab = [[UILabel alloc] init];
        _coinLab.font = [UIFont systemFontOfSize:13];
        _coinLab.textColor = RGB(212, 39, 82);
        _coinLab.text = @"0";
        [self addSubview:_coinLab];
        [_coinLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.iconImg.mas_right).offset(8);
            make.centerY.equalTo(wSelf);
            make.width.offset(50);
            make.height.offset(12);
        }];
        
        
        _replyButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _replyButton.backgroundColor = RGB(37, 41, 74);
        [_replyButton setImage:[UIImage imageNamed:@"reply"] forState:(UIControlStateNormal)];
        [self addSubview:_replyButton];
        [_replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.mas_right).offset(-10);
            make.centerY.equalTo(wSelf);
            make.width.height.offset(30);

        }];
        
    }
    return self;
}

@end
