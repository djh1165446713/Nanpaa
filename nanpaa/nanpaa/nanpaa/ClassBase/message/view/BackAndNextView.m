//
//  BackAndNextView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/28.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "BackAndNextView.h"

@implementation BackAndNextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        ______WS();

        
        _alphaView = [[UIView alloc] init];
        _alphaView.alpha = 0.5;
        _alphaView.backgroundColor = RGB(49, 56, 93);
        [self addSubview:_alphaView];
        [_alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(0);
            make.right.equalTo(wSelf).offset(0);
            make.bottom.equalTo(wSelf.mas_bottom).offset(0);
            make.top.equalTo(wSelf.mas_top).offset(0);
        }];
        
        _backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backButton setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        [self addSubview:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(20);
            make.centerY.equalTo(wSelf);
            make.width.height.offset(30);
        }];
        
        _nextButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_nextButton setTitle:@"Next" forState:(UIControlStateNormal)];
        [_nextButton setTitleColor:RGB(200, 39, 81) forState:(UIControlStateNormal)];
        _nextButton.backgroundColor = [UIColor clearColor];
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 8;
        [_nextButton.layer setBorderColor:RGB(200, 39, 81).CGColor];
        _nextButton.layer.borderWidth = 1;
        [self addSubview:_nextButton];
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wSelf.backButton);
            make.height.offset(40);
            make.right.equalTo(wSelf.mas_right).offset(-20);
            make.width.offset(110);
            
        }];
    }
    return self;
}

@end
