//
//  NearbyView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/25.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "NearbyView.h"

@implementation NearbyView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        ______WS();
        self.backgroundColor =  RGB(38, 42, 74);
        self.userInteractionEnabled = YES;
        _bgView = [[UIView alloc] init];
        _bgView.layer.borderWidth = 1;
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.userInteractionEnabled = YES;
        _bgView.layer.cornerRadius = 10;
        [_bgView.layer setBorderColor:RGB(212, 39, 82).CGColor];
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf).offset(20);
            make.right.equalTo(wSelf.mas_right).offset(-20);
            make.bottom.equalTo(wSelf.mas_bottom).offset(-8);
            make.height.offset(35);
        }];
        
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"search top"];
        _leftImg.hidden = YES;
        [_bgView addSubview:_leftImg];
        [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.bgView).offset(9);
            make.centerY.equalTo(wSelf.bgView);
            make.width.height.offset(35 / 2);
        }];
        
  
        _searchText = [[UITextField alloc] init];
        _searchText.layer.cornerRadius = 12;
        _searchText.keyboardAppearance = UISearchBarIconSearch;
        [_bgView addSubview:_searchText];
        [_searchText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wSelf.leftImg.mas_right).offset(5);
            make.right.equalTo(wSelf.mas_right).offset(-20);
            make.height.offset(35);
            make.bottom.equalTo(wSelf.bgView.mas_bottom).offset(0);
        }];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = RGB(212, 39, 82);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"Search";
        [_bgView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(wSelf.bgView);
            make.centerY.equalTo(wSelf.searchText);
            make.height.offset(35 / 2);
            make.width.offset(80);
        }];
        _rightImg = [[UIImageView alloc] init];
        _rightImg.image = [UIImage imageNamed:@"cancel"];
        _rightImg.userInteractionEnabled = YES;
        _rightImg.hidden = YES;
        [_bgView addSubview:_rightImg];
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.bgView.mas_right).offset(-9);
            make.centerY.equalTo(wSelf.bgView);
            make.width.height.offset(35 / 2);
        }];
        
        
        _iconImg = [[UIImageView alloc] init];
        _iconImg.image = [UIImage imageNamed:@"search top"];
        [_bgView addSubview:_iconImg];
        [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wSelf.titleLab.mas_left).offset(-5);
            make.width.height.offset(35 / 2);
            make.centerY.equalTo(wSelf.searchText);
        }];
    }
    return self;
}

@end
