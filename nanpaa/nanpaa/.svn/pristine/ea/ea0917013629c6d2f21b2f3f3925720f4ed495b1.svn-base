
//
//  FollowSonView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/12/22.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "FollowSonView.h"

@implementation FollowSonView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        ______WS();
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(102, 102, 102);
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.top.equalTo(wSelf.mas_top).offset(0.5);
            make.width.offset(kScreenWidth);
            make.height.offset(0.5);

        }];
        
        
        self.label = [[UILabel alloc] init];
        self.label.textColor = RGB(223, 63, 101);
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.text = @"Want more fans?";
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf);
            make.top.equalTo(wSelf.mas_top).offset(18);
            make.width.offset(kScreenWidth);
            make.height.offset(15);
        }];
        
        self.shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.shareButton setTitle:@"Share yourself" forState:(UIControlStateNormal)];
        self.shareButton.layer.masksToBounds = YES;
        self.shareButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.shareButton.layer setBorderColor:RGB(223, 63, 101).CGColor];
        [self.shareButton setTitleColor:RGB(227, 88, 122) forState:(UIControlStateNormal)];
        self.shareButton.layer.borderWidth = 1;
        self.shareButton.layer.cornerRadius = 8;
        [self addSubview:self.shareButton];
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.mas_top).offset(48);
            make.right.equalTo(wSelf.mas_centerX).offset(-6);
            make.left.equalTo(wSelf.mas_left).offset(16);
            make.width.offset(162);
            make.height.offset(45);
        }];
        
        self.recommendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.recommendButton setTitle:@"See recommend list" forState:(UIControlStateNormal)];
        self.recommendButton.layer.masksToBounds = YES;
        self.recommendButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.recommendButton.layer setBorderColor:RGB(223, 63, 101).CGColor];
        [self.recommendButton setTitleColor:RGB(223, 63, 101) forState:(UIControlStateNormal)];
        self.recommendButton.layer.borderWidth = 1;
        self.recommendButton.layer.masksToBounds = YES;
        self.recommendButton.layer.cornerRadius = 8;
        [self addSubview:self.recommendButton];
        [self.recommendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.mas_top).offset(48);
            make.left.equalTo(wSelf.mas_centerX).offset(6);
            make.right.equalTo(wSelf.mas_right).offset(-16);
            make.width.offset(162);
            make.height.offset(45);
        }];
        
    }
    return self;
}


@end
