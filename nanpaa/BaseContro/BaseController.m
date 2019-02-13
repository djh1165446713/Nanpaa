//
//  BaseController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ______WS();
    self.view.backgroundColor = RGB(18, 21, 33);

    _bgImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds ];
    _bgImg.backgroundColor = RGB(49, 56, 93);
    [self.view addSubview:_bgImg];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = RGB(49, 56, 93);
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.view).offset(0);
        make.height.offset(64);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.bgView);
        make.bottom.equalTo(wSelf.bgView.mas_bottom).offset(-16);
        make.width.offset(280);
        make.height.offset(20);
    }];
    
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.bgView).offset(0);
        make.bottom.equalTo(wSelf.bgView.mas_bottom).offset(-16);
        make.width.offset(50);
        make.height.offset(24);
    }];
    
    _rightNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rightNavBtn.hidden = YES;
    [_bgView addSubview:_rightNavBtn];
    [_rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.bgView.mas_right).offset(-15);
        make.top.equalTo(wSelf.bgView).offset(25);
        make.width.offset(50);
        make.height.offset(24);
    }];
    
}

#pragma mark --- 自定义方法
- (void)backAction {
    if (self.navigationController == NULL) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self.navigationController popViewControllerAnimated:YES];

    }
}


@end
